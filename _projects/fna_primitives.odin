package main

import "shared:engine/libs/imgui"
import "shared:engine/maf"
import "shared:engine/time"
import "core:fmt"
import "shared:engine"
import "shared:engine/gfx"


tri_batch: ^gfx.Tringle_Batcher;

main :: proc() {
	engine.run({
		init = init,
		update = update,
		render = render
	});
}

init :: proc() {
	tri_batch = gfx.new_tribatcher();
}

update :: proc() {}

render :: proc() {
	gfx.begin_pass();
	gfx.draw_line({0,0}, {20,20});
	gfx.draw_line({20,20}, {30,20});
	gfx.draw_line({20,20}, {500, 0});
	gfx.draw_line({30,10}, {50, 450}, 4);
	gfx.draw_circle({80, 230}, 50);
	gfx.draw_circle({180, 230}, 25, 4, maf.COL_BLACK, 6);
	gfx.draw_point({230, 130}, 4);
	gfx.end_pass();

	gfx.begin_pass();
	gfx.tribatcher_draw_triangle(tri_batch, {50, 50}, {150, 150}, {0, 150});
	gfx.tribatcher_end_frame(tri_batch);
	gfx.end_pass();
}


