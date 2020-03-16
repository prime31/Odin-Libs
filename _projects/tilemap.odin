package main

import "core:os"
import "core:fmt"
import "shared:engine/time"
import "shared:engine/libs/sdl2"
import "shared:engine/utils/jsmn"
import "shared:engine/utils/tilemap"

main :: proc() {
	sdl2.init(cast(sdl2.Init_Flags)0);

	timer: u64 = 0;
	time.laptime(&timer);

	data, success := os.read_entire_file("assets/platformer.json");
	defer if success { delete(data); }

	tmap := tilemap.load(data);

	elapsed := time.laptime(&timer);
	fmt.println("Elapsed parse time: ", elapsed / 1);
}
