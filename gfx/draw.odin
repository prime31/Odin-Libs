package gfx

import "core:strings"
import "shared:engine/libs/fna"
import "core:fmt"
import "core:math"
import "shared:engine/maf"
import "shared:engine/libs/fontstash"

@private
_quad: maf.Quad;
@private
_debug_render_enabled: bool = true;
@private
_white_tex: Texture;


debug_render_enabled :: proc(enabled: bool) {
	_debug_render_enabled = enabled;
}

begin_pass :: proc() {}

end_pass :: proc() {
	batcher_flush(_batcher);
	if _debug_render_enabled do debug_render();
}

commit :: proc() {
	// if we havent yet blitted to the screen do so now
	batcher_end_frame(_batcher);
}

draw_tex :: proc(texture: Texture, x, y: f32) {
	maf.quad_set_fill(&_quad, texture.width, texture.height);

	mat := maf.mat32_make(x, y);
	batcher_draw(_batcher, texture, &_quad, &mat);
}

draw_tex_rot_scale :: proc(texture: Texture, x, y, angle: f32, scale: f32 = 1) {
	maf.quad_set_fill(&_quad, texture.width, texture.height);

	mat := maf.mat32_make_transform(x, y, angle, scale, scale, 0, 0);
	batcher_draw(_batcher, texture, &_quad, &mat);
}

// draws the part of texture specified by the viewport rect
draw_tex_viewport :: proc(texture: Texture, viewport: maf.Rect, mat: ^maf.Mat32, color: maf.Color = maf.COL_WHITE) {
	maf.quad_set_image_dimensions(&_quad, texture.width, texture.height);
	maf.quad_set_viewport_rect(&_quad, viewport);
	batcher_draw(_batcher, texture, &_quad, mat, color);
}

draw_text :: proc(str: string, fontbook: ^Font_Book = nil) {
	cstr := strings.clone_to_cstring(str, context.temp_allocator);

	fontbook := fontbook != nil ? fontbook : default_fontbook;
	matrix := maf.mat32_make_transform(20, 40, 0, 4, 4, 0, 0);
	fontstash.set_align(fontbook.stash, cast(i32)fontstash.Align.Left);

	iter := fontstash.Text_Iter{};
	if fontstash.text_iter_init(fontbook.stash, &iter, 0, 0, cstr, nil) == 0 do fmt.panicf("text_iter_init failed");

	fons_quad := fontstash.Quad{};
	for fontstash.text_iter_next(fontbook.stash, &iter, &fons_quad) == 1 {
		// TODO: maybe make the transform_vec2_arr generic and just use a local fixed array for positions and tex coords and do this in batcher?
		_quad.positions[0] = {fons_quad.x0, fons_quad.y0};
		_quad.positions[1] = {fons_quad.x1, fons_quad.y0};
		_quad.positions[2] = {fons_quad.x1, fons_quad.y1};
		_quad.positions[3] = {fons_quad.x0, fons_quad.y1};

		_quad.uvs[0] = {fons_quad.s0, fons_quad.t0};
		_quad.uvs[1] = {fons_quad.s1, fons_quad.t0};
		_quad.uvs[2] = {fons_quad.s1, fons_quad.t1};
		_quad.uvs[3] = {fons_quad.s0, fons_quad.t1};

		batcher_draw(_batcher, fontbook.texture, &_quad, &matrix);
	}
}

draw_line :: proc(start, end: maf.Vec2, thickness: f32 = 1, color: maf.Color = maf.COL_WHITE) {
	maf.quad_set_fill(&_quad, 1, 1);

	angle := maf.vec2_angle_between(start, end);
	length := maf.vec2_distance(start, end);

	mat := maf.mat32_make_transform(start.x, start.y, angle, length, thickness, 0, 0);
	batcher_draw(_batcher, _white_tex, &_quad, &mat, color);
}

draw_circle :: proc(center: maf.Vec2, radius: f32, thickness: f32 = 1, color: maf.Color = maf.COL_WHITE, resolution: int = 12) {
	maf.quad_set_fill(&_quad, _white_tex.width, _white_tex.height);

	last := maf.Vec2{1, 0} * radius;
	last_p := maf.vec2_orthogonal(last);

	for i in 1..<resolution {
		at := maf.angle_to_vec(cast(f32)i * maf.PI_OVER_2 / cast(f32)resolution, radius);
		at_p := maf.vec2_orthogonal(at);

		draw_line(center + last, center + at, thickness, color);
		draw_line(center - last, center - at, thickness, color);
		draw_line(center + last_p, center + at_p, thickness, color);
		draw_line(center - last_p, center - at_p, thickness, color);

		last = at;
		last_p = at_p;
	}
}

draw_point :: proc(position: maf.Vec2, size: f32 = 1, color: maf.Color = maf.COL_WHITE) {
	maf.quad_set_fill(&_quad, cast(i32)size, cast(i32)size);

	offset := size == 1 ? 0 : size * 0.5;
	mat := maf.mat32_make_transform(position.x, position.y, 0, 1, 1, offset, offset);
	batcher_draw(_batcher, _white_tex, &_quad, &mat, color);
}

draw_rect :: proc(position: maf.Vec2, width, height: f32, color: maf.Color = maf.COL_WHITE) {
	maf.quad_set_fill(&_quad, cast(i32)width, cast(i32)height);
	mat := maf.mat32_make_transform(position.x, position.y, 0, 1, 1);
	batcher_draw(_batcher, _white_tex, &_quad, &mat, color);
}

draw_hollow_rect :: proc(position: maf.Vec2, width, height: f32, color: maf.Color = maf.COL_WHITE, thickness: f32 = 1) {
	tr := maf.Vec2{position.x + width, position.y};
	br := maf.Vec2{position.x + width, position.y + height};
	bl := maf.Vec2{position.x, position.y + height};

	draw_line(position, tr, thickness, color);
	draw_line(tr, br, thickness, color);
	draw_line(br, bl, thickness, color);
	draw_line(bl, position, thickness, color);
}

draw_polygon :: proc(verts: []maf.Vec2, color: maf.Color = maf.COL_WHITE, thickness: f32 = 1) {
	for i in 0..<len(verts) - 1 do draw_line(verts[i], verts[i + 1], thickness, color);
	draw_line(verts[len(verts) - 1], verts[0], thickness, color);
}
