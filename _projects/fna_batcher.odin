package main

import "shared:engine/time"
import "core:fmt"
import "shared:engine"
import "shared:engine/gfx"


texture1: gfx.Texture;
texture2: gfx.Texture;
rt: gfx.Render_Texture;

main :: proc() {
	engine.run({
		init = init,
		update = update,
		render = render
	});
}

init :: proc() {
	texture1 = gfx.new_checkerboard_texture();
	texture2 = gfx.load_texture("assets/angular.png", {filter = .Linear});
	rt = gfx.new_render_texture(50, 50, gfx.default_sampler_state);
}

update :: proc() {}

render :: proc() {
	gfx.begin_pass();
	gfx.draw_tex(texture1, 10, 10);
	gfx.draw_tex(texture2, 200, 200);
	gfx.draw_tex(texture1, 50, 50);
	gfx.draw_tex(texture1, 60, 60);
	gfx.draw_tex(texture1, 70, 70);
	gfx.end_pass();

	gfx.begin_pass();
	gfx.draw_tex(texture1, 10 + 50, 10 + 5);
	gfx.draw_tex(texture2, 200 + 50, 200 + 5);
	gfx.draw_tex(texture1, 10 + 50, 10 + 5);
	gfx.draw_tex(texture1, 10 + 60, 10 + 5);
	gfx.draw_tex(texture1, 10 + 70, 10 + 5);
	gfx.draw_tex(texture1, 10 + 80, 10 + 5);
	gfx.draw_tex(texture1, 10 + 90, 10 + 5);
	gfx.draw_tex(texture1, 10 + 100, 10 + 5);
	gfx.end_pass();


	gfx.set_render_texture(&rt);
	gfx.clear({1, 0.5, 1, 1});
	gfx.begin_pass();
	for i in 0..50 / texture1.width {
		gfx.draw_tex(texture1, cast(f32)i * 4, 10 + cast(f32)i);
	}
	gfx.draw_tex(texture1, 10, 10);
	gfx.draw_tex(texture1, 20, 20);
	gfx.draw_tex(texture1, 30, 30);
	gfx.end_pass();
	gfx.set_render_texture(nil);

	gfx.begin_pass();
	gfx.draw_tex(rt, 400, 100);
	gfx.end_pass();
}


