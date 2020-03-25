package fna

Device :: struct {}

Presentation_Parameters :: struct {
	back_buffer_width: i32,
	back_buffer_height: i32,
	back_buffer_format: Surface_Format,
	multi_sample_count: i32,
	device_window_handle: rawptr,
	is_full_screen: u8,
	depth_stencil_format: Depth_Format,
	presentation_interval: Present_Interval,
	display_orientation: Display_Orientation,
	render_target_usage: Render_Target_Usage
}


Surface_Format :: enum i32 {
	Color,
	Bgr565,
	Bgra5551,
	Bgra4444,
	Dxt1,
	Dxt3,
	Dxt5,
	Normalized_Byte2,
	Normalized_Byte4,
	Rgba1010102,
	Rg32,
	Rgba64,
	Alpha8,
	Single,
	Vector2,
	Vector4,
	Half_Single,
	Half_Vector2,
	Half_Vector4,
	Hdr_Blendable,
	Color_Bgra_Ext
}

Depth_Format :: enum i32 {
	None,
	D16,
	D24,
	D24s8
}

Present_Interval :: enum i32 {
	Default,
	One,
	Two,
	Immediate
}

Display_Orientation :: enum i32 {
	Default,
	Landscape_Left,
	Landscape_Right,
	Portrait
}

Render_Target_Usage :: enum i32 {
	Discard_Contents,
	Preserve_Contents,
	Platform_Contents
}
