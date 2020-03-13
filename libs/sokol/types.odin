package sokol


Buffer   :: struct { id: u32 }
Image    :: struct { id: u32 }
Shader   :: struct { id: u32 }
Pipeline :: struct { id: u32 }
Pass     :: struct { id: u32 }
Ctx      :: struct { id: u32 }


INVALID_ID              :: 0;
NUM_SHADER_STAGES       :: 2;
NUM_INFLIGHT_FRAMES     :: 2;
MAX_COLOR_ATTACHMENTS   :: 4;
MAX_SHADERSTAGE_BUFFERS :: 8;
MAX_SHADERSTAGE_IMAGES  :: 12;
MAX_SHADERSTAGE_UBS     :: 4;
MAX_UB_MEMBERS          :: 16;
MAX_VERTEX_ATTRIBUTES   :: 16;
MAX_MIPMAPS             :: 16;
MAX_TEXTUREARRAY_LAYERS :: 128;


Pixel_Format_Info :: struct {
    sample: bool,
    filter: bool,
    render: bool,
    blend:  bool,
    msaa:   bool,
    depth:  bool,
}

Features :: struct {
    instancing:              bool,
    origin_top_left:         bool,
    multiple_render_targets: bool,
    msaa_render_targets:     bool,
    imagetype_3d:            bool,
    imagetype_array:         bool,
    image_clamp_to_border:   bool,
}

Limits :: struct {
    max_image_size_2d:      u32,
    max_image_size_cube:    u32,
    max_image_size_3d:      u32,
    max_image_size_array:   u32,
    max_image_array_layers: u32,
    max_vertex_attrs:       u32,
}

Color_Attachment_Action :: struct {
    action: Action,
    val:    [4]f32,
}

Depth_Attachment_Action :: struct {
    action: Action,
    val:    f32,
}

Stencil_Attachment_Action :: struct {
    action: Action,
    val:    u8,
}

Pass_Action :: struct {
    _start_canary: u32,
    colors:        [MAX_COLOR_ATTACHMENTS]Color_Attachment_Action,
    depth:         Depth_Attachment_Action,
    stencil:       Stencil_Attachment_Action,
    _end_canary:   u32,
}


Bindings :: struct {
    _start_canary:         u32,
    vertex_buffers:        [MAX_SHADERSTAGE_BUFFERS]Buffer,
    vertex_buffer_offsets: [MAX_SHADERSTAGE_BUFFERS]i32,
    index_buffer:          Buffer,
    index_buffer_offset:   i32,
    vs_images:             [MAX_SHADERSTAGE_IMAGES]Image,
    fs_images:             [MAX_SHADERSTAGE_IMAGES]Image,
    _end_canary:           u32,
}


Buffer_Desc :: struct {
    _start_canary: u32,
    size:          i32,
    type:          Buffer_Type,
    usage:         Usage,
    content:       rawptr,
    label:         cstring,

    gl_buffers:    [NUM_INFLIGHT_FRAMES]u32,

    mtl_buffers:   [NUM_INFLIGHT_FRAMES]rawptr,

    d3d11_buffer:  rawptr,
    _end_canary:   u32,
}


Subimage_Content :: struct {
    ptr: rawptr,
    size: i32,
}


Image_Content :: struct {
    subimage: [Cube_Face.Num][MAX_MIPMAPS]Subimage_Content,
}


Image_Desc :: struct {
    _start_canary:  u32,
    type:           Image_Type,
    render_target:  bool,
    width:          i32,
    height:         i32,
    using dl: struct #raw_union {
        depth:      i32,
        layers:     i32,
    },
    num_mipmaps:    i32,
    usage:          Usage,
    pixel_format:   Pixel_Format,
    sample_count:   i32,
    min_filter:     Filter,
    mag_filter:     Filter,
    wrap_u:         Wrap,
    wrap_v:         Wrap,
    wrap_w:         Wrap,
    border_color:   Border_Color,
    max_anisotropy: u32,
    min_lod:        f32,
    max_lod:        f32,
    content:        Image_Content,
    label:          cstring,

    gl_textures:    [NUM_INFLIGHT_FRAMES]u32,

    mtl_textures:   [NUM_INFLIGHT_FRAMES]rawptr,

    d3d11_texture:  rawptr,
    _end_canary:    u32,
}


Shader_Attr_Desc :: struct {
    name:      cstring,
    sem_name:  cstring,
    sem_index: i32,
}

Shader_Uniform_Desc :: struct {
    name:        cstring,
    type:        Uniform_Type,
    array_count: i32,
}

Shader_Uniform_Block_Desc :: struct {
    size:     i32,
    uniforms: [MAX_UB_MEMBERS]Shader_Uniform_Desc,
}

Shader_Image_Desc :: struct {
    name: cstring,
    type: Image_Type,
}

