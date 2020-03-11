package main

import "core:fmt"
import sg "shared:engine/libs/sokol"
import "shared:engine/libs/flextgl"
import "shared:engine/ctest"
import "shared:engine/libs/sdl2"


state: struct {
	pass_action: sg.Pass_Action,
	bind:        sg.Bindings,
	pip:         sg.Pipeline,
};

main :: proc() {
	window := create_window();
	gl_context := sdl2.gl_create_context(window);

	flextgl.init();
	sg.setup({});

	prep_gfx_state();

	running := true;
	for running {
		e: sdl2.Event;
		for sdl2.poll_event(&e) != 0 {
			if e.type == sdl2.Event_Type.Quit {
				running = false;
			}
		}

		w, h: i32;
		sdl2.gl_get_drawable_size(window, &w, &h);
		sg.begin_default_pass(state.pass_action, int(w), int(h));
		sg.apply_pipeline(state.pip);
		sg.apply_bindings(state.bind);
		sg.draw(0, 6, 1);
		sg.end_pass();
		sg.commit();

		sdl2.gl_swap_window(window);
	}
}

create_window :: proc() -> ^sdl2.Window {
	sdl2.init(sdl2.Init_Flags.Everything);
	window := sdl2.create_window("Odin + Sokol + SDL", i32(sdl2.Window_Pos.Undefined), i32(sdl2.Window_Pos.Undefined), 640, 480, sdl2.Window_Flags(sdl2.Window_Flags.Allow_High_DPI));

	sdl2.gl_set_attribute(sdl2.GL_Attr.Context_Flags, i32(sdl2.GL_Context_Flag.Forward_Compatible));
	sdl2.gl_set_attribute(sdl2.GL_Attr.Context_Profile_Mask, i32(sdl2.GL_Context_Profile.Core));
	sdl2.gl_set_attribute(sdl2.GL_Attr.Context_Major_Version, 3);
	sdl2.gl_set_attribute(sdl2.GL_Attr.Context_Minor_Version, 3);

	sdl2.gl_set_attribute(sdl2.GL_Attr.Doublebuffer, 1);
	sdl2.gl_set_attribute(sdl2.GL_Attr.Depth_Size, 24);
	sdl2.gl_set_attribute(sdl2.GL_Attr.Stencil_Size, 8);

	return window;
}

prep_gfx_state :: proc() {
	Vertex :: struct {
		pos: [3]f32,
		col: [4]f32,
	};

	vertices := [?]Vertex{
		{{+0.5, +0.5, +0.5}, {1.0, 0.0, 0.0, 1.0}},
		{{+0.5, -0.5, +0.5}, {0.0, 1.0, 0.0, 1.0}},
		{{-0.5, -0.5, +0.5}, {0.0, 0.0, 1.0, 1.0}},
		{{-0.5, -0.5, +0.5}, {0.0, 0.0, 1.0, 1.0}},
		{{-0.5, +0.5, +0.5}, {0.0, 0.0, 1.0, 1.0}},
		{{+0.5, +0.5, +0.5}, {1.0, 0.0, 0.0, 1.0}},
	};
	state.bind.vertex_buffers[0] = sg.make_buffer({
		size = len(vertices) * size_of(Vertex),
		content = &vertices[0],
		label = "triangle-vertices",
	});

	state.pip = sg.make_pipeline({
		shader = sg.make_shader({
			vs = {
				source = `
					#version 330
					in vec4 position;
					in vec4 color0;
					out vec4 color;
					void main() {
						gl_Position = position;
						color = color0;
					}`,
			},
			fs = {
				source = `
					#version 330
					in vec4 color;
					out vec4 frag_color;
					void main() {
						frag_color = color;
					}`,
			},

			attrs = {
				0 = {sem_name = "POS", name = "position"},
				1 = {sem_name = "COLOR", name = "color0"}
			},
		}),
		label = "triangle-pipeline",
		primitive_type = .TRIANGLES,
		layout = {
			attrs = {
				0 = {format = .FLOAT3},
				1 = {format = .FLOAT4},
			},
		},
	});

	state.pass_action.colors[0] = {action = .CLEAR, val = {0.5, 0.7, 1.0, 1}};
}
