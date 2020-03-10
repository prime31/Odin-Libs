package ctest
import "core:os"

when os.OS == "darwin" do foreign import lib "libctest.dylib";

@(default_calling_convention="c")
foreign lib {
	@(link_name="foo_add_int")
    add_int :: proc(a, b: i32) -> i32 ---;
    foo_add_double :: proc(a, b: f64) -> f64 ---;
}