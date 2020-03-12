package fontstash

Flags :: enum i32 {
    Topleft = 1,
    Bottomleft = 2,
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
	LeftMiddle = 17,
	CenterMiddle = 18,
	RightMiddle = 20
}

Error_Code :: enum i32 {
	// Font atlas is full.
	AtlasFull = 1,
	// Scratch memory used to render glyphs is full, requested size reported in 'val', you may need to bump up FONS_SCRATCH_BUF_SIZE.
	ScratchFull = 2,
	// Calls to fonsPushState has created too large stack, if you need deep state stack bump up FONS_MAX_STATES.
	StatesOverflow = 3,
	// Trying to pop too many states fonsPopState().
	StatesUnderflow = 4
}

Params :: struct {
	width i32,
	height i32,
	flags: char,
	userPtr: rawptr,
	renderCreate: proc fn(uptr: rawptr, width: i32, height: i32) i32,
	renderResize: proc fn(uptr: rawptr, width: i32, height: i32) i32,
	renderUpdate: proc fn(uptr: rawptr, rect: ^i32, data: byteptr),
	renderDraw: proc fn(uptr: rawptr, verts: ^f32, tcoords: ^f32, colors: ^u32, nverts: i32),
	renderDelete: proc fn(uptr: rawptr)
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
	prevGlyphIndex: int,
	str: byteptr,
	next: byteptr,
	end: byteptr,
	utf8state: u32
}

Font :: struct {}

Context :: struct {
	params: Params,
	itw: f32,
	ith: f32,
	texData byteptr
}
