package input

import "core:fmt"
import "shared:engine/libs/sdl"

@(private)
Input :: struct {
	keys: [243]byte,
	dirty_keys: [dynamic]sdl.Scancode,
	mouse_buttons: [3]byte,
	dirty_mouse_buttons: [dynamic]byte,
	mouse_wheel_y: int,
	mouse_rel_x: int,
	mouse_rel_y: int,
	window_scale: int
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

// TODO: move to proper home
init :: proc() {
	input.dirty_keys = make([dynamic]sdl.Scancode, 5);
	input.dirty_mouse_buttons = make([dynamic]byte, 3);
}

handle_event :: proc(evt: ^sdl.Event) {

}


main :: proc() {
	mouse_down: Mouse_Button_Bits;

	incl(&mouse_down, Mouse_Button.Left);
	fmt.println("incl down:", mouse_down, .Left in mouse_down);

	excl(&mouse_down, Mouse_Button.Left);
	fmt.println("excl down:", mouse_down, .Left in mouse_down);
}

