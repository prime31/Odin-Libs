package tilemap

Map :: struct {
    width: i32,
    height: i32,
	tile_size: i32,
	tilesets: []Tileset, // TODO: support multiple Tilesets
	tile_layers: []Tile_Layer,
	object_layers: []Object_Layer,
	group_layers: []Group_Layer
	// image_layers: []ImageLayer
}

