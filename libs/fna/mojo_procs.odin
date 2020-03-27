package fna

when ODIN_OS == "windows" do foreign import fna_lib "native/FNA3D.lib";
when ODIN_OS == "linux" do foreign import fna_lib "native/libFNA3D.so";
when ODIN_OS == "darwin" do foreign import fna_lib "native/libFNA3D.dylib";

foreign fna_lib {
	// MojoShader/mojoshader
	@(link_name = "MOJOSHADER_version")
	version :: proc() -> i32 ---;

	@(link_name = "MOJOSHADER_changeset")
	changeset :: proc() -> cstring ---;

	@(link_name = "MOJOSHADER_maxShaderModel")
	max_shader_model :: proc(profile: cstring) -> i32 ---;

	@(link_name = "MOJOSHADER_parse")
	parse :: proc(profile: cstring, mainfn: cstring, tokenbuf: ^byte, bufsize: u32, swiz: ^Swizzle, swizcount: u32, smap: ^Sampler_Map, smapcount: u32, m: proc(i32, rawptr) -> rawptr, f: proc(rawptr, rawptr), d: rawptr) -> ^Parse_Data ---;

	@(link_name = "MOJOSHADER_freeParseData")
	free_parse_data :: proc(data: ^Parse_Data) ---;

	@(link_name = "MOJOSHADER_parsePreshader")
	parse_preshader :: proc(buf: ^byte, len: u32, m: proc(i32, rawptr) -> rawptr, f: proc(rawptr, rawptr), d: rawptr) -> ^Preshader ---;

	@(link_name = "MOJOSHADER_freePreshader")
	free_preshader :: proc(preshader: ^Preshader) ---;

	@(link_name = "MOJOSHADER_preprocess")
	preprocess :: proc(filename: cstring, source: cstring, sourcelen: u32, defines: ^Preprocessor_Define, define_count: u32, include_open: rawptr /* proc(Include_Type, cstring, cstring, &rawptr /* const char** */, ^u32, proc(i32, rawptr) -> rawptr, proc(rawptr, rawptr), rawptr) -> i32 */, include_close: rawptr /* proc(cstring, proc(i32, rawptr) -> rawptr, proc(rawptr, rawptr), rawptr) */, m: proc(i32, rawptr) -> rawptr, f: proc(rawptr, rawptr), d: rawptr) -> ^Preprocess_Data ---;

	@(link_name = "MOJOSHADER_freePreprocessData")
	free_preprocess_data :: proc(data: ^Preprocess_Data) ---;

	@(link_name = "MOJOSHADER_assemble")
	assemble :: proc(filename: cstring, source: cstring, sourcelen: u32, comments: ^rawptr /* const char** */, comment_count: u32, symbols: ^Symbol, symbol_count: u32, defines: ^Preprocessor_Define, define_count: u32, include_open: rawptr /* proc(Include_Type, cstring, cstring, &rawptr /* const char** */, ^u32, proc(i32, rawptr) -> rawptr, proc(rawptr, rawptr), rawptr) -> i32 */, include_close: rawptr /* proc(cstring, proc(i32, rawptr) -> rawptr, proc(rawptr, rawptr), rawptr) */, m: proc(i32, rawptr) -> rawptr, f: proc(rawptr, rawptr), d: rawptr) -> ^Parse_Data ---;


	@(link_name = "MOJOSHADER_compile")
	compile :: proc(srcprofile: cstring, filename: cstring, source: cstring, sourcelen: u32, defs: ^Preprocessor_Define, define_count: u32, include_open: rawptr /* proc(Include_Type, cstring, cstring, &rawptr /* const char** */, ^u32, proc(i32, rawptr) -> rawptr, proc(rawptr, rawptr), rawptr) -> i32 */, include_close: rawptr /* proc(cstring, proc(i32, rawptr) -> rawptr, proc(rawptr, rawptr), rawptr) */, m: proc(i32, rawptr) -> rawptr, f: proc(rawptr, rawptr), d: rawptr) -> ^Compile_Data ---;

	@(link_name = "MOJOSHADER_freeCompileData")
	free_compile_data :: proc(data: ^Compile_Data) ---;

	@(link_name = "MOJOSHADER_glAvailableProfiles")
	gl_available_profiles :: proc(lookup: proc(cstring, rawptr) -> rawptr, lookup_d: rawptr, profs: ^rawptr /* const char** */, size: i32, m: proc(i32, rawptr) -> rawptr, f: proc(rawptr, rawptr), malloc_d: rawptr) -> i32 ---;

	@(link_name = "MOJOSHADER_glBestProfile")
	gl_best_profile :: proc(lookup: proc(cstring, rawptr) -> rawptr, lookup_d: rawptr, m: proc(i32, rawptr) -> rawptr, f: proc(rawptr, rawptr), malloc_d: rawptr) -> cstring ---;

	@(link_name = "MOJOSHADER_glCreateContext")
	gl_create_context :: proc(profile: cstring, lookup: proc(cstring, rawptr) -> rawptr, lookup_d: rawptr, m: proc(i32, rawptr) -> rawptr, f: proc(rawptr, rawptr), malloc_d: rawptr) -> ^Gl_Context ---;

	@(link_name = "MOJOSHADER_glMakeContextCurrent")
	gl_make_context_current :: proc(ctx: ^Gl_Context) ---;

	@(link_name = "MOJOSHADER_glGetError")
	gl_get_error :: proc() -> cstring ---;

	@(link_name = "MOJOSHADER_glMaxUniforms")
	gl_max_uniforms :: proc(shader_type: Shader_Type) -> i32 ---;

	@(link_name = "MOJOSHADER_glCompileShader")
	gl_compile_shader :: proc(tokenbuf: ^byte, bufsize: u32, swiz: ^Swizzle, swizcount: u32, smap: ^Sampler_Map, smapcount: u32) -> ^Gl_Shader ---;

	@(link_name = "MOJOSHADER_glGetShaderParseData")
	gl_get_shader_parse_data :: proc(shader: ^Gl_Shader) -> ^Parse_Data ---;

	@(link_name = "MOJOSHADER_glLinkProgram")
	gl_link_program :: proc(vshader: ^Gl_Shader, pshader: ^Gl_Shader) -> ^Gl_Program ---;

	@(link_name = "MOJOSHADER_glBindProgram")
	gl_bind_program :: proc(program: ^Gl_Program) ---;

	@(link_name = "MOJOSHADER_glBindShaders")
	gl_bind_shaders :: proc(vshader: ^Gl_Shader, pshader: ^Gl_Shader) ---;

	@(link_name = "MOJOSHADER_glSetVertexShaderUniformF")
	gl_set_vertex_shader_uniform_f :: proc(idx: u32, data: ^f32, vec4count: u32) ---;

	@(link_name = "MOJOSHADER_glGetVertexShaderUniformF")
	gl_get_vertex_shader_uniform_f :: proc(idx: u32, data: ^f32, vec4count: u32) ---;

	@(link_name = "MOJOSHADER_glSetVertexShaderUniformI")
	gl_set_vertex_shader_uniform_i :: proc(idx: u32, data: ^i32, ivec4count: u32) ---;

	@(link_name = "MOJOSHADER_glGetVertexShaderUniformI")
	gl_get_vertex_shader_uniform_i :: proc(idx: u32, data: ^i32, ivec4count: u32) ---;

	@(link_name = "MOJOSHADER_glSetVertexShaderUniformB")
	gl_set_vertex_shader_uniform_b :: proc(idx: u32, data: ^i32, bcount: u32) ---;

	@(link_name = "MOJOSHADER_glGetVertexShaderUniformB")
	gl_get_vertex_shader_uniform_b :: proc(idx: u32, data: ^i32, bcount: u32) ---;

	@(link_name = "MOJOSHADER_glSetPixelShaderUniformF")
	gl_set_pixel_shader_uniform_f :: proc(idx: u32, data: ^f32, vec4count: u32) ---;

	@(link_name = "MOJOSHADER_glGetPixelShaderUniformF")
	gl_get_pixel_shader_uniform_f :: proc(idx: u32, data: ^f32, vec4count: u32) ---;

	@(link_name = "MOJOSHADER_glSetPixelShaderUniformI")
	gl_set_pixel_shader_uniform_i :: proc(idx: u32, data: ^i32, ivec4count: u32) ---;

	@(link_name = "MOJOSHADER_glGetPixelShaderUniformI")
	gl_get_pixel_shader_uniform_i :: proc(idx: u32, data: ^i32, ivec4count: u32) ---;

	@(link_name = "MOJOSHADER_glSetPixelShaderUniformB")
	gl_set_pixel_shader_uniform_b :: proc(idx: u32, data: ^i32, bcount: u32) ---;

	@(link_name = "MOJOSHADER_glGetPixelShaderUniformB")
	gl_get_pixel_shader_uniform_b :: proc(idx: u32, data: ^i32, bcount: u32) ---;

	@(link_name = "MOJOSHADER_glSetLegacyBumpMapEnv")
	gl_set_legacy_bump_map_env :: proc(sampler: u32, mat00: f32, mat01: f32, mat10: f32, mat11: f32, lscale: f32, loffset: f32) ---;

	@(link_name = "MOJOSHADER_glGetVertexAttribLocation")
	gl_get_vertex_attrib_location :: proc(usage: Usage, index: i32) -> i32 ---;

	@(link_name = "MOJOSHADER_glSetVertexAttribute")
	gl_set_vertex_attribute :: proc(usage: Usage, index: i32, size: u32, type: Attribute_Type, normalized: i32, stride: u32, ptr: rawptr) ---;

	@(link_name = "MOJOSHADER_glSetVertexAttribDivisor")
	gl_set_vertex_attrib_divisor :: proc(usage: Usage, index: i32, divisor: u32) ---;

	@(link_name = "MOJOSHADER_glProgramReady")
	gl_program_ready :: proc() ---;

	@(link_name = "MOJOSHADER_glProgramViewportInfo")
	gl_program_viewport_info :: proc(viewport_w: i32, viewport_h: i32, backbuffer_w: i32, backbuffer_h: i32, render_target_bound: i32) ---;

	@(link_name = "MOJOSHADER_glDeleteProgram")
	gl_delete_program :: proc(program: ^Gl_Program) ---;

	@(link_name = "MOJOSHADER_glDeleteShader")
	gl_delete_shader :: proc(shader: ^Gl_Shader) ---;

	@(link_name = "MOJOSHADER_glDestroyContext")
	gl_destroy_context :: proc(ctx: ^Gl_Context) ---;

	@(link_name = "MOJOSHADER_mtlGetFunctionHandle")
	mtl_get_function_handle :: proc(shader: ^Mtl_Shader) -> rawptr ---;

	@(link_name = "MOJOSHADER_mtlEndFrame")
	mtl_end_frame :: proc() ---;

	@(link_name = "MOJOSHADER_mtlGetVertexAttribLocation")
	mtl_get_vertex_attrib_location :: proc(vert: ^Mtl_Shader, usage: Usage, index: i32) -> i32 ---;

	@(link_name = "MOJOSHADER_mtlGetError")
	mtl_get_error :: proc() -> cstring ---;

}
