package sokol

import "core:c"

sg_desc :: struct {
	_start_canary: u32,
    buffer_pool_size: int,
    image_pool_size: int,
    shader_pool_size: int,
    pipeline_pool_size: int,
    pass_pool_size: int,
    context_pool_size: int,
    gl_force_gles2: bool,
    
	_end_canary: u32
}

/*
typedef struct sg_desc {
    uint32_t _start_canary;
    int buffer_pool_size;
    int image_pool_size;
    int shader_pool_size;
    int pipeline_pool_size;
    int pass_pool_size;
    int context_pool_size;
    /* GL specific */
    bool gl_force_gles2;
    /* Metal-specific */
    const void* mtl_device;
    const void* (*mtl_renderpass_descriptor_cb)(void);
    const void* (*mtl_drawable_cb)(void);
    int mtl_global_uniform_buffer_size;
    int mtl_sampler_cache_size;
    /* D3D11-specific */
    const void* d3d11_device;
    const void* d3d11_device_context;
    const void* (*d3d11_render_target_view_cb)(void);
    const void* (*d3d11_depth_stencil_view_cb)(void);
    uint32_t _end_canary;
} sg_desc;
*/
