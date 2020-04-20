package gfx

import "shared:engine/libs/fna"
import "core:fmt"
import "core:math"
import "shared:engine/maf"
import "shared:engine/libs/fontstash"

@(private)
quad: maf.Quad;


begin_pass :: proc() {}

end_pass :: proc() {
	batcher_flush(batcher);
	// do debug render if enabled
}

commit :: proc() {
	// if we havent yet blitted to the screen do so now
	batcher_end_frame(batcher);
}

draw_tex :: proc(texture: Texture, x, y: f32) {
	maf.quad_set_image_dimensions(&quad, texture.width, texture.height);
	maf.quad_set_viewport(&quad, 0, 0, cast(f32)texture.width, cast(f32)texture.height);

	mat := maf.mat32_make(x, y);
	batcher_draw(batcher, texture, &quad, &mat);
}

draw_tex_rot_scale :: proc(texture: Texture, x, y, angle: f32, scale: f32 = 1) {
	maf.quad_set_image_dimensions(&quad, texture.width, texture.height);
	maf.quad_set_viewport(&quad, 0, 0, cast(f32)texture.width, cast(f32)texture.height);

	mat := maf.mat32_make_transform(x, y, angle, scale, scale, 0, 0);
	batcher_draw(batcher, texture, &quad, &mat);
}

// draws the part of texture specified by the viewport rect
draw_tex_viewport :: proc(texture: Texture, viewport: maf.Rect, mat: ^maf.Mat32, color: maf.Color = maf.COL_WHITE) {
	maf.quad_set_image_dimensions(&quad, texture.width, texture.height);
	maf.quad_set_viewport_rect(&quad, viewport);
	batcher_draw(batcher, texture, &quad, mat, color);
}

draw_text :: proc(str: cstring, fontbook: ^Font_Book = nil) {
	fontbook := fontbook != nil ? fontbook : default_fontbook;
	matrix := maf.mat32_make_transform(20, 40, 0, 4, 4, 0, 0);
	fontstash.set_align(fontbook.stash, cast(i32)fontstash.Align.Left);

	iter := fontstash.Text_Iter{};
	if fontstash.text_iter_init(fontbook.stash, &iter, 0, 0, str, nil) == 0 do fmt.panicf("text_iter_init failed");

	fons_quad := fontstash.Quad{};
	for fontstash.text_iter_next(fontbook.stash, &iter, &fons_quad) == 1 {
		// TODO: maybe make the transform_vec2_arr generic and just use a local fixed array for positions and tex coords and do this in batcher?
		quad.positions[0] = {fons_quad.x0, fons_quad.y0};
		quad.positions[1] = {fons_quad.x1, fons_quad.y0};
		quad.positions[2] = {fons_quad.x1, fons_quad.y1};
		quad.positions[3] = {fons_quad.x0, fons_quad.y1};

		quad.uvs[0] = {fons_quad.s0, fons_quad.t0};
		quad.uvs[1] = {fons_quad.s1, fons_quad.t0};
		quad.uvs[2] = {fons_quad.s1, fons_quad.t1};
		quad.uvs[3] = {fons_quad.s0, fons_quad.t1};

		batcher_draw(batcher, fontbook.texture, &quad, &matrix);
	}
}
