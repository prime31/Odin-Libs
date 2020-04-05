package main

import "core:os"
import "core:fmt"
import "core:mem"
import "core:math"
import "shared:engine/gfx"
import "shared:engine/maf"
import "shared:engine/libs/sdl"
import "shared:engine/libs/stb_image"
import "shared:engine/libs/fna"

Vertex :: struct {
	pos: [2]f32,
	uv: [2]f32,
	col: u32
};

device: ^fna.Device;
vbuff: ^fna.Buffer;
ibuff: ^fna.Buffer;
texture: ^fna.Texture;
vert_buff_binding: fna.Vertex_Buffer_Binding;

main :: proc() {
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
	fna.set_presentation_interval(device, .One);

	rasterizer_state := fna.Rasterizer_State{
		fill_mode = .Solid,
		cull_mode = .None,
		scissor_test_enable = 1
	};
	fna.apply_rasterizer_state(device, &rasterizer_state);

	prepper();
	create_texture();

	color := fna.Vec4 {1, 0, 0, 1};
	running := true;
	for running {
		e: sdl.Event;
		for sdl.poll_event(&e) != 0 {
			if e.type == sdl.Event_Type.Quit {
				running = false;
			}
		}

		g := color.y + 0.01;
		color.y = g > 1.0 ? 0.0 : g;

		fna.begin_frame(device);
		fna.clear(device, fna.Clear_Options.Target, &color, 0, 0);

		// vertices := [?]Vertex{
		// 	{{+0.0, +0.0}, {1.0, 1.0}, 0xFF0099FF},
		// 	{{+0.0, -1.0}, {1.0, 0.0}, 0xFFFFFFFF},
		// 	{{-1.0, -1.0}, {0.0, 0.0}, 0xFFFFFFFF},
		// 	{{-1.0, -1.0}, {0.0, 0.0}, 0xFFFFFFFF},
		// 	{{-1.0, +0.0}, {0.0, 1.0}, 0xFFFF99FF},
		// 	{{+0.0, +0.0}, {1.0, 1.0}, 0xFFFF99FF}
		// };
		// fna.apply_vertex_declaration(device, &vert_buff_binding.vertex_declaration, &vertices, 0);
		// fna.draw_primitives(device, .Triangle_List, 0, 2);


		// either send an array or just one
		fna.apply_vertex_buffer_bindings(device, &vert_buff_binding, 1, 1, 0);
		fna.draw_indexed_primitives(device, .Triangle_List, 0, 0, 4, 0, 2, ibuff, ._16_Bit);
		fna.swap_buffers(device, nil, nil, params.device_window_handle);
	}
}

prepper :: proc() {
	gfx.fna_device = device;
	vert_decl := gfx.vertex_decl_for_type(gfx.Vert_Pos_Tex_Col);

	// buffers
	vertices := [?]gfx.Vert_Pos_Tex_Col{
		{{+0.5, -0.5}, {1.0, 1.0}, 0xFF0099FF},
		{{-0.5, -0.5}, {0.0, 1.0}, 0xFFFFFFFF},
		{{-0.5, +0.5}, {0.0, 0.0}, 0xFFFFFFFF},
		{{+0.5, +0.5}, {1.0, 0.0}, 0xFFFF99FF}
	};

	vbuff = gfx.new_vert_buffer_from_type(gfx.Vert_Pos_Tex_Col, len(vertices));
	gfx.set_vertex_buffer_data(vbuff, &vertices);

	indices := [?]i16{0, 1, 2, 2, 3, 0};
	ibuff = gfx.new_index_buffer(len(indices));
	gfx.set_index_buffer_data(ibuff, &indices);

	// bindings
    vert_buff_binding = fna.Vertex_Buffer_Binding{vbuff, vert_decl, 0, 0};

	// load an effect
	shader := gfx.new_shader("effects/VertexColorTexture.fxb");
	gfx.shader_apply(shader);
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

