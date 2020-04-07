package main

import "core:os"
import "core:fmt"
import "shared:engine/gfx"
import "shared:engine/maf"
import "shared:engine/libs/sdl"
import "shared:engine/libs/fna"
import "shared:engine/libs/imgui"

device: ^fna.Device;
vbuff: ^fna.Buffer;
effect: ^fna.Effect;
vert_decl: fna.Vertex_Declaration;

main :: proc() {
	sdl.set_hint("FNA3D_FORCE_DRIVER", "OpenGL");
	sdl.init(sdl.Init_Flags.Everything);

	window_attrs := fna.prepare_window_attributes();
	window := sdl.create_window("Odin + FNA + SDL + OpenGL", i32(sdl.Window_Pos.Undefined), i32(sdl.Window_Pos.Undefined), 640, 480, cast(sdl.Window_Flags)window_attrs);

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
	fna_gl_txt := sdl.gl_get_current_context();

	blend := fna.Blend_State{
		.Source_Alpha, .Inverse_Source_Alpha, .Add,
		.Source_Alpha, .Inverse_Source_Alpha, .Add,
		.All, .All, .All, .All, fna.Color{255, 255, 255, 255}, -1
	};
	fna.set_blend_state(device, &blend);


	// hack in a quad to test with. ImGui doesnt work once we do this...
	gfx.fna_device = device;
	prepper();


	imgui.create_context();
	io := imgui.get_io();
	io.config_flags |= .DockingEnable;
	io.config_flags |= .ViewportsEnable;

	style := imgui.get_style();
	if int(io.config_flags & .ViewportsEnable) != 0 {
		style.window_rounding = 0;
		style.colors[2].w = 1.0;
	}

	imgui.impl_init_for_gl2(window, fna_gl_txt);


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

		fna.begin_frame(device);
		fna.clear(device, fna.Clear_Options.Target, &color, 0, 0);

		// draw FNA stuff
		fna.apply_vertex_buffer_bindings(device, &vert_buff_binding, 1, 0, 0);
		fna.draw_indexed_primitives(device, .Triangle_List, 0, 0, 4, 0, 2, ibuff, ._16_Bit);

		imgui.impl_new_frame2(window);
		imgui.im_text("whatever");
		imgui.bullet();
		imgui.im_text("whatever");
		imgui.bullet();
		imgui.im_text("whatever");
		imgui.render();
		imgui.impl_render2();

		if int(io.config_flags & .ViewportsEnable) != 0 {
			imgui.update_platform_windows();
			imgui.render_platform_windows_default();
			sdl.gl_make_current(window, fna_gl_txt);
		}

		fna.swap_buffers(device, nil, nil, params.device_window_handle);
	}
}




ibuff: ^fna.Buffer;
texture: ^fna.Texture;
vert_buff_binding: fna.Vertex_Buffer_Binding;

prepper :: proc() {
	create_texture();
	vert_decl := gfx.vertex_decl_for_type(gfx.Vert_Pos_Tex_Col);

	// buffers
	vertices := [?]gfx.Vert_Pos_Tex_Col{
		{{+100.5, -100.5}, {1.0, 0.0}, 0xFF0099FF},
		{{-200.5, -100.5}, {0.0, 0.0}, 0xFFFFFFFF},
		{{-200.5, +100.5}, {0.0, 1.0}, 0xFFFFFFFF},
		{{+100.5, +100.5}, {1.0, 1.0}, 0xFFFF99FF}
	};

	vbuff = gfx.new_vert_buffer_from_type(gfx.Vert_Pos_Tex_Col, len(vertices));
	gfx.set_vertex_buffer_data(vbuff, &vertices);

	indices := [?]i16{0, 1, 2, 2, 3, 0};
	ibuff = gfx.new_index_buffer(len(indices));
	gfx.set_index_buffer_data(ibuff, &indices);

	b := fna.Buffer{};
	gfx.set_index_buffer_data(&b, &indices);

	// // bindings
	vert_buff_binding = fna.Vertex_Buffer_Binding{vbuff, vert_decl, 0, 0};

	// load an effect
	shader := gfx.new_shader("effects/VertexColorTexture.fxb");
	transform := maf.mat32_ortho(640, 480);
	gfx.shader_set_mat32(shader, "TransformMatrix", &transform);
	gfx.shader_apply(shader);
}

create_texture :: proc() {
	pixels := [?]u32 {0xFFFFFFFF, 0xFF000000, 0xFFFFFFFF, 0xFF000000,
		0xFF000000, 0xFFFFFFFF, 0xFF000000, 0xFFFFFFFF,
		0xFFFFFFFF, 0xFF000000, 0xFFFFFFFF, 0xFF000000,
		0xFF000000, 0xFFFFFFFF, 0xFF000000, 0xFFFFFFFF};

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

