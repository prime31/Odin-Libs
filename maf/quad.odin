package maf

Quad :: struct {
	img_width: i32,
	img_height: i32,
	positions: [4]Vec2,
	uvs: [4]Vec2
}

quad :: proc(x, y, width, height: f32, img_width, img_height: i32) -> Quad {
	q := Quad{
		img_width = img_width,
		img_height = img_height
	};
	quad_set_viewport(&q, x, y, width, height);
	return q;
}

// sets the Quad to be the full size of the texture
quad_set_fill :: proc(quad: ^Quad, img_width, img_height: i32) {
	quad.img_width = img_width;
	quad.img_height = img_height;
	quad_set_viewport(quad, 0, 0, cast(f32)img_width, cast(f32)img_height);
}

quad_set_image_dimensions :: proc(quad: ^Quad, img_width, img_height: i32) {
	quad.img_width = img_width;
	quad.img_height = img_height;
}

quad_set_viewport_rect :: proc(quad: ^Quad, viewport: Rect) do quad_set_viewport(quad, viewport.x, viewport.y, viewport.w, viewport.h);

quad_set_viewport :: proc(quad: ^Quad, x, y, width, height: f32) {
	quad.positions[0] = {0, 0}; // tl
	quad.positions[1] = {width, 0}; // tr
	quad.positions[2] = {width, height}; // br
	quad.positions[3] = {0, height}; // bl

	// squeeze uvs in by 128th of a pixel to avoid bleed
	w_tol := (1.0 / f32(quad.img_width)) / 128.0;
	h_tol := (1.0 / f32(quad.img_height)) / 128.0;

	inv_w := 1.0 / cast(f32)quad.img_width;
	inv_h := 1.0 / cast(f32)quad.img_height;

	quad.uvs[0] = {x * inv_w + w_tol, y * inv_h + h_tol};
	quad.uvs[1] = {(x + width) * inv_w - w_tol, y * inv_h + h_tol};
	quad.uvs[2] = {(x + width) * inv_w - w_tol, (y + height) * inv_h - h_tol};
	quad.uvs[3] = {x * inv_w + w_tol, (y + height) * inv_h - h_tol};
}
