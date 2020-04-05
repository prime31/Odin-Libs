package maf

Vec2 :: distinct [2]f32;


vec2_orthogonal :: proc(v: Vec2) -> Vec2 {
	return {-v.y, v.x};
}
