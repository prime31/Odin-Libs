package time

import "core:runtime"
import "core:math"
import "core:fmt"
import "shared:engine/libs/sdl"

// converted from Tyler Glaiel's: https://github.com/TylerGlaiel/FrameTimingControl/blob/master/frame_timer.cpp

@(private)
Timestep :: struct {
	// these are loaded from Settings in production code
	update_rate: f64,
	update_multiplicity: int,
	unlock_framerate: bool,

	// compute how many ticks one update should be
	fixed_deltatime: f32,
	desired_frametime: u64,

	// these are to snap deltaTime to vsync values if it's close enough
	vsync_maxerror: u64,
	snap_frequencies: [5]u64,

	prev_frame_time: u64,
	frame_accumulator: u64
}

@(private)
timestep: Timestep;

init :: proc(update_rate: f64 = 60, update_multiplicity: int = 1) {
	timestep = Timestep{
		update_rate = update_rate,
		update_multiplicity = update_multiplicity,

		fixed_deltatime = 1 / cast(f32)update_rate,
		desired_frametime = u64(cast(f64)sdl.get_performance_frequency() / update_rate),

		vsync_maxerror = sdl.get_performance_frequency() / 5000,

		prev_frame_time = sdl.get_performance_counter()
	};

	time_60hz := u64(cast(f64)sdl.get_performance_frequency() / 60);
	timestep.snap_frequencies[0] = time_60hz;		// 60fps
	timestep.snap_frequencies[1] = time_60hz * 2;	// 30fps
	timestep.snap_frequencies[2] = time_60hz * 3;	// 20fps
	timestep.snap_frequencies[3] = time_60hz * 4;	// 15fps
	timestep.snap_frequencies[4] = (time_60hz + 1) / 2; // 120fps //120hz, 240hz, or higher need to round up, so that adding 120hz twice guaranteed is at least the same as adding time_60hz once
}

tick :: proc(update: proc(f32)) {
	// frame timer
    current_frame_time := sdl.get_performance_counter();
    delta_time := current_frame_time - timestep.prev_frame_time;
    timestep.prev_frame_time = current_frame_time;

	// handle unexpected timer anomalies (overflow, extra slow frames, etc)
	if delta_time > timestep.desired_frametime * 8 do delta_time = timestep.desired_frametime;
	if delta_time < 0 do delta_time = 0;

	// vsync time snapping
	for snap in timestep.snap_frequencies {
		if abs(delta_time - snap) < timestep.vsync_maxerror {
			delta_time = snap;
			break;
		}
	}

	// add to the accumulator
	timestep.frame_accumulator += delta_time;

	// spiral of death protection
	if timestep.frame_accumulator > timestep.desired_frametime * 8 {
		timestep.frame_accumulator = 0;
		delta_time = timestep.desired_frametime;
	}

	// LOCKED FRAMERATE, NO INTERPOLATION
	for timestep.frame_accumulator >= timestep.desired_frametime * cast(u64)timestep.update_multiplicity {
		for i := 0; i < timestep.update_multiplicity; i += 1 {
			update(timestep.fixed_deltatime);
			timestep.frame_accumulator -= timestep.desired_frametime;
		}
	}
}


main :: proc() {
	sdl.init(cast(sdl.Init_Flags)0);
	init();

	tick(proc(dt:f32){
		fmt.println("dt", dt);
	});
	tick(proc(dt:f32){
		fmt.println("dt", dt);
	});
	tick(proc(dt:f32){
		fmt.println("dt", dt);
	});
	fmt.println(timestep);
}
