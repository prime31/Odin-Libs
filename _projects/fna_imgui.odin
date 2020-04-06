package main

import "core:os"
import "core:fmt"
import "core:mem"
import "core:math"
import "core:math/linalg"
import "shared:engine/libs/sdl"
import "shared:engine/libs/stb_image"
import "shared:engine/libs/fna"
import "shared:engine/libs/imgui"

Vertex :: struct {
	pos: [2]f32,
	uv: [2]f32,
	col: u32
};

device: ^fna.Device;
effect: ^fna.Effect;
mojo_effect: ^fna.Mojoshader_Effect;
vert_decl: fna.Vertex_Declaration;
texture: ^fna.Texture;

main :: proc() {
	sdl.set_hint("FNA3D_FORCE_DRIVER", "OpenGL");
	window := create_window();

	params := fna.Presentation_Parameters{
		back_buffer_width = 640,
		back_buffer_height = 480,
		back_buffer_format = fna.Surface_Format.Color,
		multi_sample_count = 0,
		device_window_handle = window,
		is_full_screen = 0,
		depth_stencil_format = fna.Depth_Format.D24_S8,
		presentation_interval = fna.Present_Interval.Default,
		display_orientation = fna.Display_Orientation.Default,
		render_target_usage = fna.Render_Target_Usage.Discard_Contents
	};
	device = fna.create_device(&params, 0);
	fna.set_presentation_interval(device, .One);

	// alpha blend
	blend := fna.Blend_State{
		.Source_Alpha, .Inverse_Source_Alpha, .Add,
		.Source_Alpha, .Inverse_Source_Alpha, .Add,
		.All, .All, .All, .All, fna.Color{255, 255, 255, 255}, -1
	};
	fna.set_blend_state(device, &blend);

	prepper();
	create_texture();
	prepare_imgui();

	color := fna.Vec4 {1, 0, 0, 1};
	running := true;
	for running {
		e: sdl.Event;
		for sdl.poll_event(&e) != 0 {
			if imgui.impl_handle_event(&e) do continue;
			if e.type == sdl.Event_Type.Quit {
				running = false;
			}
		}

		g := color.y + 0.01;
		color.y = g > 1.0 ? 0.0 : g;

		vp := fna.Viewport{0, 0, 640, 480, -1, 1};
		fna.set_viewport(device, &vp);

		fna.begin_frame(device);
		fna.clear(device, fna.Clear_Options.Target, &color, 0, 0);

		// fmt.println("using technique: ", effect.mojo_effect.current_technique.name);
		state_changes := fna.Mojoshader_Effect_State_Changes{};
		fna.apply_effect(device, effect, mojo_effect.current_technique, 0, &state_changes);

		// vertices := [?]Vertex{
		// 	{{+0.5, +0.5}, {1.0, 1.0}, 0xFF0099FF}, // ABGR
		// 	{{+0.5, -0.5}, {1.0, 0.0}, 0xFFFFFFFF},
		// 	{{-0.5, -0.5}, {0.0, 0.0}, 0xFFFFFFFF},
		// 	{{-0.5, -0.5}, {0.0, 0.0}, 0xFFFFFFFF},
		// 	{{-0.5, +0.5}, {0.0, 1.0}, 0xFFFFFFFF},
		// 	{{+0.5, +0.5}, {1.0, 1.0}, 0xFF0099FF},
		// };

		// fna.apply_vertex_declaration(device, &vert_decl, &vertices, 0);
		// fna.draw_primitives(device, .Triangle_List, 0, 2);


		width, height : i32;
		fna.get_drawable_size(params.device_window_handle, &width, &height);
		io := imgui.get_io();
		io.display_size = imgui.Vec2{cast(f32)width, cast(f32)height};

		imgui.new_frame();
		imgui.im_text("whatever");
		imgui.bullet();
		imgui.im_text("whatever");
		imgui.bullet();
		imgui.im_text("whatever");
		imgui.render();
		imgui_render();

		fna.swap_buffers(device, nil, nil, params.device_window_handle);
	}
}

prepper :: proc() {
	vert_elements := make([]fna.Vertex_Element, 3);
	vert_elements[0] = fna.Vertex_Element{
		offset = 0,
		vertex_element_format = .Vector2,
		vertex_element_usage = .Position,
		usage_index = 0
	};

	vert_elements[1] = fna.Vertex_Element{
		offset = 8,
		vertex_element_format = .Vector2,
		vertex_element_usage = .Texture_Coordinate,
		usage_index = 0
	};

	vert_elements[2] = fna.Vertex_Element{
		offset = 16,
		vertex_element_format = .Color,
		vertex_element_usage = .Color,
		usage_index = 0
	};

	vert_decl = fna.Vertex_Declaration{
		vertex_stride = get_vertex_stride(vert_elements),
		element_count = 3,
		elements = &vert_elements[0]
	};

	// load an effect
	// TODO: rendering needs to use new shader code with TransformMatrix
	// data, success := os.read_entire_file("assets/VertexColorTexture.fxb");
	data, success := os.read_entire_file("assets/Noise.fxb");
	defer if success { delete(data); }

	fna.create_effect(device, &data[0], cast(u32)len(data), &effect, &mojo_effect);
	//fmt.println("effect:", effect, "mojo_effect:", mojo_effect);

	// params := mem.slice_ptr(effect.mojo_effect.params, cast(int)effect.mojo_effect.param_count);
	// for param in params {
	// 	fmt.println("param", param);
	// }
}

