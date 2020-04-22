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
	tri_batch = gfx.new_tribatch();
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
	gfx.draw_rect({50, 5}, 40, 20);
	gfx.draw_hollow_rect({150, 5}, 40, 20);
	gfx.end_pass();

	gfx.begin_pass();
	gfx.tribatch_draw_triangle(tri_batch, {50, 50}, {150, 150}, {0, 150});
	gfx.tribatch_draw_triangle(tri_batch, {250, 50}, {350, 150}, {200, 150}, maf.COL_BLACK);
	gfx.tribatch_end_frame(tri_batch);
	gfx.tribatch_draw_circle(tri_batch, {300, 300}, 50);

	poly := [?]maf.Vec2{{400,30}, {420,10}, {430, 80}, {410, 60}, {375, 40}};
	gfx.tribatch_draw_polygon(tri_batch, poly[:], maf.COL_BLACK);
	gfx.tribatch_end_frame(tri_batch);
	gfx.end_pass();
}


