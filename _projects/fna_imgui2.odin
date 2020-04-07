package main

import "core:os"
import "core:fmt"
import "shared:engine/libs/sdl"
import "shared:engine/libs/fna"
import "shared:engine/libs/imgui"

device: ^fna.Device;
vbuff: ^fna.Buffer;
effect: ^fna.Effect;
vert_decl: fna.Vertex_Declaration;

main :: proc() {
	sdl.set_hint("FNA3D_FORCE_DRIVER", "OpenGL");
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

	imgui.create_context();
	io := imgui.get_io();
	io.config_flags |= .DockingEnable;
	io.config_flags |= .ViewportsEnable;

	style := imgui.get_style();
	if int(io.config_flags & .ViewportsEnable) != 0 {
		style.window_rounding = 0;
		style.colors[2].w = 1.0;
	}

	imgui.impl_init_for_gl2(window, fna_gl_txt);

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

		imgui.impl_new_frame2(window);
		imgui.im_text("whatever");
		imgui.bullet();
		imgui.im_text("whatever");
		imgui.bullet();
		imgui.im_text("whatever");
		imgui.render();
		imgui.impl_render2();

		if int(io.config_flags & .ViewportsEnable) != 0 {
			imgui.update_platform_windows();
			imgui.render_platform_windows_default();
			sdl.gl_make_current(window, fna_gl_txt);
		}

		fna.swap_buffers(device, nil, nil, params.device_window_handle);
	}
}

create_window :: proc() -> ^sdl.Window {
	sdl.init(sdl.Init_Flags.Everything);

	window_attrs := fna.prepare_window_attributes();
	return sdl.create_window("Odin + FNA + SDL + OpenGL", i32(sdl.Window_Pos.Undefined), i32(sdl.Window_Pos.Undefined), 640, 480, cast(sdl.Window_Flags)window_attrs);
}



