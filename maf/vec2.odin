package maf

import "core:math/linalg"

Vec2 :: linalg.Vector2;


vec2_orthogonal :: proc(v: Vec2) -> Vec2 {
	return {-v.y, v.x};
}
