package tilemap

Object_Layer :: struct {
	name: string,
	visible: bool,
	objects: []Object
}

Image_Layer :: struct {
	name: string,
	visible: bool,
	source: string
}


Group_Layer :: struct {
	name: string,
	visible: bool,
	tile_layers: []Tile_Layer,
	object_layers: []Object_Layer
	//group_layers: []Group_Layer // TODO: JSON cant handle this yet
}

