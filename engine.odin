package engine

import "core:fmt"
import "shared:engine/time"
import "shared:engine/gfx"
import "shared:engine/input"
import "shared:engine/window"
import "shared:engine/libs/fna"
import "shared:engine/libs/sdl"
import "shared:engine/libs/imgui"


// TODO: pass in config object
run :: proc(init: proc(), update: proc(), render: proc() = nil) {
	width:i32 = 640;
	height:i32 = 480;

	// sdl.set_hint("FNA3D_FORCE_DRIVER", "OpenGL");
	if sdl.init(sdl.Init_Flags.Everything) != 0 do fmt.panicf("SDL failed to initialize");
	window.create(width, height);

	// TODO: do we need to store these?
	params := fna.Presentation_Parameters{
		back_buffer_width = width,
		back_buffer_height = height,
		back_buffer_format = fna.Surface_Format.Color,
		multi_sample_count = 0,
		device_window_handle = window.sdl_window,
		is_full_screen = 0,
		depth_stencil_format = fna.Depth_Format.D24_S8,
		presentation_interval = fna.Present_Interval.Default,
		display_orientation = fna.Display_Orientation.Default,
		render_target_usage = fna.Render_Target_Usage.Discard_Contents
	};
	gfx.fna_device = fna.create_device(&params, 0);
	fna.set_presentation_interval(gfx.fna_device, .One);

	set_default_graphics_state();

	vp := fna.Viewport{0, 0, width, height, -1, 1};
	fna.set_viewport(gfx.fna_device, &vp);

	init();
	imgui.impl_fna_init(gfx.fna_device, window.sdl_window);

	run_loop(update, render);
}

@(private)
set_default_graphics_state :: proc() {
	// alpha blend
	blend := fna.Blend_State{
		.Source_Alpha, .Inverse_Source_Alpha, .Add,
		.Source_Alpha, .Inverse_Source_Alpha, .Add,
		.All, .All, .All, .All, fna.Color{255, 255, 255, 255}, -1
	};
	fna.set_blend_state(gfx.fna_device, &blend);

	rasterizer_state := fna.Rasterizer_State{
		fill_mode = .Solid,
		cull_mode = .None
	};
	fna.apply_rasterizer_state(gfx.fna_device, &rasterizer_state);

	depth_stencil := fna.Depth_Stencil_State{};
	fna.set_depth_stencil_state(gfx.fna_device, &depth_stencil);
}

@(private)
run_loop :: proc(update: proc(), render: proc()) {
	for !poll_events() {
		time.tick();

		imgui.impl_fna_new_frame(window.sdl_window);

		color := fna.Vec4 {1, 0, 0, 1};
		fna.begin_frame(gfx.fna_device);
		fna.clear(gfx.fna_device, fna.Clear_Options.Target, &color, 0, 0);

		update();
		render();

		imgui.fna_render();
		window.swap(gfx.fna_device);
	}
}

// returns true when its time to quit
poll_events :: proc() -> bool {
	e: sdl.Event;
	for sdl.poll_event(&e) != 0 {
		// ignore events imgui eats
		if imgui.sdl_handle_event(&e) do continue;

		#partial switch e.type {
			case .Quit : return true;
			case .Window_Event: {
				if e.window.window_id == sdl.get_window_id(window.sdl_window) {
					if e.window.event == .Close do return true;
					window.handle_event(&e);
				}
			}
			case .Render_Targets_Reset: fmt.println("Render_Targets_Reset");
			case .Render_Device_Reset: fmt.println("Render_Device_Reset");
			case: input.handle_event(&e);
		}
	}
	return false;
}


