package main

import "core:fmt"
import "shared:engine"
import "shared:engine/gfx"


texture1: gfx.Texture;
texture2: gfx.Texture;

main :: proc() {
	engine.run(init, update, render);
}

init :: proc() {
	texture1 = gfx.new_checkerboard_texture();
	texture2 = gfx.load_texture("assets/angular.png", {filter = .Linear});
}

update :: proc() {}

render :: proc() {
	gfx.begin_pass();
	gfx.draw_tex(texture1, 10, 10);
	gfx.draw_tex(texture2, 200, 200);
	gfx.draw_tex(texture1, 50, 50);
	gfx.end_pass();
}


