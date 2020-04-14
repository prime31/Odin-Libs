package fna

// include/FNA3D

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

Clear_Options :: enum i32 {
	Target = 1,
	Depth_Buffer = 2,
	Stencil = 4,
	All = Target | Depth_Buffer | Stencil
}

Primitive_Type :: enum i32 {
	Triangle_List,
	Triangle_Strip,
	Line_List,
	Line_Strip,
	Point_List_Ext
}

Index_Element_Size :: enum i32 {
	_16_Bit,
	_32_Bit
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
	D24_S8
}

Cube_Map_Face :: enum i32 {
	Positive_X,
	Negative_X,
	Positive_Y,
	Negative_Y,
	Positive_Z,
	Negative_Z
}

Buffer_Usage :: enum i32 {
	None,
	Write_Only
}

Set_Data_Options :: enum i32 {
	None,
	Discard,
	No_Overwrite
}

Blend :: enum i32 {
	One,
	Zero,
	Source_Color,
	Inverse_Source_Color,
	Source_Alpha,
	Inverse_Source_Alpha,
	Destination_Color,
	Inverse_Destination_Color,
	Destination_Alpha,
	Inverse_Destination_Alpha,
	Blend_Factor,
	Inverse_Blend_Factor,
	Source_Alpha_Saturation
}

Blend_Function :: enum i32 {
	Add,
	Subtract,
	Reverse_Subtract,
	Max,
	Min
}

Color_Write_Channels :: enum i32 {
	None = 0,
	Red = 1,
	Green = 2,
	Blue = 4,
	Alpha = 8,
	All = 15
}

Stencil_Operation :: enum i32 {
	Keep,
	Zero,
	Replace,
	Increment,
	Decrement,
	Increment_Saturation,
	Decrement_Saturation,
	Invert
}

Compare_Function :: enum i32 {
	Always,
	Never,
	Less,
	Less_Equal,
	Equal,
	Greater_Equal,
	Greater,
	Not_Equal
}

Cull_Mode :: enum i32 {
	None,
	Cull_Clockwise_Face,
	Cull_Counter_Clockwise_Face
}

Fill_Mode :: enum i32 {
	Solid,
	Wireframe
}

Texture_Address_Mode :: enum i32 {
	Wrap,
	Clamp,
	Mirror
}

Texture_Filter :: enum i32 {
	Linear,
	Point,
	Anisotropic,
	Linear_Mippoint,
	Point_Miplinear,
	Minlinear_Magpoint_Miplinear,
	Minlinear_Magpoint_Mippoint,
	Minpoint_Maglinear_Miplinear,
	Minpoint_Maglinear_Mippoint
}

Vertex_Element_Format :: enum i32 {
	Single,
	Vector2,
	Vector3,
	Vector4,
	Color,
	Byte4,
	Short2,
	Short4,
	Normalized_Short2,
	Normalized_Short4,
	Half_Vector2,
	Half_Vector4
}

Vertex_Element_Usage :: enum i32 {
	Position,
	Color,
	Texture_Coordinate,
	Normal,
	Binormal,
	Tangent,
	Blend_Indices,
	Blend_Weight,
	Depth,
	Fog,
	Point_Size,
	Sample,
	Tesselate_Factor
}

Device :: struct {}

Texture :: struct {
	// OpenGL only! Used for ImGui custom textures
	handle: u32
}

Buffer :: struct {}

Renderbuffer :: struct {}

Effect :: struct {}

Query :: struct {}

Color :: struct {
	r: u8,
	g: u8,
	b: u8,
	a: u8
}

Rect :: struct {
	x: i32,
	y: i32,
	w: i32,
	h: i32
}

Vec4 :: struct {
	x: f32,
	y: f32,
	z: f32,
	w: f32
}

Viewport :: struct {
	x: i32,
	y: i32,
	w: i32,
	h: i32,
	min_depth: f32,
	max_depth: f32
}

Blend_State :: struct {
	color_source_blend: Blend,
	color_destination_blend: Blend,
	color_blend_function: Blend_Function,
	alpha_source_blend: Blend,
	alpha_destination_blend: Blend,
	alpha_blend_function: Blend_Function,
	color_write_enable: Color_Write_Channels,
	color_write_enable1: Color_Write_Channels,
	color_write_enable2: Color_Write_Channels,
	color_write_enable3: Color_Write_Channels,
	blend_factor: Color,
	multi_sample_mask: i32
}

Depth_Stencil_State :: struct {
	depth_buffer_enable: u8,
	depth_buffer_write_enable: u8,
	depth_buffer_function: Compare_Function,
	stencil_enable: u8,
	stencil_mask: i32,
	stencil_write_mask: i32,
	two_sided_stencil_mode: u8,
	stencil_fail: Stencil_Operation,
	stencil_depth_buffer_fail: Stencil_Operation,
	stencil_pass: Stencil_Operation,
	stencil_function: Compare_Function,
	ccw_stencil_fail: Stencil_Operation,
	ccw_stencil_depth_buffer_fail: Stencil_Operation,
	ccw_stencil_pass: Stencil_Operation,
	ccw_stencil_function: Compare_Function,
	reference_stencil: i32
}

Rasterizer_State :: struct {
	fill_mode: Fill_Mode,
	cull_mode: Cull_Mode,
	depth_bias: f32,
	slope_scale_depth_bias: f32,
	scissor_test_enable: u8,
	multi_sample_anti_alias: u8
}

Sampler_State :: struct {
	filter: Texture_Filter,
	address_u: Texture_Address_Mode,
	address_v: Texture_Address_Mode,
	address_w: Texture_Address_Mode,
	mip_map_level_of_detail_bias: f32,
	max_anisotropy: i32,
	max_mip_level: i32
}

Vertex_Element :: struct {
	offset: i32,
	vertex_element_format: Vertex_Element_Format,
	vertex_element_usage: Vertex_Element_Usage,
	usage_index: i32
}

Vertex_Declaration :: struct {
	vertex_stride: i32,
	element_count: i32,
	elements: ^Vertex_Element
}

Vertex_Buffer_Binding :: struct {
	vertex_buffer: ^Buffer,
	vertex_declaration: Vertex_Declaration,
	vertex_offset: i32,
	instance_frequency: i32
}

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

Render_Target_Binding :: struct {
	type: u8, // 2D = 0, Cube = 1
	width: i32,
	height: i32,
	level_count: i32,
	multi_sample_count: i32,
	texture: ^Texture,
	color_buffer: ^Renderbuffer
}

// Mojoshader_Effect :: struct {}

// Mojoshader_Effect_Technique :: struct {}

// Mojoshader_Effect_State_Changes :: struct {}

