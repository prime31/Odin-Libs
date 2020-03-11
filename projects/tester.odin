package main

import "core:fmt"
import "libs/mathy"
import "shared:sdl2"
import sdl_image "shared:sdl2/image"
import sdl_ttf "shared:sdl2/ttf"

Vector2 :: struct {
    x: f32,
    y: f32
}


main :: proc() {
	sdl2.init(sdl2.Init_Flags.Everything);
	window := sdl2.create_window("Test window", i32(sdl2.Window_Pos.Undefined), i32(sdl2.Window_Pos.Undefined), 800, 600, sdl2.Window_Flags(0));
	renderer := sdl2.create_renderer(window, -1, sdl2.Renderer_Flags(0));

	sdl_image.init(sdl_image.Init_Flags.PNG);
	sdl_ttf.init();

	texture := sdl_image.load_texture(renderer, "assets/angular.png");

	font := sdl_ttf.open_font("/System/Library/Fonts/MarkerFelt.ttc", 32);
	text_surface := sdl_ttf.render_utf8_solid(font, "odin-sdl2 now supports packages!", sdl2.Color{170, 205, 170, 255});
	text_texture := sdl2.create_texture_from_surface(renderer, text_surface);
	sdl2.free_surface(text_surface);

	running := true;
	for running {
		e: sdl2.Event;
		for sdl2.poll_event(&e) != 0 {
			if e.type == sdl2.Event_Type.Quit {
				running = false;
			}
		}

		sdl2.set_render_draw_color(renderer, 25, 25, 25, 255);
		sdl2.render_clear(renderer);

		pos := sdl2.Rect{20, 20, 50, 50};
		sdl2.render_copy(renderer, texture, nil, &pos);

		pos.y = 100;
		sdl2.query_texture(text_texture, nil, nil, &pos.w, &pos.h);
		sdl2.render_copy(renderer, text_texture, nil, &pos);

		sdl2.render_present(renderer);
	}

	sdl2.quit();
}
