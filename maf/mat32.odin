package maf

import "core:math"

/* 3 row, 2 col 2D matrix
 *
 * m[0] m[2] m[4]
 * m[1] m[3] m[5]
 *
 * 0: scaleX	2: sin		4: transX
 * 1: cos		3: scaleY	5: transY
 */
Mat32 :: distinct [6]f32;

MAT32_IDENTITY :: Mat32{1, 0, 0, 1, 0, 0};


mat32_ortho :: proc(width, height: f32) -> Mat32 {
	result := Mat32{};
    result[0] = 2 / width;
    result[3] = -2 / height;
    result[4] = -1;
    result[5] = 1;
    return result;
}

mat32_ortho_off_center :: proc(width, height: f32) -> Mat32 {
	half_w := cast(f32)i32(f32(width) / 2);
	half_h := cast(f32)i32(f32(height) / 2);

    result := MAT32_IDENTITY;
    result[0] = 2.0 / (half_w + half_w);
    result[3] = 2.0 / (-half_h - half_h);
    result[4] = (-half_w + half_w) / (-half_w - half_w);
    result[5] = (half_h - half_h) / (half_h + half_h);
    return result;
}

mat32_translate :: proc(m: ^Mat32, x, y: f32) {
    m[4] = m[0] * x + m[2] * y + m[4];
    m[5] = m[1] * x + m[3] * y + m[5];
}

mat32_rotate :: proc(m: ^Mat32, rads: f32) {
    cos := math.cos(rads);
    sin := math.sin(rads);

    nm0 := m[0] * cos + m[2] * sin;
    nm1 := m[1] * cos + m[3] * sin;

    m[2] = m[0] * -sin + m[2] * cos;
    m[3] = m[1] * -sin + m[3] * cos;
    m[0] = nm0;
    m[1] = nm1;
}

mat32_scale :: proc(m: ^Mat32, x, y: f32) {
    m[0] *= x;
    m[1] *= x;
    m[2] *= y;
    m[3] *= y;
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

mat32_transform_vec2 :: proc(m: ^Mat32, pos: Vec2) -> Vec2 {
    return Vec2{
        pos.x * m[0] + pos.y * m[2] + m[4],
        pos.x * m[1] + pos.y * m[3] + m[5]
    };
}

mat32_transform_vec2_arr :: proc(m: ^Mat32, dst: []$T, src: []Vec2) {
    for i in 0..<len(dst) {
        dst[i].pos.x = src[i].x * m[0] + src[i].y * m[2] + m[4];
        dst[i].pos.y = src[i].x * m[1] + src[i].y * m[3] + m[5];
    }
}

mat32_transform_vertex_slice :: proc(m: ^Mat32, dst: []$T) {
    for i in 0..<len(dst) {
        x := dst[i].pos.x * m[0] + dst[i].pos.y * m[2] + m[4];
        y := dst[i].pos.x * m[1] + dst[i].pos.y * m[3] + m[5];

        // we defer setting because src and dst are the same
        dst[i].pos.x = x;
        dst[i].pos.y = y;
    }
}
