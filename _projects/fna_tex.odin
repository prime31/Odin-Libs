package main

import "core:os"
import "core:fmt"
import "core:mem"
import "core:math/linalg"
import "shared:engine/libs/sdl"
import "shared:engine/libs/fna"
import "shared:engine/libs/stb_image"

Vertex :: struct {
	pos: [3]f32,
	col: u32,
	uv: [2]f32
};

device: ^fna.Device;
effect: ^fna.Effect;
mojo_effect: ^fna.Mojoshader_Effect;
vert_decl: fna.Vertex_Declaration;
texture: ^fna.Texture;
vert_buff_binding: fna.Vertex_Buffer_Binding;


main :: proc() {
	// sdl.set_hint("FNA3D_FORCE_DRIVER", "OpenGL");
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

	// rasterizer_state := fna.Rasterizer_State{
	// 	fill_mode = .Solid,
	// 	cull_mode = .None,
	// 	scissor_test_enable = 0
	// };
	// fna.apply_rasterizer_state(device, &rasterizer_state);

	blend := fna.Blend_State{
		.Source_Alpha, .Inverse_Source_Alpha, .Add,
		.Source_Alpha, .Inverse_Source_Alpha, .Add,
		.All, .All, .All, .All, fna.Color{255, 255, 255, 255}, -1
	};
	fna.set_blend_state(device, &blend);

	// depth_stencil := fna.Depth_Stencil_State{
	// 	depth_buffer_enable = 0,
	// 	stencil_enable = 0
	// };
	// fna.set_depth_stencil_state(device, &depth_stencil);

	vp := fna.Viewport{0, 0, 640, 480, -1, 1};
	fna.set_viewport(device, &vp);

	// scissor := fna.Rect{0, 0, 640, 480};
	// fna.set_scissor_rect(device, &scissor);


	prepper();
	// create_texture();
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

		fna.apply_vertex_buffer_bindings(device, &vert_buff_binding, 1, 0, 0);
		fna.draw_primitives(device, .Triangle_List, 0, 2);

		fna.swap_buffers(device, nil, nil, params.device_window_handle);
	}
}

prepper :: proc() {
	vert_elements := make([]fna.Vertex_Element, 3);
	vert_elements[0] = fna.Vertex_Element{
		offset = 0,
		vertex_element_format = .Vector3,
		vertex_element_usage = .Position,
		usage_index = 0
	};

	vert_elements[1] = fna.Vertex_Element{
		offset = 12,
		vertex_element_format = .Color,
		vertex_element_usage = .Color,
		usage_index = 0
	};

	vert_elements[2] = fna.Vertex_Element{
		offset = 16,
		vertex_element_format = .Vector2,
		vertex_element_usage = .Texture_Coordinate,
		usage_index = 0
	};

	vert_decl = fna.Vertex_Declaration{
		vertex_stride = get_vertex_stride(vert_elements),
		element_count = 3,
		elements = &vert_elements[0]
	};



	vertices := [?]Vertex{
		{{+0.5, +0.5, +0.5}, 0xFF0099FF, {1.0, 1.0}}, // ABGR
		{{+0.5, -0.5, +0.5}, 0xFFFFFFFF, {1.0, 0.0}},
		{{-0.5, -0.5, +0.5}, 0xFFFFFFFF, {0.0, 0.0}},
		{{-0.5, -0.5, +0.5}, 0xFFFFFFFF, {0.0, 0.0}},
		{{-0.5, +0.5, +0.5}, 0xFFFFFFFF, {0.0, 1.0}},
		{{+0.5, +0.5, +0.5}, 0xFF0099FF, {1.0, 1.0}},
	};

	fmt.println(len(vertices), size_of(vertices));
	vbuff := fna.gen_vertex_buffer(device, 0, .Write_Only, len(vertices), 20);
	fna.set_vertex_buffer_data(device, vbuff, 0, &vertices[0], size_of(vertices), .None);

	// bindings
	vert_buff_binding = fna.Vertex_Buffer_Binding{vbuff, vert_decl, 0, 0};


	// load an effect
	data, success := os.read_entire_file("assets/Noise.fxb");
	defer if success { delete(data); }

	fna.create_effect(device, &data[0], cast(u32)len(data), &effect, &mojo_effect);
	// fmt.println("effect:", effect, "mojo_effect:", mojo_effect);

	params := mem.slice_ptr(mojo_effect.params, cast(int)mojo_effect.param_count);
	if len(params) > 0 do params[1].effect_value.value.float^ = 0;

	state_changes := fna.Mojoshader_Effect_State_Changes{};
	fna.apply_effect(device, effect, 0, &state_changes);

	if state_changes.render_state_change_count > 0 {
		changes := mem.slice_ptr(state_changes.render_state_changes, cast(int)state_changes.render_state_change_count);
		fmt.println(changes);
	}

	fmt.println(state_changes);
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


create_window :: proc() -> ^sdl.Window {
	sdl.init(sdl.Init_Flags.Everything);

	window_attrs := fna.prepare_window_attributes();
	window := sdl.create_window("Odin + FNA + SDL + OpenGL", i32(sdl.Window_Pos.Undefined), i32(sdl.Window_Pos.Undefined), 640, 480, cast(sdl.Window_Flags)window_attrs);

	return window;
}
