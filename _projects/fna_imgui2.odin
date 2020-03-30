package main

import "core:os"
import "core:fmt"
import "core:mem"
import "core:math/linalg"
import "shared:engine/libs/sdl"
import "shared:engine/libs/fna"
import "shared:engine/libs/imgui"

Vertex :: struct {
	pos: [3]f32,
	col: u32
};

device: ^fna.Device;
vbuff: ^fna.Buffer;
effect: ^fna.Effect;
vert_decl: fna.Vertex_Declaration;

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
	fna_gl_txt := sdl.gl_get_current_context();

	prepper();

	im_win, im_ctx := create_gl_window();
	imgui.impl_init_for_gl("#version 150", im_win, im_ctx);
	sdl.gl_make_current(window, fna_gl_txt);

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

		// fmt.println("using technique: ", effect.mojo_effect.current_technique.name);
		state_changes := fna.Mojoshader_Effect_State_Changes{};
		// fna.apply_effect(device, effect, effect.mojo_effect.current_technique, 0, &state_changes);

		vertices := [?]Vertex{
			{{+0.5, +0.5, +0.5}, 0xFFFF0000}, // ABGR
			{{+0.5, -0.5, +0.5}, 0xFF0099FF},
			{{-0.5, -0.5, +0.5}, 0xFF00FFFF},
			{{-0.5, -0.5, +0.5}, 0xFF00FFFF},
			{{-0.5, +0.5, +0.5}, 0xFFFFFF00},
			{{+0.5, +0.5, +0.5}, 0xFFFF0000},
		};

		// fna.apply_vertex_declaration(device, &vert_decl, &vertices, 0);
		// fna.draw_primitives(device, .Triangle_List, 0, 2);
		fna.swap_buffers(device, nil, nil, params.device_window_handle);

		sdl.gl_make_current(im_win, im_ctx);
		imgui.impl_new_frame(im_win);
		imgui.im_text("whatever");
		imgui.render();
		imgui.impl_render();

		io := imgui.get_io();
		if int(io.config_flags & .ViewportsEnable) != 0 {
			imgui.update_platform_windows();
			imgui.render_platform_windows_default();
		}

		sdl.gl_swap_window(im_win);
		sdl.gl_make_current(window, fna_gl_txt);
	}
}

prepper :: proc() {
	vertices := [?]Vertex{};

	vert_elements := make([]fna.Vertex_Element, 2);
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

	vert_decl = fna.Vertex_Declaration{
		vertex_stride = get_vertex_stride(vert_elements),
		element_count = 2,
		elements = &vert_elements[0]
	};

	vbuff = fna.gen_vertex_buffer(device, 0, .Write_Only, len(vertices), 0);
	fna.set_vertex_buffer_data(device, vbuff, 0, &vertices, len(vertices), .None);

	// load an effect
	data, success := os.read_entire_file("assets/VertexColor.fxb");
	defer if success { delete(data); }

	effect = fna.create_effect(device, &data[0], cast(u32)len(data));
	// fmt.println("effect:", effect, "mojo_effect:", effect.mojo_effect);

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

create_gl_window :: proc() -> (^sdl.Window, sdl.GL_Context) {
	sdl.gl_set_attribute(sdl.GL_Attr.Context_Flags, i32(sdl.GL_Context_Flag.Forward_Compatible));
	sdl.gl_set_attribute(sdl.GL_Attr.Context_Profile_Mask, i32(sdl.GL_Context_Profile.Core));
	sdl.gl_set_attribute(sdl.GL_Attr.Context_Major_Version, 3);
	sdl.gl_set_attribute(sdl.GL_Attr.Context_Minor_Version, 3);

	sdl.gl_set_attribute(sdl.GL_Attr.Doublebuffer, 1);
	sdl.gl_set_attribute(sdl.GL_Attr.Depth_Size, 24);
	sdl.gl_set_attribute(sdl.GL_Attr.Stencil_Size, 8);

	win := sdl.create_window("Odin + Sokol + SDL", i32(sdl.Window_Pos.Undefined), i32(sdl.Window_Pos.Undefined), 500, 500, sdl.Window_Flags(sdl.Window_Flags.Open_GL));
	gl_context := sdl.gl_create_context(win);

	return win, gl_context;
}


