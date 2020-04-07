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

	vp := fna.Viewport{0, 0, 640, 480, -1, 1};
	fna.set_viewport(device, &vp);

	prepper();
	create_texture();
	load_texture();

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


		// apply_vertex_buffer_bindings must be called with draw_*_primitives
		// apply_vertex_declaration must be called with draw_user_*_primitives
		fna.apply_vertex_buffer_bindings(device, &vert_buff_binding, 1, 0, 0);
		fna.draw_indexed_primitives(device, .Triangle_List, 0, 0, 4, 0, 2, ibuff, ._16_Bit);
		fna.swap_buffers(device, nil, nil, params.device_window_handle);
	}
}

prepper :: proc() {
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

	// bindings
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

load_texture :: proc() {
	file, err := os.open("assets/angular.png");
	if err != 0 do fmt.panicf("thanatos");

	width, height, len: i32;
	data := fna.image_load(image_read_fn, image_skip_fn, image_eof_fn, &file, &width, &height, &len, -1, -1, 0);
	defer { fna.image_free(data); }

	texture = fna.create_texture_2d(device, .Color, width, height, 1, 0);
	fna.set_texture_data_2d(device, texture, .Color, 0, 0, width, height, 0, data, width * height * size_of(data));

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


// fill 'data' with 'size' bytes. return number of bytes actually read
image_read_fn :: proc "c" (ctx: rawptr, data: ^byte, size: i32) -> i32 {
	int_ptr := cast(^int)ctx;
	file := cast(os.Handle)int_ptr^;

	bytes_read, read_err := os.read_ptr(file, data, cast(int)size);
	if read_err != os.ERROR_NONE do fmt.panicf("died reading file");

	return cast(i32)bytes_read;
}

// skip the next 'n' bytes, or 'unget' the last -n bytes if negative
image_skip_fn :: proc "c" (ctx: rawptr, len: i32) {
	fmt.println("--- --------- image_skip_fn");
	int_ptr := cast(^int)ctx;
	file := cast(os.Handle)int_ptr^;

	if offset, err := os.seek(file, cast(i64)len, os.SEEK_CUR); err != 0 do fmt.panicf("error");
}

// returns nonzero if we are at end of file/data
image_eof_fn :: proc "c" (ctx: rawptr) -> i32 {
	fmt.println("--- --------- image_eof_fn");

	int_ptr := cast(^int)ctx;
	file := cast(os.Handle)int_ptr^;
	fmt.println("--- image_eof_fn", file);

	if offset, err := os.seek(file, 0, os.SEEK_CUR); err != 0 do fmt.panicf("error");

	return 0;
}

