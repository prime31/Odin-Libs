package imgui

import "core:fmt"
import "core:math"
import "shared:engine/libs/sdl"

@(private)
mouse_cursors: [Mouse_Cursor.Count]^sdl.Cursor;

@(private)
mouse_button_state: [3]bool;


sdl_init :: proc(window: ^sdl.Window) {
	io := get_io();
	io.backend_flags |= .HasMouseCursors;
	io.backend_flags |= .PlatformHasViewports;

    io.key_map[Key.Tab] = cast(i32)sdl.Scancode.Tab;
    io.key_map[Key.LeftArrow] = cast(i32)sdl.Scancode.Left;
    io.key_map[Key.RightArrow] = cast(i32)sdl.Scancode.Right;
    io.key_map[Key.UpArrow] = cast(i32)sdl.Scancode.Up;
    io.key_map[Key.DownArrow] = cast(i32)sdl.Scancode.Down;
    io.key_map[Key.PageUp] = cast(i32)sdl.Scancode.Page_Up;
    io.key_map[Key.PageDown] = cast(i32)sdl.Scancode.Page_Down;
    io.key_map[Key.Home] = cast(i32)sdl.Scancode.Home;
    io.key_map[Key.End] = cast(i32)sdl.Scancode.End;
    io.key_map[Key.Insert] = cast(i32)sdl.Scancode.Insert;
    io.key_map[Key.Delete] = cast(i32)sdl.Scancode.Delete;
    io.key_map[Key.Backspace] = cast(i32)sdl.Scancode.Backspace;
    io.key_map[Key.Space] = cast(i32)sdl.Scancode.Space;
    io.key_map[Key.Enter] = cast(i32)sdl.Scancode.Return;
    io.key_map[Key.Escape] = cast(i32)sdl.Scancode.Escape;
    io.key_map[Key.KeyPadEnter] = cast(i32)sdl.Scancode.Return2;
    io.key_map[Key.A] = cast(i32)sdl.Scancode.A;
    io.key_map[Key.C] = cast(i32)sdl.Scancode.C;
    io.key_map[Key.V] = cast(i32)sdl.Scancode.V;
    io.key_map[Key.X] = cast(i32)sdl.Scancode.X;
    io.key_map[Key.Y] = cast(i32)sdl.Scancode.Y;
    io.key_map[Key.Z] = cast(i32)sdl.Scancode.Z;

    // TODO: wire up clipboard get/set methods

    mouse_cursors[Mouse_Cursor.Arrow] = sdl.create_system_cursor(sdl.System_Cursor.Arrow);
    mouse_cursors[Mouse_Cursor.Text_Input] = sdl.create_system_cursor(sdl.System_Cursor.IBeam);
    mouse_cursors[Mouse_Cursor.Resize_All] = sdl.create_system_cursor(sdl.System_Cursor.Size_All);
    mouse_cursors[Mouse_Cursor.Resize_Ns] = sdl.create_system_cursor(sdl.System_Cursor.Size_NS);
    mouse_cursors[Mouse_Cursor.Resize_Ew] = sdl.create_system_cursor(sdl.System_Cursor.Size_WE);
    mouse_cursors[Mouse_Cursor.Resize_Nesw] = sdl.create_system_cursor(sdl.System_Cursor.Size_NESW);
    mouse_cursors[Mouse_Cursor.Resize_Nwse] = sdl.create_system_cursor(sdl.System_Cursor.Size_NWSE);
    mouse_cursors[Mouse_Cursor.Hand] = sdl.create_system_cursor(sdl.System_Cursor.Hand);
    mouse_cursors[Mouse_Cursor.Not_Allowed] = sdl.create_system_cursor(sdl.System_Cursor.No);

    main_viewport := get_main_viewport();
    main_viewport.platform_handle = window;

    // TODO: ImGui_ImplSDL2_UpdateMonitors

    // TODO: ImGui_ImplSDL2_InitPlatformInterface
    if int(io.config_flags & .ViewportsEnable) != 0 && int(io.backend_flags & .PlatformHasViewports) != 0 {
    	// fmt.println("------- viewports requested but not yet implemented");
    }
}

