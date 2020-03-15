package tilemap

FLIPPED_H : i32 : 0x08000000;
FLIPPED_V : i32 : 0x04000000;
FLIPPED_D : i32 : 0x02000000;

Tile_Layer :: struct {
	name: string,
	visible: bool,
	width: i32,
	height: i32,
	tiles: []Tile_Id
}
