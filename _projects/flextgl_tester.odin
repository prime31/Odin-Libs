package main

import "core:fmt"
import "shared:engine/libs/flextgl"
import "shared:engine/libs/sdl"


main :: proc() {
	window := create_window();
	gl_context := sdl.gl_create_context(window);

	flextgl.init();
}

create_window :: proc() -> ^sdl.Window {
	sdl.init(sdl.Init_Flags.Everything);
	window := sdl.create_window("Odin + Sokol + SDL", i32(sdl.Window_Pos.Undefined), i32(sdl.Window_Pos.Undefined), 640, 480, sdl.Window_Flags(sdl.Window_Flags.Allow_High_DPI));

	sdl.gl_set_attribute(sdl.GL_Attr.Context_Flags, i32(sdl.GL_Context_Flag.Forward_Compatible));
	sdl.gl_set_attribute(sdl.GL_Attr.Context_Profile_Mask, i32(sdl.GL_Context_Profile.Core));
	sdl.gl_set_attribute(sdl.GL_Attr.Context_Major_Version, 3);
	sdl.gl_set_attribute(sdl.GL_Attr.Context_Minor_Version, 3);

	sdl.gl_set_attribute(sdl.GL_Attr.Doublebuffer, 1);
	sdl.gl_set_attribute(sdl.GL_Attr.Depth_Size, 24);
	sdl.gl_set_attribute(sdl.GL_Attr.Stencil_Size, 8);

	return window;
}