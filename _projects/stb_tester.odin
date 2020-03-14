
package main

import "core:fmt"
import "shared:engine/libs/stb_image"


main :: proc() {
	x, y, channels: i32;
	img := stb_image.load("assets/angular.png", &x, &y, &channels, 4);
	fmt.println(x, y, channels, img);

	// stb_image.stbi_write_bmp("assets/a.bmp", x, y, channels, img);

	stb_image.image_free(img);
}