Shader_Stage_Desc :: struct {
    source:         cstring,
    byte_code:      ^u8,
    byte_code_size: i32,
    entry:          cstring,
    uniform_blocks: [MAX_SHADERSTAGE_UBS]Shader_Uniform_Block_Desc,
    images:         [MAX_SHADERSTAGE_IMAGES]Shader_Image_Desc,
}

Shader_Desc :: struct {
    _start_canary: u32,
    attrs:         [MAX_VERTEX_ATTRIBUTES]Shader_Attr_Desc,
    vs:            Shader_Stage_Desc,
    fs:            Shader_Stage_Desc,
    label:         cstring,
    _end_canary:   u32,
}


Buffer_Layout_Desc :: struct {
    stride:    i32,
    step_func: Vertex_Step,
    step_rate: i32,
}

Vertex_Attr_Desc :: struct {
    buffer_index: i32,
    offset:       i32,
    format:       Vertex_Format,
}

Layout_Desc :: struct {
    buffers: [MAX_SHADERSTAGE_BUFFERS]Buffer_Layout_Desc,
    attrs:   [MAX_VERTEX_ATTRIBUTES]Vertex_Attr_Desc,
}

Stencil_State :: struct {
    fail_op:       Stencil_Op,
    depth_fail_op: Stencil_Op,
    pass_op:       Stencil_Op,
    compare_func:  Compare_Func,
}

Depth_Stencil_State :: struct {
    stencil_front:       Stencil_State,
    stencil_back:        Stencil_State,
    depth_compare_func:  Compare_Func,
    depth_write_enabled: bool,
    stencil_enabled:     bool,
    stencil_read_mask:   u8,
    stencil_write_mask:  u8,
    stencil_ref:         u8,
}

Blend_State :: struct {
    enabled:                bool,
    src_factor_rgb:         Blend_Factor,
    dst_factor_rgb:         Blend_Factor,
    op_rgb:                 Blend_Op,
    src_factor_alpha:       Blend_Factor,
    dst_factor_alpha:       Blend_Factor,
    op_alpha:               Blend_Op,
    color_write_mask:       u8,
    color_attachment_count: i32,
    color_format:           Pixel_Format,
    depth_format:           Pixel_Format,
    blend_color:            [4]f32,
}

Rasterizer_State :: struct {
    alpha_to_coverage_enabled: bool,
    cull_mode:                 Cull_Mode,
    face_winding:              Face_Winding,
    sample_count:              i32,
    depth_bias:                f32,
    depth_bias_slope_scale:    f32,
    depth_bias_clamp:          f32,
}

Pipeline_Desc :: struct {
    _start_canary:  u32,
    layout:         Layout_Desc,
    shader:         Shader,
    primitive_type: Primitive_Type,
    index_type:     Index_Type,
    depth_stencil:  Depth_Stencil_State,
    blend:          Blend_State,
    rasterizer:     Rasterizer_State,
    label:          cstring,
    _end_canary:    u32,
}

Attachment_Desc :: struct {
    image: Image,
    mip_level: i32,
    using data: struct #raw_union {
        face:  i32,
        layer: i32,
        slice: i32,
    },
}

Pass_Desc :: struct {
    _start_canary:            u32,
    color_attachments:        [MAX_COLOR_ATTACHMENTS]Attachment_Desc,
    depth_stencil_attachment: Attachment_Desc,
    label:                    cstring,
    _end_canary:              u32,
}

