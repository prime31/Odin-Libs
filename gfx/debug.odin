package gfx

import "core:strings"
import "shared:engine/maf"

@(private="file")
Draw_Item :: struct #raw_union {
	type: Type,
	point: Point,
	line: Line,
	rect: Rect,
	circle: Circle,
	text: Text
}

@(private="file")
Type :: enum {
	Point,
	Line,
	Hollow_Rect,
	Hollow_Circle,
	Text
}

@(private="file")
Point :: struct {
	type: Type,
	x: f32,
	y: f32,
	size: f32,
	color: maf.Color
}

@(private="file")
Line :: struct {
	type: Type,
	x1: f32,
	y1: f32,
	x2: f32,
	y2: f32,
	thickness: f32,
	color: maf.Color
}

@(private="file")
Rect :: struct {
	type: Type,
	x: f32,
	y: f32,
	w: f32,
	h: f32,
	thickness: f32,
	color: maf.Color
}

@(private="file")
Circle :: struct {
	type: Type,
	x: f32,
	y: f32,
	r: f32,
	color: maf.Color
}

@(private="file")
Text :: struct {
	type: Type,
	text: string,
	x: f32,
	y: f32,
	color: maf.Color
}

@(private="file")
_debug_items: [dynamic]Draw_Item;

@(private)
debug_init :: proc() {
	_debug_items = make([dynamic]Draw_Item);
}

@(private)
debug_render :: proc() {
	for item in _debug_items {
		switch item.type {
			case .Point: {}
			case .Line: {}
			case .Hollow_Rect: {}
			case .Hollow_Circle: {}
			case .Text: draw_text(item.text.text);
		}
	}
	clear_dynamic_array(&_debug_items);
}

debug_draw_point :: proc(x, y, size: f32, color: maf.Color = maf.COL_WHITE) {
	tmp := Draw_Item{};
	tmp.point = {.Point, x, y, size, color};
	append(&_debug_items, tmp);
}

debug_draw_line :: proc(x1, y1, x2, y2, thickness: f32, color: maf.Color = maf.COL_WHITE) {
	tmp := Draw_Item{};
	tmp.line = {.Line, x1, y1, x2, y2, thickness, color};
	append(&_debug_items, tmp);
}

debug_draw_line_vec :: proc(pt1, pt2: maf.Vec2, thickness: f32, color: maf.Color = maf.COL_WHITE) {
	tmp := Draw_Item{};
	tmp.line = {.Line, pt1.x, pt1.y, pt2.x, pt2.y, thickness, color};
	append(&_debug_items, tmp);
}

debug_draw_hollow_rect :: proc(x, y, width, height, thickness: f32, color: maf.Color = maf.COL_WHITE) {
	tmp := Draw_Item{};
	tmp.rect = {.Hollow_Rect, x, y, width, height, thickness, color};
	append(&_debug_items, tmp);
}

debug_draw_hollow_circle :: proc(x, y, radius: f32, color: maf.Color = maf.COL_WHITE) {
	tmp := Draw_Item{};
	tmp.circle = {.Hollow_Circle, x, y, radius, color};
	append(&_debug_items, tmp);
}

debug_draw_hollow_circle_vec :: proc(pos: maf.Vec2, radius: f32, color: maf.Color = maf.COL_WHITE) {
	tmp := Draw_Item{};
	tmp.circle = {.Hollow_Circle, pos.x, pos.y, radius, color};
	append(&_debug_items, tmp);
}

debug_draw_text :: proc(text: string, x, y: f32, color: maf.Color = maf.COL_WHITE) {
	tmp := Draw_Item{};
	tmp.text = {.Text, strings.clone(text, context.temp_allocator), x, y, color};
	append(&_debug_items, tmp);
}


