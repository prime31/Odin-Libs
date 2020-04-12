package imgui

import "shared:engine/libs/sdl"
import "shared:engine/libs/fna"

impl_fna_init :: proc(device: ^fna.Device, window: ^sdl.Window) {
	fna_init(device);
	sdl_init(window);
}

impl_fna_new_frame :: proc(window: ^sdl.Window) {
	width, height : i32;
	fna.get_drawable_size(window, &width, &height);
	sdl_new_frame(window, width, height);
	new_frame();
}
