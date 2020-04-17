package utils

import "core:fmt"
import "core:runtime"
import "shared:engine/libs/sdl"

// set to true to enable the profiler
PROFILER_ENABLED :: false;

Profiler :: struct {
	stats: map[u64]Block_Stats
}

Profiler_Block :: struct {
	profiler: ^Profiler,
	proc_hash: u64,
	start_time: u64
}

Block_Stats :: struct {
	name: string,
	total_time: u64,
	num_times: i32,
	avg_time: u64,
	max_time: u64
}


profiler_make :: proc() -> Profiler {
	return Profiler{};
}

when PROFILER_ENABLED {

@(deferred_out=profiler_end_time_block)
profiler_time_block :: proc(profiler: ^Profiler, loc := #caller_location) -> Profiler_Block {
	if loc.hash notin profiler.stats {
		profiler.stats[loc.hash] = Block_Stats{
			name = loc.procedure
		};
	}

	return {
		profiler = profiler,
		proc_hash = loc.hash,
		start_time = sdl.get_performance_counter()
	};
}

profiler_end_time_block :: proc(block: Profiler_Block) {
	end_time := sdl.get_performance_counter();

	section := block.profiler.stats[block.proc_hash];

	time_taken := end_time - block.start_time;
	section.total_time += time_taken;
	section.num_times += 1;
	section.avg_time = section.total_time / cast(u64)section.num_times;
	section.max_time = max(section.max_time, time_taken);

	block.profiler.stats[block.proc_hash] = section;
}

} else {
	@(disabled=!PROFILER_ENABLED)
	profiler_time_block :: proc(profiler: ^Profiler, loc := #caller_location) {}
}
