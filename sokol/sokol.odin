package sokol

import "core:os"
import "core:c"

when os.OS == "windows" do foreign import lib "sokol.dll";
when os.OS == "linux" do foreign import lib "sokol";
when os.OS == "darwin" do foreign import lib "thirdparty/libsokol.dylib";


@(default_calling_convention="c")
@(link_prefix="sg_")
foreign lib {
	/* setup and misc functions */
	setup :: proc(desc: ^sg_desc) ---;
	shutdown :: proc() ---;
	isvalid :: proc() -> bool ---;
	reset_state_cache :: proc() ---;
	// sg_install_trace_hooks
	push_debug_group :: proc(name: cstring) ---;
	pop_debug_group :: proc() ---;

	/* resource creation, destruction and updating */

}



/*
/* resource creation, destruction and updating */
SOKOL_API_DECL sg_buffer sg_make_buffer(const sg_buffer_desc* desc);
SOKOL_API_DECL sg_image sg_make_image(const sg_image_desc* desc);
SOKOL_API_DECL sg_shader sg_make_shader(const sg_shader_desc* desc);
SOKOL_API_DECL sg_pipeline sg_make_pipeline(const sg_pipeline_desc* desc);
SOKOL_API_DECL sg_pass sg_make_pass(const sg_pass_desc* desc);
SOKOL_API_DECL void sg_destroy_buffer(sg_buffer buf);
SOKOL_API_DECL void sg_destroy_image(sg_image img);
SOKOL_API_DECL void sg_destroy_shader(sg_shader shd);
SOKOL_API_DECL void sg_destroy_pipeline(sg_pipeline pip);
SOKOL_API_DECL void sg_destroy_pass(sg_pass pass);
SOKOL_API_DECL void sg_update_buffer(sg_buffer buf, const void* data_ptr, int data_size);
SOKOL_API_DECL void sg_update_image(sg_image img, const sg_image_content* data);
SOKOL_API_DECL int sg_append_buffer(sg_buffer buf, const void* data_ptr, int data_size);
SOKOL_API_DECL bool sg_query_buffer_overflow(sg_buffer buf);

/* rendering functions */
SOKOL_API_DECL void sg_begin_default_pass(const sg_pass_action* pass_action, int width, int height);
SOKOL_API_DECL void sg_begin_pass(sg_pass pass, const sg_pass_action* pass_action);
SOKOL_API_DECL void sg_apply_viewport(int x, int y, int width, int height, bool origin_top_left);
SOKOL_API_DECL void sg_apply_scissor_rect(int x, int y, int width, int height, bool origin_top_left);
SOKOL_API_DECL void sg_apply_pipeline(sg_pipeline pip);
SOKOL_API_DECL void sg_apply_bindings(const sg_bindings* bindings);
SOKOL_API_DECL void sg_apply_uniforms(sg_shader_stage stage, int ub_index, const void* data, int num_bytes);
SOKOL_API_DECL void sg_draw(int base_element, int num_elements, int num_instances);
SOKOL_API_DECL void sg_end_pass(void);
SOKOL_API_DECL void sg_commit(void);

/* getting information */
SOKOL_API_DECL sg_desc sg_query_desc(void);
SOKOL_API_DECL sg_backend sg_query_backend(void);
SOKOL_API_DECL sg_features sg_query_features(void);
SOKOL_API_DECL sg_limits sg_query_limits(void);
SOKOL_API_DECL sg_pixelformat_info sg_query_pixelformat(sg_pixel_format fmt);
/* get current state of a resource (INITIAL, ALLOC, VALID, FAILED, INVALID) */
SOKOL_API_DECL sg_resource_state sg_query_buffer_state(sg_buffer buf);
SOKOL_API_DECL sg_resource_state sg_query_image_state(sg_image img);
SOKOL_API_DECL sg_resource_state sg_query_shader_state(sg_shader shd);
SOKOL_API_DECL sg_resource_state sg_query_pipeline_state(sg_pipeline pip);
SOKOL_API_DECL sg_resource_state sg_query_pass_state(sg_pass pass);
/* get runtime information about a resource */
SOKOL_API_DECL sg_buffer_info sg_query_buffer_info(sg_buffer buf);
SOKOL_API_DECL sg_image_info sg_query_image_info(sg_image img);
SOKOL_API_DECL sg_shader_info sg_query_shader_info(sg_shader shd);
SOKOL_API_DECL sg_pipeline_info sg_query_pipeline_info(sg_pipeline pip);
SOKOL_API_DECL sg_pass_info sg_query_pass_info(sg_pass pass);
/* get resource creation desc struct with their default values replaced */
SOKOL_API_DECL sg_buffer_desc sg_query_buffer_defaults(const sg_buffer_desc* desc);
SOKOL_API_DECL sg_image_desc sg_query_image_defaults(const sg_image_desc* desc);
SOKOL_API_DECL sg_shader_desc sg_query_shader_defaults(const sg_shader_desc* desc);
SOKOL_API_DECL sg_pipeline_desc sg_query_pipeline_defaults(const sg_pipeline_desc* desc);
SOKOL_API_DECL sg_pass_desc sg_query_pass_defaults(const sg_pass_desc* desc);

/* separate resource allocation and initialization (for async setup) */
SOKOL_API_DECL sg_buffer sg_alloc_buffer(void);
SOKOL_API_DECL sg_image sg_alloc_image(void);
SOKOL_API_DECL sg_shader sg_alloc_shader(void);
SOKOL_API_DECL sg_pipeline sg_alloc_pipeline(void);
SOKOL_API_DECL sg_pass sg_alloc_pass(void);
SOKOL_API_DECL void sg_init_buffer(sg_buffer buf_id, const sg_buffer_desc* desc);
SOKOL_API_DECL void sg_init_image(sg_image img_id, const sg_image_desc* desc);
SOKOL_API_DECL void sg_init_shader(sg_shader shd_id, const sg_shader_desc* desc);
SOKOL_API_DECL void sg_init_pipeline(sg_pipeline pip_id, const sg_pipeline_desc* desc);
SOKOL_API_DECL void sg_init_pass(sg_pass pass_id, const sg_pass_desc* desc);
SOKOL_API_DECL void sg_fail_buffer(sg_buffer buf_id);
SOKOL_API_DECL void sg_fail_image(sg_image img_id);
SOKOL_API_DECL void sg_fail_shader(sg_shader shd_id);
SOKOL_API_DECL void sg_fail_pipeline(sg_pipeline pip_id);
SOKOL_API_DECL void sg_fail_pass(sg_pass pass_id);

/* rendering contexts (optional) */
SOKOL_API_DECL sg_context sg_setup_context(void);
SOKOL_API_DECL void sg_activate_context(sg_context ctx_id);
SOKOL_API_DECL void sg_discard_context(sg_context ctx_id);
*/
