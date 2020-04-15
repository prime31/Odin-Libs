package gfx

begin_pass :: proc() {

}

end_pass :: proc() {
	batcher_flush(batcher);
	// do debug render if enabled
}

commit :: proc() {
	// if we havent yet blitted to the screen do so now
	batcher_end_frame(batcher);
}

draw_tex :: proc(texture: Texture, x, y: f32) {
	batcher_draw_tex(batcher, texture, x, y);
}