Trace_Hooks :: struct {
    user_data: rawptr,
    reset_state_cache:           proc "c" (user_data: rawptr),
    make_buffer:                 proc "c" (desc: ^Buffer_Desc,   result: Buffer,   user_data: rawptr),
    make_image:                  proc "c" (desc: ^Image_Desc,    result: Image,    user_data: rawptr),
    make_shader:                 proc "c" (desc: ^Shader_Desc,   result: Shader,   user_data: rawptr),
    make_pipeline:               proc "c" (desc: ^Pipeline_Desc, result: Pipeline, user_data: rawptr),
    make_pass:                   proc "c" (desc: ^Pass_Desc,     result: Pass,     user_data: rawptr),
    destroy_buffer:              proc "c" (buf: Buffer,   user_data: rawptr),
    destroy_image:               proc "c" (img: Image,    user_data: rawptr),
    destroy_shader:              proc "c" (shd: Shader,   user_data: rawptr),
    destroy_pipeline:            proc "c" (pip: Pipeline, user_data: rawptr),
    destroy_pass:                proc "c" (pass: Pass,    user_data: rawptr),
    update_buffer:               proc "c" (buf: Buffer, data_ptr: rawptr, data_size: i32, user_data: rawptr),
    update_image:                proc "c" (img: Image, data: ^Image_Content, user_data: rawptr),
    append_buffer:               proc "c" (buf: Buffer, data_ptr: rawptr, data_size: i32, result: i32, user_data: rawptr),
    begin_default_pass:          proc "c" (pass_action: ^Pass_Action, width, height: i32, user_data: rawptr),
    begin_pass:                  proc "c" (pass: Pass, pass_action: ^Pass_Action, user_data: rawptr),
    apply_viewport:              proc "c" (x, y, width, height: i32, origin_top_left: bool, user_data: rawptr),
    apply_scissor_rect:          proc "c" (x, y, width, height: i32, origin_top_left: bool, user_data: rawptr),
    apply_pipeline:              proc "c" (pip: Pipeline, user_data: rawptr),
    apply_bindings:              proc "c" (bindings: ^Bindings, user_data: rawptr),
    apply_uniforms:              proc "c" (stage: Shader_Stage, ub_index: i32, data: rawptr, num_bytes: i32, user_data: rawptr),
    draw:                        proc "c" (base_element, num_elements, num_instances: i32, user_data: rawptr),
    end_pass:                    proc "c" (user_data: rawptr),
    commit:                      proc "c" (user_data: rawptr),
    alloc_buffer:                proc "c" (result: Buffer,   user_data: rawptr),
    alloc_image:                 proc "c" (result: Image,    user_data: rawptr),
    alloc_shader:                proc "c" (result: Shader,   user_data: rawptr),
    alloc_pipeline:              proc "c" (result: Pipeline, user_data: rawptr),
    alloc_pass:                  proc "c" (result: Pass,     user_data: rawptr),
    init_buffer:                 proc "c" (buf_id: Buffer,    desc: ^Buffer_Desc,   user_data: rawptr),
    init_image:                  proc "c" (img_id: Image,     desc: ^Image_Desc,    user_data: rawptr),
    init_shader:                 proc "c" (shd_id: Shader,    desc: ^Shader_Desc,   user_data: rawptr),
    init_pipeline:               proc "c" (pip_id: Pipeline,  desc: ^Pipeline_Desc, user_data: rawptr),
    init_pass:                   proc "c" (pass_id: Pass,     desc: ^Pass_Desc,     user_data: rawptr),
    fail_buffer:                 proc "c" (buf_id: Buffer,   user_data: rawptr),
    fail_image:                  proc "c" (img_id: Image,    user_data: rawptr),
    fail_shader:                 proc "c" (shd_id: Shader,   user_data: rawptr),
    fail_pipeline:               proc "c" (pip_id: Pipeline, user_data: rawptr),
    fail_pass:                   proc "c" (pass_id: Pass,    user_data: rawptr),
    push_debug_group:            proc "c" (name: cstring,    user_data: rawptr),
    pop_debug_group:             proc "c" (user_data: rawptr),
    err_buffer_pool_exhausted:   proc "c" (user_data: rawptr),
    err_image_pool_exhausted:    proc "c" (user_data: rawptr),
    err_shader_pool_exhausted:   proc "c" (user_data: rawptr),
    err_pipeline_pool_exhausted: proc "c" (user_data: rawptr),
    err_pass_pool_exhausted:     proc "c" (user_data: rawptr),
    err_context_mismatch:        proc "c" (user_data: rawptr),
    err_pass_invalid:            proc "c" (user_data: rawptr),
    err_draw_invalid:            proc "c" (user_data: rawptr),
    err_bindings_invalid:        proc "c" (user_data: rawptr),
}


Slot_Info :: struct {
    state: Resource_State,
    res_id: u32,
    ctx_id: u32,
}

Buffer_Info :: struct {
    slot:               Slot_Info,
    update_frame_index: u32,
    append_frame_index: u32,
    append_pos:         i32,
    append_overflow:    bool,
    num_slots:          i32,
    active_slot:        i32,
}

Image_Info :: struct {
    slot:            Slot_Info,
    upd_frame_index: u32,
    num_slots:       i32,
    active_slot:     i32,
}

Shader_Info :: struct {
    slot: Slot_Info,
}

Pipeline_Info :: struct {
    slot: Slot_Info,
}

Pass_Info :: struct {
    slot: Slot_Info,
}

Desc :: struct {
    _start_canary:                  u32,
    buffer_pool_size:               i32,
    image_pool_size:                i32,
    shader_pool_size:               i32,
    pipeline_pool_size:             i32,
    pass_pool_size:                 i32,
    context_pool_size:              i32,

    gl_force_gles2:                 bool,

    mtl_device:                     rawptr,
    mtl_renderpass_descriptor_cb:   proc "c" () -> rawptr,
    mtl_drawable_cb:                proc "c" () -> rawptr,
    mtl_global_uniform_buffer_size: i32,
    mtl_sampler_cache_size:         i32,

    d3d11_device:                   rawptr,
    d3d11_device_context:           rawptr,
    d3d11_render_target_view_cb:    proc "c" () -> rawptr,
    d3d11_depth_stencil_view_cb:    proc "c" () -> rawptr,
    _end_canary:                    u32,
}
