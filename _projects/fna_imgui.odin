package main

import "core:os"
import "core:fmt"
import "core:mem"
import "core:math"
import "core:math/linalg"
import "shared:engine/gfx"
import "shared:engine/maf"
import "shared:engine/libs/sdl"
import "shared:engine/libs/stb_image"
import "shared:engine/libs/fna"
import "shared:engine/libs/imgui"


device: ^fna.Device;
effect: ^fna.Effect;
mojo_effect: ^fna.Mojoshader_Effect;
vert_decl: fna.Vertex_Declaration;
shader: ^gfx.Shader;

t:f32 = 0;

main :: proc() {
	sdl.set_hint("FNA3D_FORCE_DRIVER", "OpenGL");
	sdl.init(sdl.Init_Flags.Everything);
	window := sdl.create_window("Odin + FNA + SDL + OpenGL", i32(sdl.Window_Pos.Undefined), i32(sdl.Window_Pos.Undefined), 640, 480, cast(sdl.Window_Flags)fna.prepare_window_attributes());

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
	gfx.fna_device = device;
	fna.set_presentation_interval(device, .One);

	// alpha blend
	blend := fna.Blend_State{
		.Source_Alpha, .Inverse_Source_Alpha, .Add,
		.Source_Alpha, .Inverse_Source_Alpha, .Add,
		.All, .All, .All, .All, fna.Color{255, 255, 255, 255}, -1
	};
	fna.set_blend_state(device, &blend);

	rasterizer_state := fna.Rasterizer_State{
		fill_mode = .Solid,
		cull_mode = .None,
		scissor_test_enable = 1
	};
	fna.apply_rasterizer_state(device, &rasterizer_state);

	depth_stencil := fna.Depth_Stencil_State{
		depth_buffer_enable = 0,
		stencil_enable = 0
	};
	fna.set_depth_stencil_state(device, &depth_stencil);

	vp := fna.Viewport{0, 0, 640, 480, -1, 1};
	fna.set_viewport(device, &vp);

	quad_prepper();
	prepper();
	prepare_imgui();

	io := imgui.get_io();
	imgui.init(cast(^sdl.Window)params.device_window_handle);

	color := fna.Vec4 {1, 0, 0, 1};
	running := true;
	for running {
		e: sdl.Event;
		for sdl.poll_event(&e) != 0 {
			if imgui.handle_event(&e) do continue;
			if e.type == sdl.Event_Type.Quit {
				running = false;
			}
		}

		g := color.y + 0.01;
		color.y = g > 1.0 ? 0.0 : g;

		fna.begin_frame(device);
		fna.clear(device, fna.Clear_Options.Target, &color, 0, 0);



		width, height : i32;
		fna.get_drawable_size(params.device_window_handle, &width, &height);
		imgui.sdl_new_frame(cast(^sdl.Window)params.device_window_handle, width, height);

		imgui.new_frame();
		imgui.im_text("whatever");

		imgui.drag_float("Thing", &t);

		imgui.bullet();
		if imgui.button("Im a Button") do fmt.println("-------------- buttton");
		imgui.im_text("whatever");
		imgui.bullet();
		imgui.im_text("whatever");


		clip_rect := fna.Rect{0, 0, 640, 480};
		fna.set_scissor_rect(device, &clip_rect);
		draw_quad();

		imgui.render();
		imgui_render();

		fna.swap_buffers(device, nil, nil, params.device_window_handle);
	}
}

prepper :: proc() {
	vert_decl = gfx.vertex_decl_for_type(gfx.Vert_Pos_Tex_Col);

	shader = gfx.new_shader("assets/VertexColorTexture.fxb");
	transform := maf.mat32_ortho(640, 480);
	gfx.shader_set_mat32(shader, "TransformMatrix", &transform);
	gfx.shader_apply(shader);
}



