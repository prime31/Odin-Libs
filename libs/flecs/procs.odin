package flecs

import "core:strings"
import "core:mem"

when ODIN_OS == "windows" do foreign import flecs_lib "native/flecs.lib"
when ODIN_OS == "linux" do foreign import flecs_lib "native/flecs.a"
when ODIN_OS == "darwin" do foreign import flecs_lib "native/libflecs_static.a"

@(default_calling_convention="c", link_prefix="ecs_")
foreign flecs_lib {
	init :: proc() -> ^World ---;
	fini :: proc(world: ^World) -> i32 ---;
	quit :: proc(world: ^World) ---;
	progress :: proc(world: ^World, delta_time: f32) -> bool ---;
	new_component :: proc(world: ^World, id: cstring, size: u32) -> u64 ---;
	new_system :: proc(world: ^World, id: cstring, kind: System_Kind, sig: cstring, action: proc "c" (rows: ^Rows)) -> u64 ---;
	new_entity :: proc(world: ^World, id: cstring, components: cstring) -> u64 ---;
}


@(default_calling_convention="c", link_prefix="_ecs_")
foreign flecs_lib {
	set_ptr :: proc(world: ^World, entity: u64, component: u64, size: u32, ptr: rawptr) -> u64 ---;
	column :: proc(rows: ^Rows, size: u32, column: u32) -> rawptr ---;
}

col :: proc($T: typeid, rows: ^Rows, col: u32) -> []T {
	ptr := cast(^T)column(rows, size_of(T), col);
	return mem.slice_ptr(ptr, cast(int)rows.count);
}
