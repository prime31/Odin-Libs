package gfx

import "core:intrinsics"
import "core:os"
import "core:fmt"
import "shared:engine/libs/fna"

Texture :: struct {
	using fna_texture: ^fna.Texture,
	width, height: i32
}

Render_Texture :: struct {
	using tex: Texture,
	render_target_usage: fna.Render_Target_Usage,
	depth_stencil_buffer: ^fna.Renderbuffer,
	depth_stencil_format: fna.Depth_Format
}


@(private)
tex_sampler_state_cache: map[^fna.Texture]fna.Sampler_State = make(map[^fna.Texture]fna.Sampler_State);
@(private)
bound_textures: [4]^fna.Texture;


new_checkerboard_texture :: proc() -> Texture {
	pixels := [?]u32 {0xFFFFFFFF, 0xFF000000, 0xFFFFFFFF, 0xFF000000,
		0xFF000000, 0xFFFFFFFF, 0xFF000000, 0xFFFFFFFF,
		0xFFFFFFFF, 0xFF000000, 0xFFFFFFFF, 0xFF000000,
		0xFF000000, 0xFFFFFFFF, 0xFF000000, 0xFFFFFFFF};

	texture := fna.create_texture_2d(fna_device, .Color, 4, 4, 1, 0);
	fna.set_texture_data_2d(fna_device, texture, .Color, 0, 0, 4, 4, 0, &pixels, size_of(pixels));

	tex_sampler_state_cache[texture] = default_sampler_state;

	return Texture{
		fna_texture = texture,
		width = 4,
		height = 4
	};
}

new_texture_from_data :: proc(data: ^$T, w, h: i32, sampler_state: fna.Sampler_State, format: fna.Surface_Format = .Color) -> Texture {
	texture := Texture{
		fna_texture = fna.create_texture_2d(fna_device, format, w, h, 1, 0),
		width = w,
		height = h
	};
	fna.set_texture_data_2d(fna_device, texture, format, 0, 0, w, h, 0, data, w * h * size_of(data));

	return texture;
}

free_texture :: proc(texture: Texture) {
	fna.add_dispose_texture(fna_device, texture);
	delete_key(&tex_sampler_state_cache, texture.fna_texture);
}

load_texture :: proc(file: string, sampler_state: fna.Sampler_State) -> Texture {
	file, err := os.open(file);
	if err != 0 do fmt.panicf("Could not open image file");
	defer { os.close(file); }

	width, height, len: i32;
	data := fna.image_load(image_read_fn, image_skip_fn, image_eof_fn, &file, &width, &height, &len, -1, -1, 0);
	defer { fna.image_free(data); }

	texture := fna.create_texture_2d(fna_device, .Color, width, height, 1, 0);
	fna.set_texture_data_2d(fna_device, texture, .Color, 0, 0, width, height, 0, data, width * height * size_of(data));

	tex_sampler_state_cache[texture] = sampler_state;

	return Texture{
		fna_texture = texture,
		width = width,
		height = height
	};
}

texture_set_data :: proc(texture: Texture, x, y, w, h: i32, data: ^$T, format: fna.Surface_Format = .Color)
	where intrinsics.type_is_indexable(T) {
	element_size := cast(i32)size_of(intrinsics.type_elem_type(T));
	data_length := cast(i32)len(data) * element_size;
	fna.set_texture_data_2d(fna_device, texture, format, x, y, w, h, 0, &data[0], data_length);
}

texture_bind :: proc(texture: ^fna.Texture, index: i32 = 0) {
	// avoid binding already bound textures
	if bound_textures[index] == texture do return;

	sampler_state := tex_sampler_state_cache[texture];
	fna.verify_sampler(fna_device, index, texture, &sampler_state);

	bound_textures[index] = texture;
}


// Render_Texture
new_render_texture :: proc(w, h: i32, sampler_state: fna.Sampler_State, format: fna.Surface_Format = .Color, depth_stencil_format: fna.Depth_Format = .None) -> Render_Texture {
	render_texture := Render_Texture {
		tex = Texture{
			fna_texture = fna.create_texture_2d(fna_device, format, w, h, 1, 1),
			width = w,
			height = h
		},
		render_target_usage = .Platform_Contents
	};

	render_texture.depth_stencil_format = depth_stencil_format;
	if depth_stencil_format != .None {
		render_texture.depth_stencil_buffer = fna.gen_depth_stencil_renderbuffer(fna_device, w, h, depth_stencil_format, 0);
	}

	return render_texture;
}

free_render_texture :: proc(render_texture: Render_Texture) {
	if render_texture.depth_stencil_buffer != nil do fna.add_dispose_renderbuffer(fna_device, render_texture.depth_stencil_buffer);
	free_texture(render_texture);
}




// FNA_Image callbacks
// fill 'data' with 'size' bytes. return number of bytes actually read
@(private)
image_read_fn :: proc "c" (ctx: rawptr, data: ^byte, size: i32) -> i32 {
	int_ptr := cast(^int)ctx;
	file := cast(os.Handle)int_ptr^;

	bytes_read, read_err := os.read_ptr(file, data, cast(int)size);
	if read_err != os.ERROR_NONE do fmt.panicf("died reading file");

	return cast(i32)bytes_read;
}

// skip the next 'n' bytes, or 'unget' the last -n bytes if negative
@(private)
image_skip_fn :: proc "c" (ctx: rawptr, len: i32) {
	fmt.println("--- --------- image_skip_fn");
	int_ptr := cast(^int)ctx;
	file := cast(os.Handle)int_ptr^;

	if offset, err := os.seek(file, cast(i64)len, os.SEEK_CUR); err != 0 do fmt.panicf("error");
}

// returns nonzero if we are at end of file/data
@(private)
image_eof_fn :: proc "c" (ctx: rawptr) -> i32 {
	fmt.println("--- --------- image_eof_fn");

	int_ptr := cast(^int)ctx;
	file := cast(os.Handle)int_ptr^;
	fmt.println("--- image_eof_fn", file);

	if offset, err := os.seek(file, 0, os.SEEK_CUR); err != 0 do fmt.panicf("error");

	return 0;
}