get_vertex_stride :: proc(elements: []fna.Vertex_Element) -> i32 {
	max:i32 = 0;
	for ele in elements {
		start := ele.offset + get_type_size(ele.vertex_element_format);
		if max < start do max = start;
	}
	return max;
}

get_type_size :: proc(type: fna.Vertex_Element_Format) -> i32 {
	#partial switch type {
		case fna.Vertex_Element_Format.Color: return 4;
		case fna.Vertex_Element_Format.Vector2: return 8;
		case fna.Vertex_Element_Format.Vector3: return 12;
		case fna.Vertex_Element_Format.Vector4: return 16;
	}
	return -1;
}

create_texture :: proc() {
	pixels := [?]u32 {0xFFFFFFFF, 0x00000000, 0xFFFFFFFF, 0x00000000,
		0x00000000, 0xFFFFFFFF, 0x00000000, 0xFFFFFFFF,
		0xFFFFFFFF, 0x00000000, 0xFFFFFFFF, 0x00000000,
		0x00000000, 0xFFFFFFFF, 0x00000000, 0xFFFFFFFF};

	texture = fna.create_texture_2d(device, .Color, 4, 4, 1, 0);
	fna.set_texture_data_2d(device, texture, .Color, 0, 0, 4, 4, 0, &pixels, size_of(pixels));

	sampler_state := fna.Sampler_State{
		address_u = .Wrap,
		address_v = .Wrap,
		address_w = .Wrap,
		filter = .Point,
		max_anisotropy = 4,
		max_mip_level = 0,
		mip_map_level_of_detail_bias = 0
	};

	fna.verify_sampler(device, 0, texture, &sampler_state);
}

create_window :: proc() -> ^sdl.Window {
	sdl.init(sdl.Init_Flags.Everything);

	window_attrs := fna.prepare_window_attributes();
	window := sdl.create_window("Odin + FNA + SDL + OpenGL", i32(sdl.Window_Pos.Undefined), i32(sdl.Window_Pos.Undefined), 640, 480, cast(sdl.Window_Flags)window_attrs);

	return window;
}



imgui_tex: ^fna.Texture;
imgui_vert_decl: fna.Vertex_Declaration;
imgui_rasterizer_state: fna.Rasterizer_State;
imgui_vert_buffer_size: i32;
imgui_vert_buffer: ^fna.Buffer;
imgui_index_buffer_size: i32;
imgui_index_buffer: ^fna.Buffer;
imgui_vert_buffer_binding: fna.Vertex_Buffer_Binding;

imgui_render :: proc() {
	io := imgui.get_io();
	draw_data := imgui.get_draw_data();
	if draw_data.total_vtx_count == 0 do return;

	imgui.draw_data_scale_clip_rects(draw_data, io.display_framebuffer_scale);
	imgui_update_buffers(draw_data);

    width  := i32(draw_data.display_size.x * io.display_framebuffer_scale.x);
    height := i32(draw_data.display_size.y * io.display_framebuffer_scale.y);

    imgui_vert_buffer_binding := fna.Vertex_Buffer_Binding{imgui_vert_buffer, imgui_vert_decl, 0, 0};
	bindings_updated: u8 = 1;

	L : f32 = draw_data.display_pos.x;
	R : f32 = draw_data.display_pos.x + draw_data.display_size.x;
	T : f32 = draw_data.display_pos.y;
	B : f32 = draw_data.display_pos.y + draw_data.display_size.y;
	ortho_projection := linalg.Matrix4{
		{ 2.0/(R-L),   0.0,          0.0, 0.0 },
		{ 0.0,         2.0 / (T-B),  0.0, 0.0 },
		{ 0.0,         0.0,         -1.0, 0.0 },
		{ (R+L)/(L-R), (T+B)/(B-T),  0.0, 1.0 },
	};


	new_list := mem.slice_ptr(draw_data.cmd_lists, int(draw_data.cmd_lists_count));
	for list in new_list {
		// translate on CPU for now
		tmp_verts := mem.slice_ptr(list.vtx_buffer.data, cast(int)list.vtx_buffer.size);
		for i in 0..<len(tmp_verts) {
			temp_vec4 := linalg.Vector4{tmp_verts[i].pos.x, tmp_verts[i].pos.y, 0, 1};
			temp_vec4 = linalg.matrix_mul_vector(ortho_projection, temp_vec4);
			tmp_verts[i].pos.x = temp_vec4.x;
			tmp_verts[i].pos.y = temp_vec4.y;
		}

		fna.set_vertex_buffer_data(device, imgui_vert_buffer, 0, list.vtx_buffer.data, list.vtx_buffer.size * size_of(imgui.DrawVert), .None);
		fna.set_index_buffer_data(device, imgui_index_buffer, 0, list.idx_buffer.data, list.idx_buffer.size * size_of(imgui.DrawIdx), .None);

		pos := draw_data.display_pos;
        cmds := mem.slice_ptr(list.cmd_buffer.data, int(list.cmd_buffer.size));
        for cmd, idx in cmds {
            if cmd.user_callback != nil {
            	// the magic reset call back is cmd.user_callback: ImDrawCallback_ResetRenderState which is -1
            	if cast(uintptr)cast(rawptr)cmd.user_callback == ~uintptr(0) {
            		fmt.panicf("imgui panic. reset state detected");
            	} else {
            		cmd.user_callback(list, &cmds[idx]);
            	}
            } else {
                clip := imgui.Vec4{
                    cmd.clip_rect.x - pos.x,
                    cmd.clip_rect.y - pos.y,
                    cmd.clip_rect.z - pos.x,
                    cmd.clip_rect.w - pos.y
                };

                if clip.x < f32(width) && clip.y < f32(height) && clip.z >= 0 && clip.w >= 0 {
                	clip_rect := fna.Rect{i32(clip.x), height - i32(clip.w), i32(clip.z - clip.x), i32(clip.w - clip.y)};
                	fna.set_scissor_rect(device, &clip_rect);

                	sampler_state := fna.Sampler_State{};
                	fna.verify_sampler(device, 0, cast(^fna.Texture)cmd.texture_id, &sampler_state);

                	fna.apply_vertex_buffer_bindings(device, &imgui_vert_buffer_binding, 1, bindings_updated, cast(i32)cmd.vtx_offset);
                	fna.draw_indexed_primitives(device, .Triangle_List, cast(i32)cmd.vtx_offset, 0, list.vtx_buffer.size, cast(i32)cmd.idx_offset, cast(i32)cmd.elem_count / 3, imgui_index_buffer, ._16_Bit);
                	bindings_updated = 0;
                }
            }
        } // for cmd, idx in cmds
	} // for list in new_list
}

