package tilemap

Tileset :: struct {
	tile_size: i32,
	spacing: i32,
	margin: i32,
	image: string,
	image_columns: i32,
	tiles: []Tileset_Tile
}
