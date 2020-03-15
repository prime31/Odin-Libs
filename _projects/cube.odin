package main

import "core:fmt"
import "core:math"
import "core:math/linalg"
import sg "shared:engine/libs/sokol"
import "shared:engine/libs/flextgl"
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

	// shader params
	w, h: i32;
	sdl2.gl_get_drawable_size(window, &w, &h);

	proj := linalg.matrix4_perspective(math.to_radians_f32(60), f32(w) / f32(h), 0.01, 10);
	view := linalg.matrix4_look_at({0, 1.5, 6}, {0, 0, 0}, {0, 1, 0});
	view_proj := linalg.matrix_mul(proj, view);

	rx, ry := cast(f32)0., cast(f32)0.;
	running := true;
	for running {
		e: sdl2.Event;
		for sdl2.poll_event(&e) != 0 {
			if e.type == sdl2.Event_Type.Quit {
				running = false;
			}
		}

		rx += 1;
		ry += 2;
		rxm := linalg.matrix4_rotate(math.to_radians(rx), {1, 0, 0});
		rym := linalg.matrix4_rotate(math.to_radians(ry), {0, 1, 0});
		model := linalg.matrix_mul(rxm, rym);
		mvp := linalg.matrix_mul(view_proj, model);

		sg.begin_default_pass(state.pass_action, int(w), int(h));
		sg.apply_pipeline(state.pip);
		sg.apply_bindings(state.bind);
		sg.apply_uniforms(.Vs, 0, &mvp, size_of(linalg.Matrix4));
		sg.draw(0, 36, 1);
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
		{{-1.0, -1.0, -1.0},   {1.0, 0.0, 0.0, 1.0}},
		{{1.0, -1.0, -1.0},   {1.0, 0.0, 0.0, 1.0}},
		{{1.0,  1.0, -1.0},   {1.0, 0.0, 0.0, 1.0}},
		{{-1.0,  1.0, -1.0},   {1.0, 0.0, 0.0, 1.0}},

		{{-1.0, -1.0,  1.0},   {0.0, 1.0, 0.0, 1.0}},
		{{1.0, -1.0,  1.0},   {0.0, 1.0, 0.0, 1.0}},
		{{1.0,  1.0,  1.0},   {0.0, 1.0, 0.0, 1.0}},
		{{-1.0,  1.0,  1.0},   {0.0, 1.0, 0.0, 1.0}},

		{{-1.0, -1.0, -1.0},   {0.0, 0.0, 1.0, 1.0}},
		{{-1.0,  1.0, -1.0},   {0.0, 0.0, 1.0, 1.0}},
		{{-1.0,  1.0,  1.0},   {0.0, 0.0, 1.0, 1.0}},
		{{-1.0, -1.0,  1.0},   {0.0, 0.0, 1.0, 1.0}},

		{{1.0, -1.0, -1.0},    {1.0, 0.5, 0.0, 1.0}},
		{{1.0,  1.0, -1.0},    {1.0, 0.5, 0.0, 1.0}},
		{{1.0,  1.0,  1.0},    {1.0, 0.5, 0.0, 1.0}},
		{{1.0, -1.0,  1.0},    {1.0, 0.5, 0.0, 1.0}},

		{{-1.0, -1.0, -1.0},   {0.0, 0.5, 1.0, 1.0}},
		{{-1.0, -1.0,  1.0},   {0.0, 0.5, 1.0, 1.0}},
		{{1.0, -1.0,  1.0},   {0.0, 0.5, 1.0, 1.0}},
		{{1.0, -1.0, -1.0},   {0.0, 0.5, 1.0, 1.0}},

		{{-1.0,  1.0, -1.0},   {1.0, 0.0, 0.5, 1.0}},
		{{-1.0,  1.0,  1.0},   {1.0, 0.0, 0.5, 1.0}},
		{{1.0,  1.0,  1.0},   {1.0, 0.0, 0.5, 1.0}},
		{{1.0,  1.0, -1.0},   {1.0, 0.0, 0.5, 1.0}},
	};
	state.bind.vertex_buffers[0] = sg.make_buffer({
		size = len(vertices) * size_of(Vertex),
		content = &vertices[0]
	});

	indices := [?]u16{0, 1, 2,  0, 2, 3,
			        6, 5, 4,  7, 6, 4,
			        8, 9, 10,  8, 10, 11,
			        14, 13, 12,  15, 14, 12,
			        16, 17, 18,  16, 18, 19,
			        22, 21, 20,  23, 22, 20};
	state.bind.index_buffer = sg.make_buffer({
		type = .Indexbuffer,
		size = len(indices) * size_of(u16),
		content = &indices[0]
	});

	state.pip = sg.make_pipeline({
		shader = sg.make_shader({
			vs = {
				uniform_blocks = {
					0 = {
						size = size_of(linalg.Matrix4),
						uniforms = {
							0 = {name = "mvp", type = .Mat4}
						}
					}
				},
				source = `
					#version 330
					uniform mat4 mvp;
					layout(location=0) in vec4 position;
					layout(location=1) in vec4 color0;
					out vec4 color;
					void main() {
						gl_Position = mvp * position;
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
			}
		}),
		layout = {
			buffers = {
				0 = {stride = 28}
			},
			attrs = {
				0 = {format = .Float3},
				1 = {format = .Float4}
			},
		},
		index_type = .Uint16,
		depth_stencil = {
			depth_compare_func = .Less_Equal,
			depth_write_enabled = true
		},
		rasterizer = {
			cull_mode = .Back
		}
	});

	state.pass_action.colors[0] = {action = .Clear, val = {0.5, 0.7, 1.0, 1}};
}
