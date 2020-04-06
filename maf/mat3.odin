package maf

import "core:math/linalg"

Mat3 :: linalg.Matrix3x3;

MAT3_IDENTITY :: Mat3{{1, 0, 0}, {0, 1, 0}, {0, 0, 1}};


mat3_ortho :: proc(width, height: f32, z_near: f32 = 0, z_far: f32 = 1) -> Mat3 {
	result := Mat3{};
    result[0][0] = 2 / width;
    result[1][0] = 2 / height;
    result[2][2] = 1 / (z_near - z_far);

	return result;
}
