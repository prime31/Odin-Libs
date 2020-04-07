package maf

import "core:math/linalg"

Mat4 :: linalg.Matrix4x4;


mat4_ortho :: proc(width, height: f32) -> Mat4 {
	result := Mat4{};
    result[0][0] = 2 / width;

    result[1][1] = -2 / height;
    result[2][2] = -1;

    result[3][0] = -1;
    result[3][1] = 1;
    result[3][3] = 1;

	return result;
}
