package flextgl

import "core:fmt"


when ODIN_OS == "windows" do foreign import gl_lib "system:opengl32.lib";
when ODIN_OS == "windows" do foreign import lib "native/flextGL.lib";
// when ODIN_OS == "linux" do foreign import lib "flextgl";
when ODIN_OS == "darwin" do foreign import lib "native/libflextgl.dylib";

@(default_calling_convention="c")
foreign lib {
	@(link_name="flextInit")
	init :: proc() -> i32 ---;
}


// TODO: windows is a mess and doesnt work
when ODIN_OS == "windows"
{
	import "core:sys/win32";
	
	LibHandle :: win32.Hmodule;

	load_lib :: proc(str: cstring) -> rawptr {
	    //return rawptr(load_library(str));

	    h := win32.load_library_a(str);
	    return LibHandle(h);
	}

	free_lib :: proc(lib: rawptr) {
	    free_library(LibHandle(lib));
	}

	free_library :: proc(lib: LibHandle) {
	    win32.free_library(win32.Hmodule(lib));
	}
}