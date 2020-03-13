package sokol

Backend :: enum i32 {
    Glcore33,
    Gles2,
    Gles3,
    D3d11,
    Metal_Ios,
    Metal_Macos,
    Metal_Simulator,
    Dummy,
}

Pixel_Format :: enum i32 {
    _Default,
    NONE,

    R8,
    R8SN,
    R8UI,
    R8SI,

    R16,
    R16SN,
    R16UI,
    R16SI,
    R16F,
    RG8,
    RG8SN,
    RG8UI,
    RG8SI,

    R32UI,
    R32SI,
    R32F,
    RG16,
    RG16SN,
    RG16UI,
    RG16SI,
    RG16F,
    RGBA8,
    RGBA8SN,
    RGBA8UI,
    RGBA8SI,
    BGRA8,
    RGB10A2,
    RG11B10F,

    RG32UI,
    RG32SI,
    RG32F,
    RGBA16,
    RGBA16SN,
    RGBA16UI,
    RGBA16SI,
    RGBA16F,

    RGBA32UI,
    RGBA32SI,
    RGBA32F,

    DEPTH,
    DEPTH_STENCIL,

    BC1_RGBA,
    BC2_RGBA,
    BC3_RGBA,
    BC4_R,
    BC4_RSN,
    BC5_RG,
    BC5_RGSN,
    BC6H_RGBF,
    BC6H_RGBUF,
    BC7_RGBA,
    PVRTC_RGB_2BPP,
    PVRTC_RGB_4BPP,
    PVRTC_RGBA_2BPP,
    PVRTC_RGBA_4BPP,
    ETC2_RGB8,
    ETC2_RGB8A1,

    _num
}

Resource_State :: enum i32 {
    Initial,
    Alloc,
    Valid,
    Failed,
    Invalid,
}

Usage :: enum i32 {
    _Default,
    Immutable,
    Dynamic,
    Stream,
    _Num
}

Buffer_Type :: enum i32 {
    _Default,
    Vertexbuffer,
    Indexbuffer,
    _Num
}

Index_Type :: enum i32 {
    _Default,
    None,
    Uint16,
    Uint32,
    _Num
}

Image_Type :: enum i32 {
    _Default,
    D2,
    Cube,
    D3,
    Array,
    _Num
}

Cube_Face :: enum i32 {
   Pos_X,
   Neg_X,
   Pos_Y,
   Neg_Y,
   Pos_Z,
   Neg_Z,
   Num,
}

Shader_Stage :: enum i32 {
    Vs,
    Fs,
}

Primitive_Type :: enum i32 {
    _Default,
    Points,
    Lines,
    Line_Strip,
    Triangles,
    Triangle_Strip,
    _Num
}

Filter :: enum i32 {
    _Default,
    Nearest,
    Linear,
    Nearest_Mipmap_Nearest,
    Nearest_Mipmap_Linear,
    Linear_Mipmap_Nearest,
    Linear_Mipmap_Linear,
    _Num
}

Wrap :: enum i32 {
    _Default,
    Repeat,
    Clamp_To_Edge,
    Clamp_To_Border,
    Mirrored_Repeat,
    _Num
}

Border_Color :: enum i32 {
    _Default,
    Transparent_Black,
    Opaque_Black,
    Opaque_White,
    _Num
}

Vertex_Format :: enum i32 {
    Invalid,
    Float,
    Float2,
    Float3,
    Float4,
    Byte4,
    Byte4n,
    Ubyte4,
    Ubyte4n,
    Short2,
    Short2n,
    Ushort2n,
    Short4,
    Short4n,
    Ushort4n,
    Uint10_N2,
    _Num
}

Vertex_Step :: enum i32 {
    _Default,
    Per_Vertex,
    Per_Instance,
    _Num
}

Uniform_Type :: enum i32 {
    Invalid,
    Float,
    Float2,
    Float3,
    Float4,
    Mat4,
    _Num
}

Cull_Mode :: enum i32 {
    _Default,
    None,
    Front,
    Back,
    _Num
}

Face_Winding :: enum i32 {
    _Default,
    Ccw,
    Cw,
    _Num
}

Compare_Func :: enum i32 {
    _Default,
    Never,
    Less,
    Equal,
    Less_Equal,
    Greater,
    Not_Equal,
    Greater_Equal,
    Always,
    _Num
}

Stencil_Op :: enum i32 {
    _Default,
    Keep,
    Zero,
    Replace,
    Incr_Clamp,
    Decr_Clamp,
    Invert,
    Incr_Wrap,
    Decr_Wrap,
    _Num
}

Blend_Factor :: enum i32 {
    _Default,
    Zero,
    One,
    Src_Color,
    One_Minus_Src_Color,
    Src_Alpha,
    One_Minus_Src_Alpha,
    Dst_Color,
    One_Minus_Dst_Color,
    Dst_Alpha,
    One_Minus_Dst_Alpha,
    Src_Alpha_Saturated,
    Blend_Color,
    One_Minus_Blend_Color,
    Blend_Alpha,
    One_Minus_Blend_Alpha,
    _Num
}

Blend_Op :: enum i32 {
    _Default,
    Add,
    Subtract,
    Reverse_Subtract,
    _Num
}

COLOR_MASK__Default :: 0;
COLOR_MASK_NONE :: (0x10);
COLOR_MASK_R :: (1<<0);
COLOR_MASK_G :: (1<<1);
COLOR_MASK_B :: (1<<2);
COLOR_MASK_A :: (1<<3);
COLOR_MASK_RGB :: 0x7;
COLOR_MASK_RGBA :: 0xF;

Action :: enum i32 {
    _Default,
    Clear,
    Load,
    Dont_Care,
    _Num
}
