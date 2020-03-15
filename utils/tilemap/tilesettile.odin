package tilemap

Tileset_Tile :: struct {
	id: i32,
	oneway: bool,
	slope: bool,
	slope_tl: i32,
	slope_tr: i32,
	props: map[string]string
}
