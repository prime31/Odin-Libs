package input

import "core:fmt"
import "shared:engine/libs/sdl"

@(private)
Input :: struct {
	keys: [243]byte,
	dirty_keys: [dynamic]sdl.Scancode,
	mouse_buttons: [4]byte,
	dirty_mouse_buttons: [dynamic]byte,
	mouse_wheel_y: i32,
	mouse_rel_x: i32,
	mouse_rel_y: i32,
	window_scale: i32
	// res_scaler &graphics.ResolutionScaler
}

Mouse_Button :: enum {
	Left = 1,
	Middle = 2,
	Right = 3
}
Mouse_Button_Bits :: bit_set[Mouse_Button];

RELEASED :: 1; // true only the frame the key is released
DOWN :: 2; // true the entire time the key is down
PRESSED :: 3; // only true if down this frame and not down the previous frame


@(private)
input := Input{};


init :: proc(win_scale: f32) {
	input.dirty_keys = make([dynamic]sdl.Scancode, 5);
	input.dirty_mouse_buttons = make([dynamic]byte, 3);
	input.window_scale = cast(i32)win_scale;

	// TODO: this is a bit of a cheat, but we know that graphics is all set here so we fetch the scaler
	//input.res_scaler = graphics.get_resolution_scaler()
}

// clears any released keys
new_frame :: proc() {
	if len(input.dirty_keys) > 0 {
		for k in input.dirty_keys {
			input.keys[k] -= 1;
		}
		clear(&input.dirty_keys);
	}

	if len(input.dirty_mouse_buttons) > 0 {
		for b in input.dirty_mouse_buttons {
			input.mouse_buttons[b] -= 1;
		}
		clear(&input.dirty_mouse_buttons);
	}

	input.mouse_wheel_y = 0;
	input.mouse_rel_x = 0;
	input.mouse_rel_y = 0;
}

handle_event :: proc(evt: ^sdl.Event) {
	#partial switch evt.type {
		case .Key_Down, .Key_Up: handle_keyboard_event(&evt.key);
		case .Mouse_Button_Down, .Mouse_Button_Up: handle_mouse_event(&evt.button);
		case .Mouse_Wheel: input.mouse_wheel_y = evt.wheel.y;
		case .Mouse_Motion: {
			input.mouse_rel_x = evt.motion.xrel;
			input.mouse_rel_y = evt.motion.yrel;
		}
		case .Controller_Axis_Motion: { fmt.println("Controller_Axis_Motion", evt.caxis); }
		case .Controller_Button_Down, .Controller_Button_Up: { fmt.println("Controller_Button_Down/Up", evt.cbutton); }
		case .Controller_Device_Added: { fmt.println("Controller_Device_Added", evt.cdevice); }
		case .Controller_Device_Removed: { fmt.println("Controller_Device_Removed", evt.cdevice); }
		case .Controller_Device_Remapped: { fmt.println("Controller_Device_Remapped", evt.cdevice); }
	}
}

@(private)
handle_keyboard_event :: proc(evt: ^sdl.Keyboard_Event) {
	if evt.state == 0 {
		input.keys[evt.keysym.scancode] = RELEASED;
		append(&input.dirty_keys, evt.keysym.scancode);
	} else {
		input.keys[evt.keysym.scancode] = PRESSED;
		append(&input.dirty_keys, evt.keysym.scancode);
	}

	fmt.println("kb:", evt);
}

@(private)
handle_mouse_event :: proc(evt: ^sdl.Mouse_Button_Event) {
	if evt.state == 0 {
		input.mouse_buttons[evt.button] = RELEASED;
		append(&input.dirty_mouse_buttons, evt.button);
	} else {
		input.mouse_buttons[evt.button] = PRESSED;
		append(&input.dirty_mouse_buttons, evt.button);
	}

	fmt.println("mouse:", evt);
}


main :: proc() {
	mouse_down: Mouse_Button_Bits;

	incl(&mouse_down, Mouse_Button.Left);
	fmt.println("incl down:", mouse_down, .Left in mouse_down);

	excl(&mouse_down, Mouse_Button.Left);
	fmt.println("excl down:", mouse_down, .Left in mouse_down);
}

