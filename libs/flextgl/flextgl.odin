package flextgl

import "core:fmt"



when ODIN_OS == "windows" do foreign import gl_lib "system:opengl32.lib";
when ODIN_OS == "windows" do @force foreign import lib "native/flextGL.lib";
// when ODIN_OS == "linux" do foreign import lib "flextgl";
when ODIN_OS == "darwin" do foreign import lib "native/libflextgl.dylib";

@(default_calling_convention="c")
foreign lib {
	@(link_name="flextInit")
	init :: proc() -> i32 ---;
}
