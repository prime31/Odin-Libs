package tilemap

import "core:fmt"
import "core:mem"
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
		//append(&m.tilesets, parse_tileset(data, jsmn.array_get_at(&p.tokens[8], i)));
		//m.tilesets << parse_tileset(js, jsmn.array_get_at(&p.tokens[8], i))
	}

	fmt.println(m);

	return m;
}

parse_tileset :: proc(js: []byte, token_ptr: ^jsmn.Token) -> Tileset {
	tokens := mem.slice_ptr(token_ptr, 100);
	ts := Tileset{
		tile_size = jsmn.token_as_i32(&tokens[2], js),
		spacing = jsmn.token_as_i32(&tokens[4], js),
		margin = jsmn.token_as_i32(&tokens[6], js),
		image = jsmn.token_as_string(&tokens[8], js),
		image_columns = jsmn.token_as_i32(&tokens[10], js)
	};

	return ts;
}
