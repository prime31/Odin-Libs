package main

import "core:os"
import "core:fmt"
import "shared:engine/time"
import "shared:engine/libs/sdl"
import "shared:engine/utils/jsmn"
import "shared:engine/utils/tilemap"

main :: proc() {
	sdl.init(cast(sdl.Init_Flags)0);
	timer: u64 = 0;
	time.laptime(&timer);

	data, success := os.read_entire_file("assets/platformer.json");
	defer if success { delete(data); }

	parser := jsmn.parser();
	defer { jsmn.free(parser); }
	err := jsmn.parse(&parser, data);

	elapsed := time.laptime(&timer);
	fmt.println("Elapsed parse time: ", elapsed);
	fmt.println("done. Result: ", err);


	mem := jsmn.object_get_member(data, &parser.tokens[0], "width");
	fmt.println("token[0].width", jsmn.token_as_string(mem, data));
	fmt.println();

	fmt.println(parser.tokens[21]);
	ele := jsmn.array_get_at(&parser.tokens[21], 0);
	fmt.println("token[21][0]", jsmn.token_as_string(ele, data));



	fmt.println("token[24]", jsmn.token_as_string(&parser.tokens[24], data));
	fmt.println();

	as_int := jsmn.token_as_i32(&parser.tokens[24], data);
	fmt.println("token as int: ", as_int);
	fmt.println("token as str: ", jsmn.token_as_string(&parser.tokens[24], data));
	fmt.println();

	as_f32 := jsmn.token_as_f32(&parser.tokens[31], data);
	fmt.println("token as f32: ", as_f32);
	fmt.println("token as str: ", jsmn.token_as_string(&parser.tokens[31], data));
}
