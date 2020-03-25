package main

import "core:fmt"
import "core:math/linalg"
import "shared:engine/libs/sdl"
import "shared:engine/libs/fna"

main :: proc() {
	window := create_window();

	device := fna.create_device({
		back_buffer_width = 640,
		back_buffer_height = 480,
		back_buffer_format = fna.Surface_Format.Color,
		multi_sample_count = 0,
		device_window_handle = window,
		is_full_screen = 0,
		depth_stencil_format = fna.Depth_Format.D24s8,
		presentation_interval = fna.Present_Interval.Default,
		display_orientation = fna.Display_Orientation.Default,
		render_target_usage = fna.Render_Target_Usage.Discard_Contents
	});

	color := linalg.Vector4 {1, 0, 0, 1};
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

		fna.clear(device, fna.Clear_Options.Target, &color);
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

	window_attrs := fna.prepare_window_attributes(1);
	fmt.println("attrs: ", window_attrs);

	window := sdl.create_window("Odin + FNA + SDL + OpenGL", i32(sdl.Window_Pos.Undefined), i32(sdl.Window_Pos.Undefined), 640, 480, cast(sdl.Window_Flags)window_attrs);

	return window;
}
