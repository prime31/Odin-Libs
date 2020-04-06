package fna

// MojoShader/mojoshader

Mojoshader_Effect :: struct {
    error_count: i32,
    errors: ^Error,
    profile: cstring,
    param_count: i32,
    params: ^Effect_Param,
    technique_count: i32,
    techniques: ^Mojoshader_Effect_Technique,
    current_technique: ^Mojoshader_Effect_Technique,
    current_pass: i32,
    object_count: i32,
    objects: ^Effect_Object,
    restore_shader_state: i32,
    state_changes: ^Mojoshader_Effect_State_Changes,
    malloc: proc(), // MOJOSHADER_malloc,
    free: proc(), // MOJOSHADER_free,
    malloc_data: rawptr
}

Mojoshader_Effect_Technique :: struct {
    name: cstring,
    pass_count: u32,
    passes: ^Effect_Pass,
    annotation_count: u32,
    annotations: ^Effect_Annotation
}

Effect_Pass :: struct {}

Effect_Annotation :: struct {}

Effect_Param :: struct {
    effect_value: Effect_Value,
    annotation_count: u32,
    annotations: ^Effect_Annotation
}

Effect_Value :: struct {
    name: cstring,
    semantic: cstring,
    type: Symbol_Type_Info,
    value_count: u32,
    value: struct #raw_union {
    	void: rawptr,
    	int: ^i32,
    	float: ^f32
    }
    // union {
    //     void                           *values,
    //     int                            *valuesI,
    //     float                          *valuesF,
    //     MOJOSHADER_zBufferType         *valuesZBT,
    //     MOJOSHADER_fillMode            *valuesFiM,
    //     MOJOSHADER_shadeMode           *valuesSM,
    //     MOJOSHADER_blendMode           *valuesBM,
    //     MOJOSHADER_cullMode            *valuesCM,
    //     MOJOSHADER_compareFunc         *valuesCF,
    //     MOJOSHADER_fogMode             *valuesFoM,
    //     MOJOSHADER_stencilOp           *valuesSO,
    //     MOJOSHADER_materialColorSource *valuesMCS,
    //     MOJOSHADER_vertexBlendFlags    *valuesVBF,
    //     MOJOSHADER_patchedEdgeStyle    *valuesPES,
    //     MOJOSHADER_debugMonitorTokens  *valuesDMT,
    //     MOJOSHADER_blendOp             *valuesBO,
    //     MOJOSHADER_degreeType          *valuesDT,
    //     MOJOSHADER_textureAddress      *valuesTA,
    //     MOJOSHADER_textureFilterType   *valuesTFT,
    //     MOJOSHADER_effectSamplerState  *valuesSS,
    // };
}

Effect_Object :: struct {
	type: Symbol_Type
	object: struct #raw_union {
		mapping: Sampler_Map
	}
    // MOJOSHADER_symbolType type,
    // union
    // {
    //     MOJOSHADER_effectShader shader,
    //     MOJOSHADER_effectSamplerMap mapping,
    //     MOJOSHADER_effectString string,
    //     MOJOSHADER_effectTexture texture,
    // };
}

Effect_State :: struct {
    // MOJOSHADER_renderStateType type,
    // MOJOSHADER_effectValue value,
}

Mojoshader_Effect_State_Changes :: struct {
    render_state_change_count: u32,
    render_state_changes: ^Effect_State,

    /* Sampler state changes caused by effect technique */
    sampler_state_change_count: u32,
    sampler_state_changes: ^Sampler_State_Register,

    /* Vertex sampler state changes caused by effect technique */
    vertex_sampler_state_change_count: u32,
    vertex_sampler_state_changes: ^Sampler_State_Register
}

Sampler_State_Register :: struct {}

Shader_Type :: enum i32 {
	Unknown = 0,
	Pixel = 1,
	Vertex = 2,
	Geometry = 4,
	Any = -1
}

Attribute_Type :: enum i32 {
	Unknown = -1,
	Byte = 0,
	U_Byte = 1,
	Short = 2,
	U_Short = 3,
	Int = 4,
	Uint = 5,
	Float = 6,
	Double = 7,
	Half_Float = 8
}

Uniform_Type :: enum i32 {
	Unknown = -1,
	Float = 0,
	Int = 1,
	Bool = 2
}

Sampler_Type :: enum i32 {
	Unknown = -1,
	_2D = 0,
	Cube = 1,
	Volume = 2
}

Usage :: enum i32 {
	Unknown = -1,
	Position = 0,
	Blend_Weight = 1,
	Blend_Indices = 2,
	Normal = 3,
	Point_Size = 4,
	Texcoord = 5,
	Tangent = 6,
	Binormal = 7,
	Tess_Factor = 8,
	Positiont = 9,
	Color = 10,
	Fog = 11,
	Depth = 12,
	Sample = 13,
	Total = 14
}

Symbol_Register_Set :: enum i32 {
	Bool = 0,
	Int4 = 1,
	Float4 = 2,
	Sampler = 3,
	Total = 4
}

Symbol_Class :: enum i32 {
	Scalar = 0,
	Vector = 1,
	Matrix_Rows = 2,
	Matrix_Columns = 3,
	Object = 4,
	Struct = 5,
	Total = 6
}

