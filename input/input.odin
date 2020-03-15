package input

import "shared:engine/libs/sdl2"

@(private)
Input :: struct {
	keys: [243]byte,
	dirty_keys: []sdl2.Scancode,
	mouse_buttons: [3]byte,
	dirty_mouse_buttons: []byte,
	mouse_wheel_y: int,
	mouse_rel_x: int,
	mouse_rel_y: int,
	window_scale: int
	// res_scaler &graphics.ResolutionScaler
}

MouseButton :: enum {
	Left = 1,
	Middle = 2,
	Right = 3
}

RELEASED :: 1; // true only the frame the key is released
DOWN :: 2; // true the entire time the key is down
PRESSED :: 3; // only true if down this frame and not down the previous frame



main :: proc() {

}
