package fontstash

Flags :: enum u8 {
    Top_Left = 1,
    Bottom_Left = 2,
}

Align :: enum i32 {
	// Horizontal align
	Left 		= 1,	// Default
	Center 		= 2,
	Right 		= 4,
	// Vertical align
	Top 		= 8,
	Middle		= 16,
	Bottom		= 32,
	Baseline	= 64, // Default
	Default		= 65,
	// Combos
	Left_Middle = 17,
	Center_Middle = 18,
	Right_Middle = 20
}

Error_Code :: enum i32 {
	// Font atlas is full.
	Atlas_Full = 1,
	// Scratch memory used to render glyphs is full, requested size reported in 'val', you may need to bump up FONS_SCRATCH_BUF_SIZE.
	Scratch_Full = 2,
	// Calls to fonsPushState has created too large stack, if you need deep state stack bump up FONS_MAX_STATES.
	States_Overflow = 3,
	// Trying to pop too many states fonsPopState().
	States_Underflow = 4
}

Params :: struct {
	width: i32,
	height: i32,
	flags: byte,
	user_ptr: rawptr,
	render_create: proc "c" (uptr: rawptr, width: i32, height: i32) -> i32,
	render_resize: proc "c" (uptr: rawptr, width: i32, height: i32) -> i32,
	render_update: proc "c" (uptr: rawptr, rect: ^i32, data: ^byte),
	render_draw: proc "c" (uptr: rawptr, verts: ^f32, tcoords: ^f32, colors: ^u32, nverts: i32),
	render_delete: proc "c" (uptr: rawptr)
}

Quad :: struct {
	x0: f32,
	y0: f32,
	s0: f32,
	t0: f32,
	x1: f32,
	y1: f32,
	s1: f32,
	t1: f32
}

Text_Iter :: struct {
	x: f32,
	y: f32,
	nextx: f32,
	nexty: f32,
	scale: f32,
	spacing: f32,
	color: u32,
	codepoint: u32,
	isize: i16,
	iblur: i16,
	font: ^Font,
	prev_glyph_index: i32,
	str: ^byte,
	next: ^byte,
	end: ^byte,
	utf8_state: u32
}

Font :: struct {}

Context :: struct {
	params: Params,
	itw: f32,
	ith: f32,
	tex_data: ^byte
	// omitted rest of struct
}
