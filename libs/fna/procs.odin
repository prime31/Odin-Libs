package fna

when ODIN_OS == "windows" do foreign import fna_lib "native/FNA3D.lib";
when ODIN_OS == "linux" do foreign import fna_lib "native/libFNA3D.so";
when ODIN_OS == "darwin" do foreign import fna_lib "native/libFNA3D.dylib";

foreign fna_lib {
	// include/FNA3D
	@(link_name = "FNA3D_HookLogFunctions")
	hook_log_functions :: proc(info: proc(cstring), warn: proc(cstring), error: proc(cstring)) ---;

	@(link_name = "FNA3D_PrepareWindowAttributes")
	prepare_window_attributes :: proc() -> u32 ---;

	@(link_name = "FNA3D_GetDrawableSize")
	get_drawable_size :: proc(window: rawptr, x: ^i32, y: ^i32) ---;

	@(link_name = "FNA3D_CreateDevice")
	create_device :: proc(presentation_parameters: ^Presentation_Parameters, debug_mode: u8) -> ^Device ---;

	@(link_name = "FNA3D_DestroyDevice")
	destroy_device :: proc(device: ^Device) ---;

	@(link_name = "FNA3D_BeginFrame")
	begin_frame :: proc(device: ^Device) ---;

	@(link_name = "FNA3D_SwapBuffers")
	swap_buffers :: proc(device: ^Device, source_rectangle: ^Rect, destination_rectangle: ^Rect, override_window_handle: rawptr) ---;

	@(link_name = "FNA3D_SetPresentationInterval")
	set_presentation_interval :: proc(device: ^Device, present_interval: Present_Interval) ---;

	@(link_name = "FNA3D_Clear")
	clear :: proc(device: ^Device, options: Clear_Options, color: ^Vec4, depth: f32, stencil: i32) ---;

	@(link_name = "FNA3D_DrawIndexedPrimitives")
	draw_indexed_primitives :: proc(device: ^Device, primitive_type: Primitive_Type, base_vertex: i32, min_vertex_index: i32, num_vertices: i32, start_index: i32, primitive_count: i32, indices: ^Buffer, index_element_size: Index_Element_Size) ---;

	@(link_name = "FNA3D_DrawInstancedPrimitives")
	draw_instanced_primitives :: proc(device: ^Device, primitive_type: Primitive_Type, base_vertex: i32, min_vertex_index: i32, num_vertices: i32, start_index: i32, primitive_count: i32, instance_count: i32, indices: ^Buffer, index_element_size: Index_Element_Size) ---;

	@(link_name = "FNA3D_DrawPrimitives")
	draw_primitives :: proc(device: ^Device, primitive_type: Primitive_Type, vertex_start: i32, primitive_count: i32) ---;

	@(link_name = "FNA3D_DrawUserIndexedPrimitives")
	draw_user_indexed_primitives :: proc(device: ^Device, primitive_type: Primitive_Type, vertex_data: rawptr, vertex_offset: i32, num_vertices: i32, index_data: rawptr, index_offset: i32, index_element_size: Index_Element_Size, primitive_count: i32) ---;

	@(link_name = "FNA3D_DrawUserPrimitives")
	draw_user_primitives :: proc(device: ^Device, primitive_type: Primitive_Type, vertex_data: rawptr, vertex_offset: i32, primitive_count: i32) ---;

	@(link_name = "FNA3D_SetViewport")
	set_viewport :: proc(device: ^Device, viewport: ^Viewport) ---;

	@(link_name = "FNA3D_SetScissorRect")
	set_scissor_rect :: proc(device: ^Device, scissor: ^Rect) ---;

	@(link_name = "FNA3D_GetBlendFactor")
	get_blend_factor :: proc(device: ^Device, blend_factor: ^Color) ---;

	@(link_name = "FNA3D_SetBlendFactor")
	set_blend_factor :: proc(device: ^Device, blend_factor: ^Color) ---;

	@(link_name = "FNA3D_GetMultiSampleMask")
	get_multi_sample_mask :: proc(device: ^Device) -> i32 ---;

	@(link_name = "FNA3D_SetMultiSampleMask")
	set_multi_sample_mask :: proc(device: ^Device, mask: i32) ---;

	@(link_name = "FNA3D_GetReferenceStencil")
	get_reference_stencil :: proc(device: ^Device) -> i32 ---;

	@(link_name = "FNA3D_SetReferenceStencil")
	set_reference_stencil :: proc(device: ^Device, ref: i32) ---;

	@(link_name = "FNA3D_SetBlendState")
	set_blend_state :: proc(device: ^Device, blend_state: ^Blend_State) ---;

	@(link_name = "FNA3D_SetDepthStencilState")
	set_depth_stencil_state :: proc(device: ^Device, depth_stencil_state: ^Depth_Stencil_State) ---;

	@(link_name = "FNA3D_ApplyRasterizerState")
	apply_rasterizer_state :: proc(device: ^Device, rasterizer_state: ^Rasterizer_State) ---;

	@(link_name = "FNA3D_VerifySampler")
	verify_sampler :: proc(device: ^Device, index: i32, texture: ^Texture, sampler: ^Sampler_State) ---;

	@(link_name = "FNA3D_ApplyVertexBufferBindings")
	apply_vertex_buffer_bindings :: proc(device: ^Device, bindings: ^Vertex_Buffer_Binding, num_bindings: i32, bindings_updated: u8, base_vertex: i32) ---;

	@(link_name = "FNA3D_ApplyVertexDeclaration")
	apply_vertex_declaration :: proc(device: ^Device, vertex_declaration: ^Vertex_Declaration, ptr: rawptr, vertex_offset: i32) ---;

	@(link_name = "FNA3D_SetRenderTargets")
	set_render_targets :: proc(device: ^Device, render_targets: ^Render_Target_Binding, num_render_targets: i32, renderbuffer: ^Renderbuffer, depth_format: Depth_Format) ---;

	@(link_name = "FNA3D_ResolveTarget")
	resolve_target :: proc(device: ^Device, target: ^Render_Target_Binding) ---;

	@(link_name = "FNA3D_ResetBackbuffer")
	reset_backbuffer :: proc(device: ^Device, presentation_parameters: ^Presentation_Parameters) ---;

	@(link_name = "FNA3D_ReadBackbuffer")
	read_backbuffer :: proc(device: ^Device, data: rawptr, data_len: i32, start_index: i32, element_count: i32, element_size_in_bytes: i32, x: i32, y: i32, w: i32, h: i32) ---;

	@(link_name = "FNA3D_GetBackbufferSize")
	get_backbuffer_size :: proc(device: ^Device, w: ^i32, h: ^i32) ---;

	@(link_name = "FNA3D_GetBackbufferSurfaceFormat")
	get_backbuffer_surface_format :: proc(device: ^Device) -> Surface_Format ---;

	@(link_name = "FNA3D_GetBackbufferDepthFormat")
	get_backbuffer_depth_format :: proc(device: ^Device) -> Depth_Format ---;

	@(link_name = "FNA3D_GetBackbufferMultiSampleCount")
	get_backbuffer_multi_sample_count :: proc(device: ^Device) -> i32 ---;

	@(link_name = "FNA3D_CreateTexture2D")
	create_texture_2d :: proc(device: ^Device, format: Surface_Format, width: i32, height: i32, level_count: i32, is_render_target: u8) -> ^Texture ---;

	@(link_name = "FNA3D_CreateTexture3D")
	create_texture_3d :: proc(device: ^Device, format: Surface_Format, width: i32, height: i32, depth: i32, level_count: i32) -> ^Texture ---;

	@(link_name = "FNA3D_CreateTextureCube")
	create_texture_cube :: proc(device: ^Device, format: Surface_Format, size: i32, level_count: i32, is_render_target: u8) -> ^Texture ---;

	@(link_name = "FNA3D_AddDisposeTexture")
	add_dispose_texture :: proc(device: ^Device, texture: ^Texture) ---;

	@(link_name = "FNA3D_SetTextureData2D")
	set_texture_data_2d :: proc(device: ^Device, texture: ^Texture, format: Surface_Format, x: i32, y: i32, w: i32, h: i32, level: i32, data: rawptr, data_length: i32) ---;

	@(link_name = "FNA3D_SetTextureData3D")
	set_texture_data_3d :: proc(device: ^Device, texture: ^Texture, format: Surface_Format, level: i32, left: i32, top: i32, right: i32, bottom: i32, front: i32, back: i32, data: rawptr, data_length: i32) ---;

	@(link_name = "FNA3D_SetTextureDataCube")
	set_texture_data_cube :: proc(device: ^Device, texture: ^Texture, format: Surface_Format, x: i32, y: i32, w: i32, h: i32, cube_map_face: Cube_Map_Face, level: i32, data: rawptr, data_length: i32) ---;

	@(link_name = "FNA3D_SetTextureDataYUV")
	set_texture_data_yuv :: proc(device: ^Device, y: ^Texture, u: ^Texture, v: ^Texture, w: i32, h: i32, ptr: rawptr) ---;

	@(link_name = "FNA3D_GetTextureData2D")
	get_texture_data_2d :: proc(device: ^Device, texture: ^Texture, format: Surface_Format, texture_width: i32, texture_height: i32, level: i32, x: i32, y: i32, w: i32, h: i32, data: rawptr, start_index: i32, element_count: i32, element_size_in_bytes: i32) ---;

	@(link_name = "FNA3D_GetTextureData3D")
	get_texture_data_3d :: proc(device: ^Device, texture: ^Texture, format: Surface_Format, left: i32, top: i32, front: i32, right: i32, bottom: i32, back: i32, level: i32, data: rawptr, start_index: i32, element_count: i32, element_size_in_bytes: i32) ---;

	@(link_name = "FNA3D_GetTextureDataCube")
	get_texture_data_cube :: proc(device: ^Device, texture: ^Texture, format: Surface_Format, texture_size: i32, cube_map_face: Cube_Map_Face, level: i32, x: i32, y: i32, w: i32, h: i32, data: rawptr, start_index: i32, element_count: i32, element_size_in_bytes: i32) ---;

	@(link_name = "FNA3D_GenColorRenderbuffer")
	gen_color_renderbuffer :: proc(device: ^Device, width: i32, height: i32, format: Surface_Format, multi_sample_count: i32, texture: ^Texture) -> ^Renderbuffer ---;

	@(link_name = "FNA3D_GenDepthStencilRenderbuffer")
	gen_depth_stencil_renderbuffer :: proc(device: ^Device, width: i32, height: i32, format: Depth_Format, multi_sample_count: i32) -> ^Renderbuffer ---;

	@(link_name = "FNA3D_AddDisposeRenderbuffer")
	add_dispose_renderbuffer :: proc(device: ^Device, renderbuffer: ^Renderbuffer) ---;

	@(link_name = "FNA3D_GenVertexBuffer")
	gen_vertex_buffer :: proc(device: ^Device, is_dynamic: u8, usage: Buffer_Usage, vertex_count: i32, vertex_stride: i32) -> ^Buffer ---;

	@(link_name = "FNA3D_AddDisposeVertexBuffer")
	add_dispose_vertex_buffer :: proc(device: ^Device, buffer: ^Buffer) ---;

	@(link_name = "FNA3D_SetVertexBufferData")
	set_vertex_buffer_data :: proc(device: ^Device, buffer: ^Buffer, offset_in_bytes: i32, data: rawptr, data_length: i32, options: Set_Data_Options) ---;

	@(link_name = "FNA3D_GetVertexBufferData")
	get_vertex_buffer_data :: proc(device: ^Device, buffer: ^Buffer, offset_in_bytes: i32, data: rawptr, start_index: i32, element_count: i32, element_size_in_bytes: i32, vertex_stride: i32) ---;

	@(link_name = "FNA3D_GenIndexBuffer")
	gen_index_buffer :: proc(device: ^Device, is_dynamic: u8, usage: Buffer_Usage, index_count: i32, index_element_size: Index_Element_Size) -> ^Buffer ---;

	@(link_name = "FNA3D_AddDisposeIndexBuffer")
	add_dispose_index_buffer :: proc(device: ^Device, buffer: ^Buffer) ---;

	@(link_name = "FNA3D_SetIndexBufferData")
	set_index_buffer_data :: proc(device: ^Device, buffer: ^Buffer, offset_in_bytes: i32, data: rawptr, data_length: i32, options: Set_Data_Options) ---;

	@(link_name = "FNA3D_GetIndexBufferData")
	get_index_buffer_data :: proc(device: ^Device, buffer: ^Buffer, offset_in_bytes: i32, data: rawptr, start_index: i32, element_count: i32, element_size_in_bytes: i32) ---;

	@(link_name = "FNA3D_CreateEffect")
	create_effect :: proc(device: ^Device, effect_code: ^u8, effect_code_length: u32) -> ^Effect ---;

	@(link_name = "FNA3D_CloneEffect")
	clone_effect :: proc(device: ^Device, effect: ^Effect) -> ^Effect ---;

	@(link_name = "FNA3D_AddDisposeEffect")
	add_dispose_effect :: proc(device: ^Device, effect: ^Effect) ---;

	@(link_name = "FNA3D_ApplyEffect")
	apply_effect :: proc(device: ^Device, effect: ^Effect, technique: ^Mojoshader_Effect_Technique, pass: u32, state_changes: ^Mojoshader_Effect_State_Changes) ---;

	@(link_name = "FNA3D_BeginPassRestore")
	begin_pass_restore :: proc(device: ^Device, effect: ^Effect, state_changes: ^Mojoshader_Effect_State_Changes) ---;

	@(link_name = "FNA3D_EndPassRestore")
	end_pass_restore :: proc(device: ^Device, effect: ^Effect) ---;

	@(link_name = "FNA3D_CreateQuery")
	create_query :: proc(device: ^Device) -> ^Query ---;

	@(link_name = "FNA3D_AddDisposeQuery")
	add_dispose_query :: proc(device: ^Device, query: ^Query) ---;

	@(link_name = "FNA3D_QueryBegin")
	query_begin :: proc(device: ^Device, query: ^Query) ---;

	@(link_name = "FNA3D_QueryEnd")
	query_end :: proc(device: ^Device, query: ^Query) ---;

	@(link_name = "FNA3D_QueryComplete")
	query_complete :: proc(device: ^Device, query: ^Query) -> u8 ---;

	@(link_name = "FNA3D_QueryPixelCount")
	query_pixel_count :: proc(device: ^Device, query: ^Query) -> i32 ---;

	@(link_name = "FNA3D_SupportsDXT1")
	supports_dxt1 :: proc(device: ^Device) -> u8 ---;

	@(link_name = "FNA3D_SupportsS3TC")
	supports_s3tc :: proc(device: ^Device) -> u8 ---;

	@(link_name = "FNA3D_SupportsHardwareInstancing")
	supports_hardware_instancing :: proc(device: ^Device) -> u8 ---;

	@(link_name = "FNA3D_SupportsNoOverwrite")
	supports_no_overwrite :: proc(device: ^Device) -> u8 ---;

	@(link_name = "FNA3D_GetMaxTextureSlots")
	get_max_texture_slots :: proc(device: ^Device) -> i32 ---;

	@(link_name = "FNA3D_GetMaxMultiSampleCount")
	get_max_multi_sample_count :: proc(device: ^Device) -> i32 ---;

	@(link_name = "FNA3D_SetStringMarker")
	set_string_marker :: proc(device: ^Device, text: cstring) ---;

	@(link_name = "FNA3D_GetBufferSize")
	get_buffer_size :: proc(device: ^Device, buffer: ^Buffer) -> i32 ---;

	@(link_name = "FNA3D_GetEffectData")
	get_effect_data :: proc(device: ^Device, effect: ^Effect) -> ^Mojoshader_Effect ---;

	// include/FNA3D_Image
	@(link_name = "FNA3D_Image_Load")
	load :: proc(read_func: proc "c" (rawptr, ^byte, i32) -> i32, skip_func: proc "c" (rawptr, i32), eof_func: proc "c" (rawptr) -> i32, ctx: rawptr, w: ^i32, h: ^i32, len: ^i32, force_w: i32, force_h: i32, zoom: u8) -> ^u8 ---;

	@(link_name = "FNA3D_Image_Free")
	free :: proc(mem: ^u8) ---;

	@(link_name = "FNA3D_Image_SavePNG")
	save_png :: proc(write_func: proc(rawptr, rawptr, i32), ctx: rawptr, src_w: i32, src_h: i32, dst_w: i32, dst_h: i32, data: ^u8) ---;

	@(link_name = "FNA3D_Image_SaveJPG")
	save_jpg :: proc(write_func: proc(rawptr, rawptr, i32), ctx: rawptr, src_w: i32, src_h: i32, dst_w: i32, dst_h: i32, data: ^u8, quality: i32) ---;
}
