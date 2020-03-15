package tilemap

import "core:fmt"
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
		tile_size = jsmn.token_as_i32(&parser.tokens[6], data)
	};

	fmt.println(m);

	return m;
}
