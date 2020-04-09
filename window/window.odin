package window

import "shared:engine/libs/fna"
import "shared:engine/libs/sdl"

WindowMode :: enum i32 {
	Windowed = 0,
	Full_Screen = 1,
	Desktop = 4097
}

WindowEvents :: enum i32 {
	Resize
}


// pub struct WindowConfig {
// 	title string
// 	width int
// 	height int
// 	resizable bool
// 	fullscreen bool
// 	vsync bool
// 	highdpi bool
// }

sdl_window: ^sdl.Window;
@(private)
win_focused: bool;

create :: proc(width, height: i32) {
	// mut window_flags := C.SDL_WINDOW_OPENGL | C.SDL_WINDOW_MOUSE_FOCUS
	// if config.resizable { window_flags = window_flags | C.SDL_WINDOW_RESIZABLE }
	// if config.highdpi { window_flags = window_flags | C.SDL_WINDOW_ALLOW_HIGHDPI }
	// if config.fullscreen { window_flags = window_flags | C.SDL_WINDOW_FULLSCREEN }

	flags := cast(sdl.Window_Flags)fna.prepare_window_attributes();
	sdl_window = sdl.create_window("Odin FNA", i32(sdl.Window_Pos.Undefined), i32(sdl.Window_Pos.Undefined), width, height, flags);
}

swap :: proc(device: ^fna.Device) {
	fna.swap_buffers(device, nil, nil, sdl_window);
}

handle_event :: proc(evt: ^sdl.Event) {
	#partial switch evt.window.event {
		case .Size_Changed: {}
		case .Focus_Gained: win_focused = true;
		case .Focus_Lost: win_focused = false;
	}
}

subscribe :: proc(evt: WindowEvents, callback: proc(), ctx: rawptr, once: bool) {
	// TODO
	//w.evt_emitter.subscribe(int(evt), callback, ctx, once)
}

unsubscribe :: proc(evt: WindowEvents, callback: proc()) {
	// TODO
	//w.evt_emitter.unsubscribe(int(evt), callback)
}

// returns the drawable size / the window size. Used to scale mouse coords when the OS gives them to us in points.
scale :: proc() -> f32 {
	wx, _ := size();
	dx, _ := drawable_size();
	return cast(f32)dx / cast(f32)wx;
}

drawable_size :: proc() -> (i32, i32) {
	width, height: i32;
	fna.get_drawable_size(sdl_window, &width, &height);
	return width, height;
}

size :: proc() -> (i32, i32) {
	width, height: i32;
	sdl.get_window_size(sdl_window, &width, &height);
	return width, height;
}

width :: proc() -> i32 {
	w, _ := size();
	return w;
}

height :: proc() -> i32 {
	_, h := size();
	return h;
}

focused :: proc() -> bool {
	return win_focused;
}

set_size :: proc(width, height: i32) {
	sdl.set_window_size(sdl_window, width, height);
}

set_fullscreen :: proc(mode: WindowMode) {
	sdl.set_window_fullscreen(sdl_window, cast(u32)mode);
}
