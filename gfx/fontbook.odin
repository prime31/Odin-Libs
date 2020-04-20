package gfx

import "core:os"
import "core:mem"
import "core:fmt"
import "shared:engine/libs/fna"
import "shared:engine/libs/fontstash"

// controls texture type. If true, texture is 4x larger but we can use our standard shader to render
// text. If false, the tex is r8 a special shader is required to render it.
@private
CONVERT_FONT_TEX_TO_RGBA :: true;

@private
MAX_FONTS_PER_FONTBOOK :: 5;


Font_Book :: struct {
	using stash: ^fontstash.Context,
	texture: ^fna.Texture,
	tex_filter: fna.Texture_Filter,
	width: i32,
	height: i32,
	font_data: [5]rawptr
}

Font :: distinct i32;

Align :: fontstash.Align;


new_fontbook :: proc(width, height: i32, tex_filter: fna.Texture_Filter = .Point) -> ^Font_Book {
	fb := new(Font_Book);
	fb.tex_filter = tex_filter;

	params := fontstash.Params {
		width = width,
		height = height,
		flags = cast(u8)fontstash.Flags.Top_Left,
		user_ptr = fb,
		render_create = fons_render_create,
		render_resize = fons_render_resize,
		render_update = fons_render_update,
		render_draw = fons_render_draw
	};

	fb.stash = fontstash.create_internal(&params);

	return fb;
}

free_fontbook :: proc(fontbook: ^Font_Book) {
	for i in 0..<MAX_FONTS_PER_FONTBOOK {
		if fontbook.font_data[i] != nil do free(fontbook.font_data[i]);
	}

	fontstash.delete_internal(fontbook);
    if fontbook.texture != nil do fna.add_dispose_texture(fna_device, fontbook.texture);
	free(fontbook);
}

// callbacks
@(private)
fons_render_create :: proc "c" (uptr: rawptr, width, height: i32) -> i32 {
	fb := cast(^Font_Book)uptr;

    // create or re-create font atlas texture
    if fb.texture != nil {
    	fna.add_dispose_texture(fna_device, fb.texture);
        fb.texture = nil;
    }

    fb.width = width;
    fb.height = height;

    sampler_state := fna.Sampler_State{
		address_u = .Clamp,
		address_v = .Clamp,
		address_w = .Clamp,
    	filter = fb.tex_filter
    };

    fb.texture = new_texture(width, height, sampler_state, CONVERT_FONT_TEX_TO_RGBA ? .Color : .Alpha8);

	return 1;
}

@(private)
fons_render_resize :: proc "c" (uptr: rawptr, width: i32, height: i32) -> i32 do return fons_render_create(uptr, width, height);

@(private)
fons_render_update :: proc "c" (uptr: rawptr, rect: ^i32, data: ^byte) {
	fb := cast(^Font_Book)uptr;

	// TODO: only update the rect that changed
	if CONVERT_FONT_TEX_TO_RGBA {
		tex_area := int(fb.width * fb.height);
		pixels := make([]u8, tex_area * 4, context.temp_allocator);
		source := mem.slice_ptr(data, tex_area);

		for i in 0..<len(source) {
			pixels[i * 4 + 0] = 255;
			pixels[i * 4 + 1] = 255;
			pixels[i * 4 + 2] = 255;
			pixels[i * 4 + 3] = source[i];
		}

		fna.set_texture_data_2d(fna_device, fb.texture, .Color, 0, 0, fb.width, fb.height, 0, &pixels[0], cast(i32)tex_area * 4);
	} else {
		fna.set_texture_data_2d(fna_device, fb.texture, .Alpha8, 0, 0, fb.width, fb.height, 0, fb.stash.tex_data, fb.width * fb.height);
	}
}

@(private)
fons_render_draw :: proc "c" (uptr: rawptr, verts: ^f32, tcoords: ^f32, colors: ^u32, nverts: i32) {
	fmt.println("fons_render_draw", verts, tcoords, colors, nverts);
}

fontbook_add_font :: proc(fontbook: ^Font_Book, file: cstring) -> Font {
	data, success := os.read_entire_file(cast(string)file);
	if !success do panic("could not open font file");

	// tuck away the ptr to the font so we can free it later
	for i in 0..<MAX_FONTS_PER_FONTBOOK {
		if fontbook.font_data[i] == nil {
			fontbook.font_data[i] = cast(rawptr)&data[0];
			break;
		}
	}

	return cast(Font)fontstash.add_font_mem(fontbook.stash, file, &data[0], cast(i32)len(data), 0);
}

fontbook_add_font_mem :: proc(fontbook: ^Font_Book, data: []byte, free_data: bool) -> Font {
	return cast(Font)fontstash.add_font_mem(fontbook.stash, "", &data[0], cast(i32)len(data), free_data ? 1 : 0);
}

fontbook_get_font_by_name :: proc(fontbook: ^Font_Book, name: cstring) -> Font {
	return cast(Font)fontstash.get_font_by_name(fontbook.stash, name);
}

// State handling
fontbook_push_state :: proc(fontbook: ^Font_Book) {
	fontstash.push_state(fontbook.stash);
}

fontbook_pop_state :: proc(fontbook: ^Font_Book) {
	fontstash.pop_state(fontbook.stash);
}

fontbook_clear_state :: proc(fontbook: ^Font_Book) {
	fontstash.clear_state(fontbook.stash);
}

// State setting
fontbook_set_size :: proc(fontbook: ^Font_Book, size: f32) {
	fontstash.set_size(fontbook.stash, size);
}

// DrawConfig handles color for now
fontbook_set_color :: proc(fontbook: ^Font_Book, color: u32) {
	fontstash.set_color(fontbook.stash, color);
}

fontbook_set_spacing :: proc(fontbook: ^Font_Book, spacing: f32) {
	fontstash.set_spacing(fontbook.stash, spacing);
}

fontbook_set_blur :: proc(fontbook: ^Font_Book, blur: f32) {
	fontstash.set_blur(fontbook.stash, blur);
}

fontbook_set_align :: proc(fontbook: ^Font_Book, align: Align) {
	fontstash.set_align(fontbook.stash, cast(i32)align);
}

fontbook_set_font :: proc(fontbook: ^Font_Book, font: Font) {
	fontstash.set_font(fontbook.stash, cast(i32)font);
}

// this method uses the callback system to render. We use the iter system for more control
@(private)
fontbook_draw_text :: proc(fontbook: ^Font_Book, str: cstring) {
	fontstash.draw_text(fontbook, 0, 0, str, nil);
}
