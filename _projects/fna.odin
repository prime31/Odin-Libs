package main

import "core:os"
import "core:fmt"
import "core:mem"
import "core:math/linalg"
import "shared:engine/libs/sdl"
import "shared:engine/libs/fna"

device: ^fna.Device;
vbuff: ^fna.Buffer;
ibuff: ^fna.Buffer;
effect: ^fna.Effect;

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
	device = fna.create_device(&params);
	fna.set_presentation_interval(device, .One);

	prepper();

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

		// fmt.println("using technique: ", effect.mojo_effect.current_technique.name);
		state_changes := fna.Effect_State_Changes{};
		fna.apply_effect(device, effect, effect.mojo_effect.current_technique, 0, &state_changes);

		vert_elements := make([]fna.Vertex_Element, 3);
		defer { delete(vert_elements); }

		vert_decl := fna.Vertex_Declaration{
			vertex_stride = 10 * 4,
			element_count = 3,
			elements = &vert_elements[0]
		};
		fna.apply_vertex_declaration(device, &vert_decl, vbuff, 0);
		// fna.apply_vertex_buffer_bindings(device, 1, 1, 0);
		fna.draw_primitives(device, .Triangle_List, 0, 2);

		fna.swap_buffers(device, nil, nil, params.device_window_handle);
	}
}

prepper :: proc() {
	Vertex :: struct {
		pos: [3]f32,
		col: [4]f32,
		uv: [2]f32
	};

	vertices := [?]Vertex{
		{{+0.5, +0.5, +0.5}, {1.0, 0.0, 0.0, 1.0}, {1.0, 1.0}},
		{{+0.5, -0.5, +0.5}, {0.0, 1.0, 0.0, 1.0}, {1.0, 0.0}},
		{{-0.5, -0.5, +0.5}, {0.0, 0.0, 1.0, 1.0}, {0.0, 0.0}},
		{{-0.5, -0.5, +0.5}, {0.0, 0.0, 1.0, 1.0}, {0.0, 0.0}},
		{{-0.5, +0.5, +0.5}, {0.0, 0.0, 1.0, 1.0}, {0.0, 1.0}},
		{{+0.5, +0.5, +0.5}, {1.0, 0.0, 0.0, 1.0}, {1.0, 1.0}},
	};

	indices := [?]i16{0, 1, 2, 2, 3, 0};

	vbuff = fna.gen_vertex_buffer(device, 0, .Write_Only, len(vertices), 10 * 4);
	fna.set_vertex_buffer_data(device, vbuff, 0, &vertices, len(vertices), .None);
	ibuff = fna.gen_index_buffer(device, 0, .Write_Only, 6, ._16_Bit);
	fna.set_index_buffer_data(device, ibuff, 0, &indices, 6, .None);

	// load an effect
	data, success := os.read_entire_file("assets/SpriteEffect.fxb");
	defer if success { delete(data); }

	effect = fna.create_effect(device, &data[0], cast(u32)len(data));
	// fmt.println("effect:", effect, "mojo_effect:", effect.mojo_effect);

	// params := mem.slice_ptr(effect.mojo_effect.params, cast(int)effect.mojo_effect.param_count);
	// for param in params {
	// 	fmt.println("param", param);
	// }
}


create_window :: proc() -> ^sdl.Window {
	sdl.init(sdl.Init_Flags.Everything);

	window_attrs := fna.prepare_window_attributes(1);
	window := sdl.create_window("Odin + FNA + SDL + OpenGL", i32(sdl.Window_Pos.Undefined), i32(sdl.Window_Pos.Undefined), 640, 480, cast(sdl.Window_Flags)window_attrs);

	return window;
}
