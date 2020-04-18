package gfx

import "core:math"
import "shared:engine/maf"

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
