package time

import "core:fmt"
import "core:runtime"
import "core:math"
import "shared:engine/utils"
import "shared:engine/libs/sdl"

// converted from Tyler Glaiel's: https://github.com/TylerGlaiel/FrameTimingControl/blob/master/frame_timer.cpp

@(private)
TOTAL_DT_SAMPLES_FOR_AVG :: 5;

@(private)
Timestep :: struct {
	// these are loaded from Settings in production code
	update_multiplicity: int,
	unlock_framerate: bool,

	// compute how many ticks one update should be
	fixed_deltatime: f32,
	desired_frametime: u64,

	// these are to snap deltaTime to vsync values if it's close enough
	vsync_maxerror: u64,
	snap_frequencies: [5]u64,

	prev_frame_time: u64,
	frame_accumulator: u64,

	resync: bool,
	time_averager: utils.Ring_Buffer(u64, TOTAL_DT_SAMPLES_FOR_AVG),
	total_delta_times: u64
}

@(private)
timestep: Timestep;


init :: proc(update_rate: f64 = 60, update_multiplicity: int = 1) {
	timestep = Timestep{
		update_multiplicity = update_multiplicity,

		fixed_deltatime = 1 / cast(f32)update_rate,
		desired_frametime = u64(cast(f64)sdl.get_performance_frequency() / update_rate),

		vsync_maxerror = sdl.get_performance_frequency() / 5000,

		prev_frame_time = sdl.get_performance_counter(),
		time_averager = utils.ring_buffer_make(u64, TOTAL_DT_SAMPLES_FOR_AVG)
	};

	utils.ring_buffer_fill(&timestep.time_averager, timestep.desired_frametime);
	timestep.total_delta_times = timestep.desired_frametime * TOTAL_DT_SAMPLES_FOR_AVG;

	time_60hz := u64(cast(f64)sdl.get_performance_frequency() / 60);
	timestep.snap_frequencies[0] = time_60hz;		// 60fps
	timestep.snap_frequencies[1] = time_60hz * 2;	// 30fps
	timestep.snap_frequencies[2] = time_60hz * 3;	// 20fps
	timestep.snap_frequencies[3] = time_60hz * 4;	// 15fps
	timestep.snap_frequencies[4] = (time_60hz + 1) / 2; // 120fps //120hz, 240hz, or higher need to round up, so that adding 120hz twice guaranteed is at least the same as adding time_60hz once
}

dt :: proc() -> f32 do return timestep.fixed_deltatime;

// resyncs timestep effectively causing the timestep to not try to catch up. Call this after loading a level or heavy operation.
resync :: proc() do timestep.resync = true;

tick :: proc(update: proc()) {
	update_fps();

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

	// delta time averaging
	timestep.total_delta_times -= utils.ring_buffer_pop(&timestep.time_averager);
	timestep.total_delta_times += delta_time;
	utils.ring_buffer_push(&timestep.time_averager, delta_time);
	delta_time = timestep.total_delta_times / TOTAL_DT_SAMPLES_FOR_AVG;

	// add to the accumulator
	timestep.frame_accumulator += delta_time;

	// spiral of death protection
	if timestep.frame_accumulator > timestep.desired_frametime * 8 do resync();

	// timer resync if requested
	if timestep.resync {
		timestep.frame_accumulator = 0;
		delta_time = timestep.desired_frametime;
		timestep.resync = false;
	}

	// LOCKED FRAMERATE, NO INTERPOLATION
	for timestep.frame_accumulator >= timestep.desired_frametime * cast(u64)timestep.update_multiplicity {
		for i := 0; i < timestep.update_multiplicity; i += 1 {
			update();
			timestep.frame_accumulator -= timestep.desired_frametime;
		}
	}
}