imgui_update_buffers :: proc(draw_data: ^imgui.DrawData) {
	if draw_data.total_vtx_count == 0 do return;

	// Expand buffers if we need more room
	if draw_data.total_vtx_count > imgui_vert_buffer_size {
		fmt.println("Regenerating vertex buffer");
		imgui_vert_buffer_size = cast(i32)(cast(f32)draw_data.total_vtx_count * 1.5);
		imgui_vert_buffer = fna.gen_vertex_buffer(device, 0, .Write_Only, imgui_vert_buffer_size, imgui_vert_decl.vertex_stride);
	}

	if draw_data.total_idx_count > imgui_index_buffer_size {
		fmt.println("Regenerating index buffer");
		imgui_index_buffer_size = cast(i32)(cast(f32)draw_data.total_idx_count * 1.5);
		imgui_index_buffer = fna.gen_index_buffer(device, 1, .Write_Only, imgui_index_buffer_size, ._16_Bit);
	}
}

prepare_imgui :: proc() {
	imgui_setup_vertex_declaration();

	imgui.create_context();
	io := imgui.get_io();
	io.config_flags |= .DockingEnable;
	io.config_flags |= .ViewportsEnable;

	imgui.style_colors_dark(imgui.get_style());

	imgui.font_atlas_add_font_default(io.fonts, nil);
	width, height : i32;
	pixels : ^u8;
	imgui.font_atlas_get_text_data_as_rgba32(io.fonts, &pixels, &width, &height);

	imgui_tex = fna.create_texture_2d(device, .Color, width, height, 1, 0);
	fna.set_texture_data_2d(device, imgui_tex, .Color, 0, 0, width, height, 0, pixels, width * height * size_of(pixels));

	// stb_image.write_png("/Users/mikedesaro/Desktop/font_atlas.png", int(width), int(height), 4, mem.slice_ptr(pixels, int(width * height)), 0);

	imgui.font_atlas_set_text_id(io.fonts, imgui_tex);
	imgui.font_atlas_clear_tex_data(io.fonts);
}

imgui_setup_vertex_declaration :: proc() {
	imgui_rasterizer_state = fna.Rasterizer_State{
		fill_mode = .Solid,
		cull_mode = .None,
		scissor_test_enable = 1
	};

	vert_elements := make([]fna.Vertex_Element, 3);
	vert_elements[0] = fna.Vertex_Element{
		offset = 0,
		vertex_element_format = .Vector2,
		vertex_element_usage = .Position,
		usage_index = 0
	};

	vert_elements[1] = fna.Vertex_Element{
		offset = 8,
		vertex_element_format = .Vector2,
		vertex_element_usage = .Texture_Coordinate,
		usage_index = 0
	};

	vert_elements[2] = fna.Vertex_Element{
		offset = 16,
		vertex_element_format = .Color,
		vertex_element_usage = .Color,
		usage_index = 0
	};


	imgui_vert_decl = fna.Vertex_Declaration{
		vertex_stride = get_vertex_stride(vert_elements),
		element_count = 3,
		elements = &vert_elements[0]
	};
}