Symbol_Type :: enum i32 {
	Void = 0,
	Bool = 1,
	Int = 2,
	Float = 3,
	String = 4,
	Texture = 5,
	Texture_1D = 6,
	Texture_2D = 7,
	Texture_3D = 8,
	Texturecube = 9,
	Sampler = 10,
	Sampler_1D = 11,
	Sampler_2D = 12,
	Sampler_3D = 13,
	Samplercube = 14,
	Pixelshader = 15,
	Vertexshader = 16,
	Pixelfragment = 17,
	Vertexfragment = 18,
	Unsupported = 19,
	Total = 20
}

Preshader_Opcode :: enum i32 {
	Nop = 0,
	Mov = 1,
	Neg = 2,
	Rcp = 3,
	Frc = 4,
	Exp = 5,
	Log = 6,
	Rsq = 7,
	Sin = 8,
	Cos = 9,
	Asin = 10,
	Acos = 11,
	Atan = 12,
	Min = 13,
	Max = 14,
	Lt = 15,
	Ge = 16,
	Add = 17,
	Mul = 18,
	Atan2 = 19,
	Div = 20,
	Cmp = 21,
	Movc = 22,
	Dot = 23,
	Noise = 24,
	Scalar_Ops = 25,
	Min_Scalar = 25,
	Max_Scalar = 26,
	Lt_Scalar = 27,
	Ge_Scalar = 28,
	Add_Scalar = 29,
	Mul_Scalar = 30,
	Atan2_Scalar = 31,
	Div_Scalar = 32,
	Dot_Scalar = 33,
	Noise_Scalar = 34
}

Preshader_Operand_Type :: enum i32 {
	Input,
	Output,
	Literal,
	Temp
}

Include_Type :: enum i32 {
	Local,
	System
}

Uniform :: struct {
	_type: Uniform_Type,
	index: i32,
	array_count: i32,
	constant: i32,
	name: cstring
}

Constant :: struct {
	_type: Uniform_Type,
	index: i32,
	value: rawptr
}

Sampler :: struct {
	_type: Sampler_Type,
	index: i32,
	name: cstring,
	texbem: i32
}

Sampler_Map :: struct {
	index: i32,
	_type: Sampler_Type
}

Attribute :: struct {
	usage: Usage,
	index: i32,
	name: cstring
}

Swizzle :: struct {
	usage: Usage,
	index: u32,
	swizzles: [4]byte
}

Symbol_Struct_Member :: struct {
	name: cstring,
	info: Symbol_Type_Info
}

Symbol_Type_Info :: struct {
	parameter_class: Symbol_Class,
	parameter_type: Symbol_Type,
	rows: u32,
	columns: u32,
	elements: u32,
	member_count: u32,
	members: ^Symbol_Struct_Member
}

Symbol :: struct {
	name: cstring,
	register_set: Symbol_Register_Set,
	register_index: u32,
	register_count: u32,
	info: Symbol_Type_Info
}

Error :: struct {
	error: cstring,
	filename: cstring,
	error_position: i32
}

Preshader_Operand :: struct {
	_type: Preshader_Operand_Type,
	index: u32,
	array_register_count: u32,
	array_registers: ^u32
}

Preshader_Instruction :: struct {
	opcode: Preshader_Opcode,
	element_count: u32,
	operand_count: u32,
	operands: [4]Preshader_Operand
}

Preshader :: struct {
	literal_count: u32,
	literals: ^f64,
	temp_count: u32,
	symbol_count: u32,
	symbols: ^Symbol,
	instruction_count: u32,
	instructions: ^Preshader_Instruction,
	register_count: u32,
	registers: ^f32,
	malloc: proc(i32, rawptr) -> rawptr,
	free: proc(rawptr, rawptr),
	malloc_data: rawptr
}

Parse_Data :: struct {
	error_count: i32,
	errors: ^Error,
	profile: cstring,
	output: cstring,
	output_len: i32,
	instruction_count: i32,
	shader_type: Shader_Type,
	major_ver: i32,
	minor_ver: i32,
	mainfn: cstring,
	uniform_count: i32,
	uniforms: ^Uniform,
	constant_count: i32,
	constants: ^Constant,
	sampler_count: i32,
	samplers: ^Sampler,
	attribute_count: i32,
	attributes: ^Attribute,
	output_count: i32,
	outputs: ^Attribute,
	swizzle_count: i32,
	swizzles: ^Swizzle,
	symbol_count: i32,
	symbols: ^Symbol,
	preshader: ^Preshader,
	malloc: proc(i32, rawptr) -> rawptr,
	free: proc(rawptr, rawptr),
	malloc_data: rawptr
}

Preprocessor_Define :: struct {
	identifier: cstring,
	definition: cstring
}

Preprocess_Data :: struct {
	error_count: i32,
	errors: ^Error,
	output: cstring,
	output_len: i32,
	malloc: proc(i32, rawptr) -> rawptr,
	free: proc(rawptr, rawptr),
	malloc_data: rawptr
}

Compile_Data :: struct {
	error_count: i32,
	errors: ^Error,
	warning_count: i32,
	warnings: ^Error,
	source_profile: cstring,
	output: cstring,
	output_len: i32,
	symbol_count: i32,
	symbols: ^Symbol,
	malloc: proc(i32, rawptr) -> rawptr,
	free: proc(rawptr, rawptr),
	malloc_data: rawptr
}

Gl_Context :: struct {}

Gl_Shader :: struct {}

Gl_Program :: struct {}

Mtl_Shader :: struct {}

