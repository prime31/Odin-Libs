package main

import "core:fmt"
import "shared:engine/sokol"
import "shared:engine/flextgl"
import "shared:engine/ctest"


main :: proc() {
	// fmt.println("init: ");
	// res := flextgl.init();
	// fmt.println("done: ", res);

	desc := sokol.sg_desc{};
	fmt.println(desc);
	sokol.setup(&desc);

	fmt.println("starting");
	fmt.println(ctest.add_int(10, 5));
}
