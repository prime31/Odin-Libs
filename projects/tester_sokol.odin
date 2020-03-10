package main

import "core:fmt"
import "shared:engine/sokol"


main :: proc() {
	fmt.println("done");
	desc := sokol.sg_desc{};
	sokol.setup(&desc);
}
