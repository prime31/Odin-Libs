package main

import "core:os"
import "core:fmt"
import "shared:engine/gfx"
import "shared:engine/maf"
import "shared:engine/libs/sdl"
import "shared:engine/libs/fna"
import "shared:engine/libs/imgui"
import "shared:engine/libs/flextgl"

device: ^fna.Device;
shader: ^gfx.Shader;
texture: ^fna.Texture;

// this gets ImGui working with opengl 2 with viewports on metal and opengl. You have to drag the invisible ImGui window
// out of the small black window to get it working.
main :: proc() {
	// sdl.set_hint("FNA3D_FORCE_DRIVER", "OpenGL");
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
		scissor_test_enable = 0
	};
	fna.apply_rasterizer_state(device, &rasterizer_state);

	depth_stencil := fna.Depth_Stencil_State{
		depth_buffer_enable = 0,
		stencil_enable = 0
	};
	fna.set_depth_stencil_state(device, &depth_stencil);

	vp := fna.Viewport{0, 0, 640, 480, 0, 1};
	fna.set_viewport(device, &vp);


	// hack in a quad to test with.
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

	fna_gl_ctx := sdl.gl_get_current_context();
	gl_win, gl_ctx := create_gl_window();
	sdl.gl_make_current(gl_win, gl_ctx);
	flextgl.init();
	imgui.impl_init_for_gl("#version 120", gl_win, gl_ctx);
	imgui.impl_init_for_gl2(gl_win, gl_ctx);

	color := fna.Vec4 {1, 0, 0, 1};
	running := true;
	for running {
		e: sdl.Event;
		for sdl.poll_event(&e) != 0 {
			// if imgui.impl_handle_event(&e) do continue;
			if e.type == sdl.Event_Type.Quit {
				running = false;
			}
		}

		g := color.y + 0.01;
		color.y = g > 1.0 ? 0.0 : g;

		if fna_gl_ctx != nil do sdl.gl_make_current(window, fna_gl_ctx);
		fna.begin_frame(device);
		fna.clear(device, fna.Clear_Options.Target, &color, 0, 0);

		// draw FNA stuff
		draw_quad();

		// imgui
		sdl.gl_make_current(gl_win, gl_ctx);
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
		}

		if fna_gl_ctx != nil { sdl.gl_make_current(window, fna_gl_ctx); } else { sdl.gl_make_current(gl_win, gl_ctx); }

		fna.swap_buffers(device, nil, nil, params.device_window_handle);
	}
}

create_gl_window :: proc() -> (^sdl.Window, sdl.GL_Context) {
	window := sdl.create_window("Window Dos", i32(sdl.Window_Pos.Undefined), i32(sdl.Window_Pos.Undefined), 150, 150, .Open_GL | .Borderless);

	// sdl.gl_set_attribute(sdl.GL_Attr.Context_Flags, i32(sdl.GL_Context_Flag.Forward_Compatible));
	// sdl.gl_set_attribute(sdl.GL_Attr.Context_Profile_Mask, i32(sdl.GL_Context_Profile.Core));
	// sdl.gl_set_attribute(sdl.GL_Attr.Context_Major_Version, 3);
	// sdl.gl_set_attribute(sdl.GL_Attr.Context_Minor_Version, 3);

	// sdl.gl_set_attribute(sdl.GL_Attr.Doublebuffer, 1);
	// sdl.gl_set_attribute(sdl.GL_Attr.Depth_Size, 24);
	// sdl.gl_set_attribute(sdl.GL_Attr.Stencil_Size, 8);

	return window, sdl.gl_create_context(window);
}




ibuff: ^fna.Buffer;
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
	gfx.shader_apply(shader);

	fna.apply_vertex_buffer_bindings(device, &vert_buff_binding, 1, 0, 0);
	fna.draw_indexed_primitives(device, .Triangle_List, 0, 0, 4, 0, 2, ibuff, ._16_Bit);
}

prepper :: proc() {
	create_texture();
	vert_decl := gfx.vertex_decl_for_type(gfx.Vertex);

	// buffers
	vertices := [?]gfx.Vertex{
		{{+100.5, -100.5}, {1.0, 0.0}, 0xFF0099FF},
		{{-200.5, -100.5}, {0.0, 0.0}, 0xFFFFFFFF},
		{{-200.5, +100.5}, {0.0, 1.0}, 0xFFFFFFFF},
		{{+100.5, +100.5}, {1.0, 1.0}, 0xFFFF99FF}
	};

	vbuff := gfx.new_vert_buffer_from_type(gfx.Vertex, len(vertices));
	gfx.set_vertex_buffer_data(vbuff, &vertices);

	indices := [?]i16{0, 1, 2, 2, 3, 0};
	ibuff = gfx.new_index_buffer(len(indices));
	gfx.set_index_buffer_data(ibuff, &indices);

	// // bindings
	vert_buff_binding = fna.Vertex_Buffer_Binding{vbuff, vert_decl, 0, 0};

	// load an effect
	shader = gfx.new_shader("effects/VertexColorTexture.fxb");
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
		filter = .Point,
		max_anisotropy = 4
	};

	fna.verify_sampler(device, 0, texture, &sampler_state);
}