imgui_tex: ^fna.Texture;
imgui_vert_decl: fna.Vertex_Declaration;
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

	bindings_updated: u8 = 1;
	imgui_vert_buffer_binding = fna.Vertex_Buffer_Binding{imgui_vert_buffer, imgui_vert_decl, 0, 0};


	new_list := mem.slice_ptr(draw_data.cmd_lists, int(draw_data.cmd_lists_count));
	for list in new_list {
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
				clip_rect := fna.Rect{
					cast(i32)cmd.clip_rect.x,
					cast(i32)cmd.clip_rect.y,
					cast(i32)(cmd.clip_rect.z - cmd.clip_rect.x),
					cast(i32)(cmd.clip_rect.w - cmd.clip_rect.y)
				};

				if clip_rect.x < width && clip_rect.y < height && clip_rect.h >= 0 && clip_rect.w >= 0 {
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
	imgui_vert_decl = gfx.vertex_decl_for_type(gfx.Vert_Pos_Tex_Col);

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





ibuff: ^fna.Buffer;
texture: ^fna.Texture;
quad_shader: ^gfx.Shader;
vert_buff_binding: fna.Vertex_Buffer_Binding;

draw_quad :: proc() {
	sampler_state := fna.Sampler_State{
		address_u = .Wrap,
		address_v = .Wrap,
		address_w = .Wrap,
		filter = .Point,
		max_anisotropy = 4
	};
	fna.verify_sampler(device, 0, texture, &sampler_state);
	gfx.shader_apply(quad_shader);

	fna.apply_vertex_buffer_bindings(device, &vert_buff_binding, 1, 0, 0);
	fna.draw_indexed_primitives(device, .Triangle_List, 0, 0, 4, 0, 2, ibuff, ._16_Bit);

	gfx.shader_apply(shader);
}

quad_prepper :: proc() {
	create_texture();
	vert_decl := gfx.vertex_decl_for_type(gfx.Vert_Pos_Tex_Col);

	// buffers
	vertices := [?]gfx.Vert_Pos_Tex_Col{
		{{220, 	20}, {1.0, 0.0}, 0xFF0099FF},
		{{20, 	20}, {0.0, 0.0}, 0xFFFFFFFF},
		{{20, 	220}, {0.0, 1.0}, 0xFFFFFFFF},
		{{220, 	220}, {1.0, 1.0}, 0xFFFF99FF}
	};

	vbuff := gfx.new_vert_buffer_from_type(gfx.Vert_Pos_Tex_Col, len(vertices));
	gfx.set_vertex_buffer_data(vbuff, &vertices);

	indices := [?]i16{0, 1, 2, 2, 3, 0};
	ibuff = gfx.new_index_buffer(len(indices));
	gfx.set_index_buffer_data(ibuff, &indices);

	// // bindings
	vert_buff_binding = fna.Vertex_Buffer_Binding{vbuff, vert_decl, 0, 0};

	// load an effect
	quad_shader = gfx.new_shader("effects/VertexColorTexture.fxb");
	transform := maf.mat32_ortho(640, 480);
	gfx.shader_set_mat32(quad_shader, "TransformMatrix", &transform);
}

create_texture :: proc() {
	pixels := [?]u32 {0xFFFFFFFF, 0xFF000000, 0xFFFFFFFF, 0xFF000000,
		0xFF000000, 0xFFFFFFFF, 0xFF000000, 0xFFFFFFFF,
		0xFFFFFFFF, 0xFF000000, 0xFFFFFFFF, 0xFF000000,
		0xFF000000, 0xFFFFFFFF, 0xFF000000, 0xFFFFFFFF};

	texture = fna.create_texture_2d(device, .Color, 4, 4, 1, 0);
	fna.set_texture_data_2d(device, texture, .Color, 0, 0, 4, 4, 0, &pixels, size_of(pixels));

	sampler_state := fna.Sampler_State{
		filter = .Point,
		max_anisotropy = 4
	};

	fna.verify_sampler(device, 0, texture, &sampler_state);
}
