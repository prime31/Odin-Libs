package sokol

when #defined(METAL) {
	when ODIN_OS == "darwin" do foreign import metal_lib "native/libsokol_metal.dylib";

	@(default_calling_convention="c")
	@(link_prefix="mu_")
	foreign metal_lib {
		create_metal_layer :: proc(window: rawptr, is_high_dpi: bool) ---;
		get_metal_device :: proc() -> rawptr ---;
		get_render_pass_descriptor :: proc() -> rawptr ---;
		get_drawable :: proc() -> rawptr ---;
		dpi_scale :: proc() -> f32 ---;
		width :: proc() -> f32 ---;
		height :: proc() -> f32 ---;
		set_framebuffer_only :: proc(framebuffer_only: bool) ---;
		set_drawable_size :: proc(width: int, height: int) ---;
		set_display_sync_enabled :: proc(enabled: bool) ---;
	}
}
