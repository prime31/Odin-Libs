package fna

import "core:math/linalg"

when ODIN_OS == "windows" do foreign import fna_lib "native/FNA3D.lib"
when ODIN_OS == "linux" do foreign import fna_lib "native/libFNA3D.so"
when ODIN_OS == "darwin" do foreign import fna_lib "native/libFNA3D.dylib"


foreign fna_lib {
	@(link_name = "FNA3D_PrepareWindowAttributes")
	prepare_window_attributes :: proc(debug_mode: u8) -> u32 ---;

	@(link_name = "FNA3D_CreateDevice")
	create_device :: proc(params: Presentation_Parameters) -> ^Device ---;

	@(link_name = "FNA3D_Clear")
	clear :: proc(device: ^Device, options: Clear_Options, color: ^linalg.Vector4, depth: f32 = 0, stencil: i32 = 0) ---;
}
