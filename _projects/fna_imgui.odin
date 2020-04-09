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
vert_decl: fna.Vertex_Declaration;
shader: ^gfx.Shader;

t:f32 = 0;

main :: proc() {
	// sdl.set_hint("FNA3D_FORCE_DRIVER", "OpenGL");
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
	imgui.imgui_init(device);

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


		draw_quad();


		imgui.imgui_render();

		fna.swap_buffers(device, nil, nil, params.device_window_handle);
	}
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
