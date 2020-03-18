package time

import "shared:engine/libs/sdl"

@(private)
Time :: struct {
	fps_frames: u32,
	prev_time: u32,
	curr_time: u32,
	fps_last_update: u32,
	dt: f32,
	fps: u32,
	frame_count: u32
}

@(private)
time := Time{
	frame_count = 1
};

tick :: proc() {
	time.frame_count += 1;
	time.fps_frames += 1;
	time.prev_time = time.curr_time;
	time.dt = 0.001 * f32(time.curr_time - time.prev_time);

	time_since_last := time.curr_time - time.fps_last_update;
	if time.curr_time > time.fps_last_update + 1000 {
		time.fps = time.fps_frames * 1000 / time_since_last;
		time.fps_last_update = time.curr_time;
		time.fps_frames = 0;
	}
}

sleep :: proc(milliseconds: u32) { sdl.delay(milliseconds); }

dt :: proc() -> f32 { return time.dt; }

frames :: proc() -> u32 { return time.frame_count; }

ticks :: proc() -> u32 { return sdl.get_ticks(); }

seconds :: proc() -> f32 { return f32(sdl.get_ticks()) / 1000.0; }

fps :: proc() -> u32 { return time.fps; }

now :: proc() -> u64 { return sdl.get_performance_counter(); }

// returns the time in milliseconds since the last call
laptime :: proc(last_time: ^u64) -> f64 {
	tmp := last_time;
	dt: f64 = 0;
	now := now();
	if tmp^ != 0 {
		dt = cast(f64)((now - tmp^) * 1000.0) / cast(f64)sdl.get_performance_frequency();
	}
	tmp^ = now;
	return dt;
}

