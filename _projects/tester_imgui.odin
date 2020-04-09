package main

import "core:fmt"
import sg "shared:engine/libs/sokol"
import "shared:engine/libs/flextgl"
import "shared:engine/libs/imgui"
import "shared:engine/libs/sdl"

Thing :: struct {
	inty: int,
	floaty: f32,
	stringy: string
}

main :: proc() {
	window := create_window();
	gl_context := sdl.gl_create_context(window);

	flextgl.init();
	sg.setup({});

	imgui.create_context();
	io := imgui.get_io();
	io.config_flags |= .DockingEnable;
	io.config_flags |= .ViewportsEnable;

	imgui.impl_init_for_gl("#version 150", window, gl_context);

	t := Thing{};
	pass_action: sg.Pass_Action;
	pass_action.colors[0] = {action = .Clear, val = {0.5, 0.7, 1.0, 1}};

	running := true;
	for running {
		e: sdl.Event;
		for sdl.poll_event(&e) != 0 {
			if imgui.impl_handle_event(&e) do continue;
			if e.type == sdl.Event_Type.Quit {
				running = false;
			}
		}

		w, h: i32;
		sdl.gl_get_drawable_size(window, &w, &h);
		sg.begin_default_pass(pass_action, int(w), int(h));



		imgui.impl_new_frame(window);
		imgui.im_text("whatever");
		imgui.struct_editor(t, false);
		imgui.render();
		imgui.impl_render();

		if int(io.config_flags & .ViewportsEnable) != 0 {
			imgui.update_platform_windows();
			imgui.render_platform_windows_default();
		}

		sg.end_pass();
		sg.commit();
		sdl.gl_swap_window(window);
	}
}

create_window :: proc() -> ^sdl.Window {
	sdl.init(sdl.Init_Flags.Everything);

	sdl.gl_set_attribute(sdl.GL_Attr.Context_Flags, i32(sdl.GL_Context_Flag.Forward_Compatible));
	sdl.gl_set_attribute(sdl.GL_Attr.Context_Profile_Mask, i32(sdl.GL_Context_Profile.Core));
	sdl.gl_set_attribute(sdl.GL_Attr.Context_Major_Version, 3);
	sdl.gl_set_attribute(sdl.GL_Attr.Context_Minor_Version, 3);

	sdl.gl_set_attribute(sdl.GL_Attr.Doublebuffer, 1);
	sdl.gl_set_attribute(sdl.GL_Attr.Depth_Size, 24);
	sdl.gl_set_attribute(sdl.GL_Attr.Stencil_Size, 8);

	window := sdl.create_window("Odin + Sokol + SDL", i32(sdl.Window_Pos.Undefined), i32(sdl.Window_Pos.Undefined), 640, 480, sdl.Window_Flags(sdl.Window_Flags.Open_GL | sdl.Window_Flags.Allow_High_DPI));

	return window;
}
