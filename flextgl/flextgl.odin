package flextgl

import "core:os"
import "core:c"

// when os.OS == "windows" do foreign import lib "flextgl";
// when os.OS == "linux" do foreign import lib "flextgl";
when os.OS == "darwin" do foreign import lib "thirdparty/libflextgl.dylib";

@(default_calling_convention="c")
foreign lib {
	@(link_name="flextInit")
	init :: proc() -> int ---;
}