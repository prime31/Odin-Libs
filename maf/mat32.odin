package maf

Mat32 :: distinct [6]f32;


mat32_identity :: proc() -> Mat32 {
	mat := Mat32{};
	mat[0] = 1;
	mat[3] = 1;
	return mat;
}

mat32_ortho :: proc(width, height: f32) -> Mat32 {
    result := Mat32{};
    result[0] = 2.0 / width;
    result[3] = -2.0 / height;
    result[4] = -1.0;
    result[5] = 1.0;
    return result;
}

mat32_ortho_off_center :: proc(width, height: i32) -> Mat32 {
	half_w := cast(f32)i32(f32(width) / 2);
	half_h := cast(f32)i32(f32(height) / 2);

    result := Mat32{};
    result[0] = 2.0 / (half_w + half_w);
    result[3] = 2.0 / (-half_h - half_h);
    result[4] = (-half_w + half_w) / (-half_w - half_w);
    result[5] = (half_h - half_h) / (half_h + half_h);
    return result;
}
