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
	Rect,
	Hollow_Rect,
	Circle,
	Hollow_Circle,
	Text
}

@(private="file")
Point :: struct {
	type: Type,
	pos: maf.Vec2,
	size: f32,
	color: maf.Color
}

@(private="file")
Line :: struct {
	type: Type,
	pt1: maf.Vec2,
	pt2: maf.Vec2,
	thickness: f32,
	color: maf.Color
}

@(private="file")
Rect :: struct {
	type: Type,
	pos: maf.Vec2,
	w: f32,
	h: f32,
	thickness: f32,
	color: maf.Color
}

@(private="file")
Circle :: struct {
	type: Type,
	center: maf.Vec2,
	r: f32,
	color: maf.Color
}

@(private="file")
Text :: struct {
	type: Type,
	pos: maf.Vec2,
	text: string,
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
			case .Point: draw_point(item.point.pos, item.point.size, item.point.color);
			case .Line: draw_line(item.line.pt1, item.line.pt2, item.line.thickness, item.line.color);
			case .Rect: draw_rect(item.rect.pos, item.rect.w, item.rect.h, item.rect.color);
			case .Hollow_Rect: draw_hollow_rect(item.rect.pos, item.rect.w, item.rect.h, item.rect.color);
			case .Circle: unimplemented();
			case .Hollow_Circle: draw_circle(item.circle.center, item.circle.r, 1, item.circle.color);
			case .Text: draw_text(item.text.text);
		}
	}
	clear_dynamic_array(&_debug_items);
}

debug_draw_point :: proc(pos: maf.Vec2, size: f32, color: maf.Color = maf.COL_WHITE) {
	tmp := Draw_Item{};
	tmp.point = {.Point, pos, size, color};
	append(&_debug_items, tmp);
}

debug_draw_line :: proc(pt1, pt2: maf.Vec2, thickness: f32, color: maf.Color = maf.COL_WHITE) {
	tmp := Draw_Item{};
	tmp.line = {.Line, pt1, pt2, thickness, color};
	append(&_debug_items, tmp);
}

debug_draw_line_vec :: proc(pt1, pt2: maf.Vec2, thickness: f32, color: maf.Color = maf.COL_WHITE) {
	tmp := Draw_Item{};
	tmp.line = {.Line, pt1, pt2, thickness, color};
	append(&_debug_items, tmp);
}

debug_draw_rect :: proc(pos: maf.Vec2, width, height, thickness: f32, color: maf.Color = maf.COL_WHITE) {
	tmp := Draw_Item{};
	tmp.rect = {.Rect, pos, width, height, thickness, color};
	append(&_debug_items, tmp);
}

debug_draw_hollow_rect :: proc(pos: maf.Vec2, width, height, thickness: f32, color: maf.Color = maf.COL_WHITE) {
	tmp := Draw_Item{};
	tmp.rect = {.Hollow_Rect, pos, width, height, thickness, color};
	append(&_debug_items, tmp);
}

debug_draw_hollow_circle :: proc(center: maf.Vec2, radius: f32, color: maf.Color = maf.COL_WHITE) {
	tmp := Draw_Item{};
	tmp.circle = {.Hollow_Circle, center, radius, color};
	append(&_debug_items, tmp);
}

debug_draw_text :: proc(text: string, center: maf.Vec2, color: maf.Color = maf.COL_WHITE) {
	tmp := Draw_Item{};
	tmp.text = {.Text, center, strings.clone(text, context.temp_allocator), color};
	append(&_debug_items, tmp);
}


