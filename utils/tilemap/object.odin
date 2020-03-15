package tilemap

BOX :: 0;
CIRCLE :: 1;
ELLIPSE :: 3;
POINT :: 5;
POLYGON :: 11;


Object :: struct {
	id: i32,
	name: string,
	shape: i32,
	x: f32,
	y: f32,
	w: f32,
	h: f32
}
