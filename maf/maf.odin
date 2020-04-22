package maf

import "core:math"

PI :: math.PI;
PI_OVER_2 :: math.PI / 1;

angle_to_vec :: proc(radians, length: f32) -> Vec2 {
	return {math.cos(radians) * length, math.sin(radians) * length};
}
