package tilemap

import "core:fmt"
import "core:mem"
import "core:strconv"
import "shared:engine/utils/jsmn"

SLOPE_TR_KEY :: "nez:slopeTopRight";
SLOPE_TL_KEY :: "nez:slopeTopLeft";
ONEWAY_KEY :: "nez:isOneWayPlatform";


load :: proc(data: []byte) -> Map {
	parser := jsmn.parser();
	defer { jsmn.free(parser); }

	err := jsmn.parse(&parser, data);
	if err != .No_Error {
		return Map{};
	}

	m := Map{
		width = jsmn.token_as_i32(&parser.tokens[2], data),
		height = jsmn.token_as_i32(&parser.tokens[4], data),
		tile_size = jsmn.token_as_i32(&parser.tokens[6], data),
		tilesets = make([]Tileset, parser.tokens[8].size)
	};

	for i in 0..<parser.tokens[8].size {
		m.tilesets[i] = parse_tileset(data, jsmn.array_get_at(&parser.tokens[8], i));
	}

	tile_layers_arr := jsmn.object_get_member(data, &parser.tokens[0], "tile_layers");
	m.tile_layers = make([]Tile_Layer, tile_layers_arr.size);
	for i in 0..<tile_layers_arr.size {
		m.tile_layers[i] = parse_tilelayer(data, jsmn.array_get_at(tile_layers_arr, i));
	}

	obj_layers_arr := jsmn.object_get_member(data, &parser.tokens[0], "object_layers");
	m.object_layers = make([]Object_Layer, obj_layers_arr.size);
	for i in 0..<obj_layers_arr.size {
		m.object_layers[i] = parse_objectlayer(data, jsmn.array_get_at(obj_layers_arr, i));
	}

	return m;
}

parse_tileset :: proc(js: []byte, token_ptr: ^jsmn.Token) -> Tileset {
	tokens := mem.slice_ptr(token_ptr, int(token_ptr.end - token_ptr.start));
	tiles_arr_tok := &tokens[12];

	ts := Tileset{
		tile_size = jsmn.token_as_i32(&tokens[2], js),
		spacing = jsmn.token_as_i32(&tokens[4], js),
		margin = jsmn.token_as_i32(&tokens[6], js),
		image = jsmn.token_as_string(&tokens[8], js),
		image_columns = jsmn.token_as_i32(&tokens[10], js),
		tiles = make([]Tileset_Tile, tiles_arr_tok.size)
	};

	for i in 0..<tiles_arr_tok.size {
		tile_tok := mem.slice_ptr(jsmn.array_get_at(tiles_arr_tok, i), int(tiles_arr_tok.end - tiles_arr_tok.start));

		tile := Tileset_Tile{
			id = jsmn.token_as_i32(&tile_tok[2], js)
		};

		prop_arr_tok := &tile_tok[4];
		for j in 0..<prop_arr_tok.size {
			ele := jsmn.array_get_at(prop_arr_tok, i);
			prop_tok := mem.slice_ptr(ele, int(ele.end - ele.start));

			// fetch common types and dont bother sticking them in the props map
			if jsmn.token_eq_string(&prop_tok[2], js, SLOPE_TR_KEY) {
				tile.slope = true;
				tile.slope_tr = jsmn.token_as_i32(&prop_tok[4], js);
			} else if jsmn.token_eq_string(&prop_tok[2], js, SLOPE_TL_KEY) {
				tile.slope = true;
				tile.slope_tl = jsmn.token_as_i32(&prop_tok[4], js);
			} else if jsmn.token_eq_string(&prop_tok[2], js, ONEWAY_KEY) {
				tile.oneway = true;
				continue;
			}

			// TODO: should these be cloned?
			key := jsmn.token_as_string(&prop_tok[2], js);
			tile.props[key] = jsmn.token_as_string(&prop_tok[4], js);
		}

		ts.tiles[i] = tile;
	}

	return ts;
}

parse_tilelayer :: proc(js: []byte, token_ptr: ^jsmn.Token) -> Tile_Layer {
	tokens := mem.slice_ptr(token_ptr, int(token_ptr.end - token_ptr.start));
	tiles_arr_tok := &tokens[10];

	tl := Tile_Layer{
		name = jsmn.token_as_string(&tokens[2], js),
		visible = jsmn.token_eq_string(&tokens[4], js, "true"),
		width = jsmn.token_as_i32(&tokens[6], js),
		height = jsmn.token_as_i32(&tokens[8], js),
		tiles = make([]Tile_Id, tiles_arr_tok.size)
	};

	for i in 0..<tiles_arr_tok.size {
		// array of ints so we know the next token is always the next element
		tl.tiles[i] = jsmn.token_as_i32(jsmn.array_get_at(tiles_arr_tok, i), js);
	}

	return tl;
}

parse_objectlayer :: proc(js: []byte, token_ptr: ^jsmn.Token) -> Object_Layer {
	tokens := mem.slice_ptr(token_ptr, int(token_ptr.end - token_ptr.start));
	objects_arr_tok := &tokens[6];

	ol := Object_Layer{
		name = jsmn.token_as_string(&tokens[2], js),
		visible = jsmn.token_eq_string(&tokens[4], js, "true"),
		objects = make([]Object, objects_arr_tok.size)
	};


	for i in 0..<objects_arr_tok.size {
		ele := jsmn.array_get_at(objects_arr_tok, i);
		obj_tok := mem.slice_ptr(ele, int(ele.end - ele.start));
		ol.objects[i] = Object{
			id = jsmn.token_as_i32(&obj_tok[2], js),
			name = jsmn.token_as_string(&obj_tok[4], js),
			shape = jsmn.token_as_i32(&obj_tok[6], js),
			x = jsmn.token_as_f32(&obj_tok[8], js),
			y = jsmn.token_as_f32(&obj_tok[10], js),
			w = jsmn.token_as_f32(&obj_tok[12], js),
			h = jsmn.token_as_f32(&obj_tok[14], js)
		};
	}

	return ol;
}

