package maf

import "core:math"

/* OpenGL compatible 3x2 matrix
 *
 * m[0] m[2] m[4]
 * m[1] m[3] m[5]
 *
 * 0: scaleX	2: sin		4: transX
 * 1: cos		3: scaleY	5: transY

 * 0: scaleX	2: sin		4: transX
 * 1: cos		3: scaleY	5: transY
 */
Mat32 :: distinct [6]f32;


mat32_identity :: proc() -> Mat32 {
	mat := Mat32{};
	mat[0] = 1;
	mat[3] = 1;
	return mat;
}

mat32_ortho :: proc(width, height: f32) -> Mat32 {
    result := Mat32{};
    result[0] = 2 / width;
    result[5] = 2 / height;
    // result[0] = 2 / width;
    // result[3] = 2 / height;
    return result;
}

	// dstPtr[0] = value.0;
	// dstPtr[1] = value.3;
	// dstPtr[2] = value.6;
	// dstPtr[4] = value.1;
	// dstPtr[5] = value.4;
	// dstPtr[6] = value.7;
	// dstPtr[8] = value.2;
	// dstPtr[9] = value.5;
	// dstPtr[10] = value.8;

	// dstPtr[0] = value.M11;
	// dstPtr[1] = value.M21;
	// dstPtr[2] = value.M31;
	// dstPtr[3] = value.M12;
	// dstPtr[4] = value.M22;
	// dstPtr[5] = value.M32;

	// dstPtr[0] = value.M11;
	// dstPtr[1] = value.M21;
	// dstPtr[4] = value.M12;
	// dstPtr[5] = value.M22;


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


mat32_set_transform :: proc(m: ^Mat32, x, y, angle, sx, sy, ox, oy: f32) {
    c := math.cos(angle);
    s := math.sin(angle);

	// matrix multiplication carried out on paper:
	// |1    x| |c -s  | |sx     | |1   -ox|
	// |  1  y| |s  c  | |   sy  | |  1 -oy|
	//   move    rotate    scale     origin
	m[0] = c * sx;
	m[1] = s * sx;
	m[2] = -s * sy;
	m[3] = c * sy;
	m[4] = x - ox * m[0] - oy * m[2];
	m[5] = y - ox * m[1] - oy * m[3];
}
