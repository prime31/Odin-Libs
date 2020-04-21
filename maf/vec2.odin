package maf

import "core:math"
import "core:math/linalg"

Vec2 :: linalg.Vector2;


vec2_orthogonal :: proc(v: Vec2) -> Vec2 {
	return {-v.y, v.x};
}

vec2_angle_between :: proc(from, to: Vec2) -> f32 do return math.atan2(to.y - from.y, to.x - from.x);

vec2_distance_sq :: proc(vec1, vec2: Vec2) -> f32 {
	v1 := vec1.x - vec2.x;
	v2 := vec1.y - vec2.y;
	return v1 * v1 + v2 * v2;
}

vec2_distance :: proc(vec1, vec2: Vec2) -> f32 do return math.sqrt(vec2_distance_sq(vec1, vec2));

