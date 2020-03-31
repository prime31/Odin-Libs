package main

import "core:os"
import "core:fmt"
import "core:mem"
import "core:math"
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
effect: ^fna.Effect;
vert_decl: fna.Vertex_Declaration;
texture: ^fna.Texture;
vert_buff_bindings: []fna.Vertex_Buffer_Binding;

main :: proc() {
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

		state_changes := fna.Mojoshader_Effect_State_Changes{};
		fna.apply_effect(device, effect, effect.mojo_effect.current_technique, 0, &state_changes);

		// vertices := [?]Vertex{
		// 	{{+0.5, +0.5}, {1.0, 1.0}, 0xFF0099FF},
		// 	{{+0.5, -0.5}, {1.0, 0.0}, 0xFFFFFFFF},
		// 	{{-0.5, -0.5}, {0.0, 0.0}, 0xFFFFFFFF},
		// 	{{-0.5, -0.5}, {0.0, 0.0}, 0xFFFFFFFF},
		// 	{{-0.5, +0.5}, {0.0, 1.0}, 0xFFFF99FF},
		// 	{{+0.5, +0.5}, {1.0, 1.0}, 0xFFFF99FF}
		// };
		// fna.apply_vertex_declaration(device, &vert_decl, &vertices, 0);
		// fna.draw_primitives(device, .Triangle_List, 0, 2);


		fna.apply_vertex_buffer_bindings(device, &vert_buff_bindings[0], 0, 1, 0);
		fna.draw_indexed_primitives(device, .Triangle_List, 0, 0, 4, 0, 2, ibuff, ._16_Bit);
		fna.swap_buffers(device, nil, nil, params.device_window_handle);
	}
}

prepper :: proc() {
	// vertex declaration
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

	// buffers
	vertices := [?]Vertex{
		{{+0.5, -0.5}, {1.0, 1.0}, 0xFF0099FF},
		{{-0.5, -0.5}, {0.0, 1.0}, 0xFFFFFFFF},
		{{-0.5, +0.5}, {0.0, 0.0}, 0xFFFFFFFF},
		{{+0.5, +0.5}, {1.0, 0.0}, 0xFFFF99FF}
	};

	vbuff = fna.gen_vertex_buffer(device, 0, .None, len(vertices), vert_decl.vertex_stride);
	fna.set_vertex_buffer_data(device, vbuff, 0, &vertices, size_of(vertices), .None);

	indices := [?]i16{0, 1, 2, 2, 3, 0};
	ibuff = fna.gen_index_buffer(device, 0, .None, len(indices), ._16_Bit);
	fna.set_index_buffer_data(device, ibuff, 0, &indices, size_of(indices), .None);


	// bindings
    binding := fna.Vertex_Buffer_Binding{vbuff, vert_decl, 0, 0};
	vert_buff_bindings = make([]fna.Vertex_Buffer_Binding, 1);
	vert_buff_bindings[0] = binding;

	// load an effect
	data, success := os.read_entire_file("assets/VertexColorTexture.fxb");
	defer if success { delete(data); }

	effect = fna.create_effect(device, &data[0], cast(u32)len(data));
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
