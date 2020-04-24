package engine

import "core:fmt"
import "shared:engine/time"
import "shared:engine/gfx"
import "shared:engine/input"
import "shared:engine/window"
import "shared:engine/libs/fna"
import "shared:engine/libs/sdl"
import "shared:engine/libs/imgui"

Engine_Config :: struct {
	init: proc(),
	update: proc(),
	render: proc(),

	update_rate: f64, 				// desired fps. Defaults to 60
	update_multiplicity: int, 		// Makes the game always do a multiple of N updates at a time. Defaults to 1. 2 would be update_rate / multiplicity or 30fps.

	// resolution_policy: gfx.Resolution_Policy,	// defines how the main render texture should be blitted to the backbuffer
	design_width: i32,				// the width of the main offscreen render texture when the policy is not .Default
	design_height: i32,				// the height of the main offscreen render texture when the policy is not .Default

	max_quads: i32,					// max number of quads allowed to be rendered per frame (sprites and text)
	max_tris: i32,					// max number of triangles allowed to be rendered per frame (shapes and lines)

	win_config: window.Window_Config,	// window configuration
	disable_debug_render: bool,		// when true, debug rendering will be disabled

	imgui_disabled: bool,			// whether imgui should be disabled
	imgui_viewports: bool,			// whether imgui viewports should be enabled
	imgui_docking: bool				// whether imgui docking should be enabled
}


run :: proc(config: Engine_Config) {
	config := config;
	merge_default_config(&config);

	// sdl.set_hint("FNA3D_FORCE_DRIVER", "OpenGL");
	if sdl.init(sdl.Init_Flags.Everything) != 0 do fmt.panicf("SDL failed to initialize");
	window.create(&config.win_config);

	params := fna.Presentation_Parameters{
		back_buffer_width = config.win_config.width,
		back_buffer_height = config.win_config.height,
		back_buffer_format = fna.Surface_Format.Color,
		multi_sample_count = 0,
		device_window_handle = window.sdl_window,
		is_full_screen = 0,
		depth_stencil_format = fna.Depth_Format.D24_S8,
		presentation_interval = fna.Present_Interval.Default,
		display_orientation = fna.Display_Orientation.Default,
		render_target_usage = fna.Render_Target_Usage.Platform_Contents
	};
	gfx.init(&params, config.disable_debug_render);
	time.init(config.update_rate, config.update_multiplicity);
	input.init(window.scale());

	config.init();
	imgui.impl_fna_init(gfx.fna_device, window.sdl_window);

	run_loop(config.update, config.render);
}

@(private)
merge_default_config :: proc(config: ^Engine_Config) {
	config.update_rate 			= config.update_rate == 0 ? 60 : config.update_rate;
	config.update_multiplicity 	= config.update_multiplicity == 0 ? 1 : config.update_multiplicity;

	config.design_width 		= config.design_width == 0 ? 640 : config.design_width;
	config.design_height 		= config.design_height == 0 ? 480 : config.design_height;
	config.max_quads 			= config.max_quads == 0 ? 5000 : config.max_quads;
	config.max_tris 			= config.max_tris == 0 ? 500 : config.max_tris;

	config.win_config.title 	= len(config.win_config.title) == 0 ? "Odin Engine" : config.win_config.title;
	config.win_config.width 	= config.win_config.width == 0 ? 640 : config.win_config.width;
	config.win_config.height 	= config.win_config.height == 0 ? 480 : config.win_config.height;
}

@(private)
run_loop :: proc(update: proc(), render: proc()) {
	for !poll_events() {
		imgui.impl_fna_new_frame(window.sdl_window);

		fna.begin_frame(gfx.fna_device);
		gfx.clear({1, 0, 0, 1}); // TODO: we should never auto clear anything

		time.tick(update);
		render();

		gfx.commit();
		imgui.fna_render();
		window.swap(gfx.fna_device);
	}
}

// returns true when its time to quit
poll_events :: proc() -> bool {
	input.new_frame();

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


