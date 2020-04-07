package maf

import "core:math"
import "core:math/linalg"

/* 3 row, 2 col 2D matrix
 *
 * 0,0: scaleX		0,1: cos
 * 1,0: sin			1,1: scaleY
 * 2,0: transX		2,1: transY
 */
Mat32 :: linalg.Matrix3x2;

MAT32_IDENTITY :: Mat32{{1, 0}, {0, 1}, {0, 0}};


mat32_ortho :: proc(width, height: f32) -> Mat32 {
	result := Mat32{};
    result[0][0] = 2 / width;
    result[1][1] = -2 / height;
    result[2][0] = -1;
    result[2][1] = 1;
    return result;
}

mat32_set_transform :: proc(m: ^Mat32, x, y, angle, sx, sy, ox, oy: f32) {
    c := math.cos(angle);
    s := math.sin(angle);

	// matrix multiplication carried out on paper:
	// |1    x| |c -s  | |sx     | |1   -ox|
	// |  1  y| |s  c  | |   sy  | |  1 -oy|
	//   move    rotate    scale     origin
	m[0][0] = c * sx;
	m[0][1] = s * sx;
	m[1][0] = -s * sy;
	m[1][1] = c * sy;
	m[2][0] = x - ox * m[0][0] - oy * m[1][0];
	m[2][1] = y - ox * m[0][1] - oy * m[1][1];
}
