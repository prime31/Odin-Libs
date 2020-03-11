package flextgl


// when ODIN_OS == "windows" do foreign import lib "flextgl";
// when ODIN_OS == "linux" do foreign import lib "flextgl";
when ODIN_OS == "darwin" do foreign import lib "native/libflextgl.dylib";

@(default_calling_convention="c")
foreign lib {
	@(link_name="flextInit")
	init :: proc() -> i32 ---;
}