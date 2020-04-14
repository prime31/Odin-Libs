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


Window_Config :: struct {
	title: cstring,		// the window title as UTF-8 encoded string
	width: i32,			// the preferred width of the window / canvas
	height: i32,		// the preferred height of the window / canvas
	resizable: bool,	// whether the window should be allowed to be resized
	fullscreen: bool,	// whether the window should be created in fullscreen mode
	high_dpi: bool,		// whether the backbuffer is full-resolution on HighDPI displays
}

sdl_window: ^sdl.Window;
@(private)
win_focused: bool;

create :: proc(config: ^Window_Config) {
	flags := cast(sdl.Window_Flags)fna.prepare_window_attributes();
	if config.resizable do flags |= .Resizable;
	if config.high_dpi do flags |= .Allow_High_DPI;
	if config.fullscreen do flags |= .Fullscreen_Desktop;

	sdl_window = sdl.create_window(cstring(config.title), i32(sdl.Window_Pos.Undefined), i32(sdl.Window_Pos.Undefined), config.width, config.height, flags);
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
