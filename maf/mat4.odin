package maf

import "core:math/linalg"

Mat4 :: linalg.Matrix4x4;


mat4_ortho :: proc(width, height: f32, z_near: f32 = 0, z_far: f32 = 1) -> Mat4 {
	result := Mat4{};
    result[0][0] = 2 / width;
    result[1][1] = 2 / height;
    result[2][2] = 1 / (z_near - z_far);

    result[3][2] = z_near / (z_near - z_far);
    result[3][3] = 1;

	return result;
}