sdl_new_frame :: proc(window: ^sdl.Window, drawable_width: i32, drawable_height: i32) {
	io := get_io();

	width, height: i32;
	sdl.get_window_size(window, &width, &height);

	io.display_size = Vec2{cast(f32)width, cast(f32)height};
	if width > 0 && height > 0 {
		io.display_framebuffer_scale = Vec2{f32(drawable_width / width), f32(drawable_height / height)};
	}

	@static global_time: u64 = 0;
	frequency := sdl.get_performance_frequency();
	current_time := sdl.get_performance_counter();
	io.delta_time = global_time > 0 ? f32((current_time - global_time) / frequency) : cast(f32)1 / 60;

	// ImGui_ImplSDL2_UpdateMousePosAndButtons
	if io.want_set_mouse_pos {
		if int(io.config_flags & .ViewportsEnable) != 0 {
			sdl.warp_mouse_global(cast(i32)io.mouse_pos.x, cast(i32)io.mouse_pos.y);
		} else {
			sdl.warp_mouse_in_window(window, cast(i32)io.mouse_pos.x, cast(i32)io.mouse_pos.y);
		}
	} else {
		io.mouse_pos = Vec2{math.F32_MIN, math.F32_MIN};
	}

	// Set Dear ImGui mouse pos from OS mouse pos + get buttons. (this is the common behavior)
	mouse_x_local, mouse_y_local: i32;
	mouse_buttons := sdl.get_mouse_state(&mouse_x_local, &mouse_y_local);
	io.mouse_down[0] = mouse_button_state[0] || sdl_button(mouse_buttons, 1);
	io.mouse_down[1] = mouse_button_state[1] || sdl_button(mouse_buttons, 2);
	io.mouse_down[2] = mouse_button_state[2] || sdl_button(mouse_buttons, 3);

	mouse_button_state[0] = false;
	mouse_button_state[1] = false;
	mouse_button_state[2] = false;

	// Mimics the SDL_BUTTON macro and does the button down check
	sdl_button :: proc(mouse_buttons: u32, button: u32) -> bool {
		return mouse_buttons & (1 << (button - 1)) != 0;
	}

	mouse_x_global, mouse_y_global: i32;
	sdl.get_global_mouse_state(&mouse_x_global, &mouse_y_global);

	if int(io.config_flags & .ViewportsEnable) != 0 {
		// TODO: viewports
		// fmt.println("---- viewports not implemented");
	} else {
		if sdl.get_window_flags(window) | cast(u32)sdl.Window_Flags.Input_Focus != 0 {
			window_x, window_y: i32;
			sdl.get_window_position(window, &window_x, &window_y);
			io.mouse_pos = Vec2{f32(mouse_x_global - window_x), f32(mouse_y_global - window_y)};
		}
	}


	// ImGui_ImplSDL2_UpdateMouseCursor
	if int(io.config_flags & .NoMouseCursorChange) == 0 {
		imgui_cursor := get_mouse_cursor();
		if io.mouse_draw_cursor || imgui_cursor == .None {
			sdl.show_cursor(0);
		} else {
			sdl.set_cursor(mouse_cursors[imgui_cursor]);
			sdl.show_cursor(1);
		}
	}


	// TODO: ImGui_ImplSDL2_UpdateGamepads
}

// returns true if the event is handled by imgui and should be ignored
sdl_handle_event :: proc(evt: ^sdl.Event) -> bool {
	#partial switch evt.type {
		case .Mouse_Wheel: {
			io := get_io();
			if evt.wheel.x > 0 do io.mouse_wheel_h += 1;
			if evt.wheel.x < 0 do io.mouse_wheel_h -= 1;
			if evt.wheel.y > 0 do io.mouse_wheel += 1;
			if evt.wheel.y < 0 do io.mouse_wheel -= 1;
			return get_io().want_capture_mouse;
		}
		case .Mouse_Button_Down: {
			io := get_io();
			if evt.button.button == 1 do mouse_button_state[0] = true;
			if evt.button.button == 2 do mouse_button_state[1] = true;
			if evt.button.button == 3 do mouse_button_state[2] = true;
			return get_io().want_capture_mouse;
		}
		case .Text_Input: {
			io := get_io();
			io_add_input_characters_utf8(io, &evt.text.text[0]);
			return get_io().want_capture_keyboard;
		}
		case .Key_Down, .Key_Up: {
			io := get_io();
			io.keys_down[evt.key.keysym.scancode] = evt.type == .Key_Down;
			io.key_shift = int(sdl.get_mod_state() & .Shift) != 0;
			io.key_ctrl = int(sdl.get_mod_state() & .Ctrl) != 0;
			io.key_alt = int(sdl.get_mod_state() & .Alt) != 0;

			when ODIN_OS == "windows" { io.key_super = false; }
			else { io.key_super = int(sdl.get_mod_state() & .Gui) != 0; }
			return get_io().want_capture_keyboard;
		}
		case .Window_Event: {
			// TODO: viewport support and return true
			return false;
		}
	}
	return false;
}
