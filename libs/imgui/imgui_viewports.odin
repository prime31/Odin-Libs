package imgui

import "core:fmt"
import "shared:engine/libs/sdl"

@(private)
Viewport_Data :: struct {
	window: ^sdl.Window,
	window_id: u32,
	window_owned: bool,
	gl_context: sdl.GL_Context
}

init_platform_interface :: proc(window: ^sdl.Window) {
	io := get_platform_io();
	io.create_window = platform_create_window;
	io.destroy_window = platform_destroy_window;
	io.show_window = platform_show_window;
	io.set_window_position = platform_set_window_position;
	io.get_window_position = platform_get_window_position;
	io.set_window_size = platform_set_window_size;
	io.get_window_size = platform_get_window_size;
	io.set_window_focus = platform_set_window_focus;
	io.get_window_focus = platform_get_window_focus;
	io.get_window_minimized = platform_get_window_minimized;
	io.set_window_title = platform_set_window_title;
	io.set_window_alpha = platform_set_window_alpha;
	io.update_window = platform_update_window;
	io.render_window = platform_render_window;
	io.swap_buffers = platform_swap_buffers;

	sdl.set_hint("SDL_HINT_MOUSE_FOCUS_CLICKTHROUGH", "1");

	data := new(Viewport_Data);
	data.window = window;
	data.window_id = sdl.get_window_id(window);
	data.window_owned = false;
	data.gl_context = sdl.gl_get_current_context();

	main_vp := get_main_viewport();
	main_vp.platform_user_data = data;
}

platform_create_window :: proc "c" (vp: Viewport) {
	fmt.println("create window");
}

platform_destroy_window :: proc "c" (vp: Viewport) {

}

platform_show_window :: proc "c" (vp: Viewport) {

}

platform_set_window_position :: proc "c" (vp: Viewport, pos: Vec2) {

}

platform_get_window_position :: proc "c" (vp: Viewport) -> Vec2 {
	return {0,0};
}

platform_set_window_size :: proc "c" (vp: Viewport, pos: Vec2) {

}

platform_get_window_size :: proc "c" (vp: Viewport) -> Vec2 {
	return {0,0};
}

platform_set_window_focus :: proc "c" (vp: Viewport) {

}

platform_get_window_focus :: proc "c" (vp: Viewport) -> bool {
	return false;
}

platform_get_window_minimized :: proc "c" (vp: Viewport) -> bool {
	return false;
}

platform_set_window_title :: proc "c" (vp: Viewport, str: cstring) {

}

platform_set_window_alpha :: proc "c" (vp: Viewport, alpha: f32) {

}

platform_update_window :: proc "c" (vp: Viewport) {

}

platform_render_window :: proc "c" (vp: Viewport, render_arg: rawptr) {

}

platform_swap_buffers :: proc "c" (vp: Viewport, render_arg: rawptr) {

}
