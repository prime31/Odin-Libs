package flecs

import "core:strings"
import "core:mem"

when ODIN_OS == "windows" do foreign import flecs_lib "native/flecs.lib"
when ODIN_OS == "linux" do foreign import flecs_lib "native/flecs.a"
when ODIN_OS == "darwin" do foreign import flecs_lib "native/libflecs_static.a"


col :: proc($T: typeid, rows: ^Rows, col: u32) -> []T {
	ptr := cast(^T)column(rows, size_of(T), col);
	return mem.slice_ptr(ptr, cast(int)rows.count);
}



foreign flecs_lib {
	// util/os_api
	@(link_name = "ecs_os_set_api")
	os_set_api :: proc(os_api: ^Os_Api) ---;

	@(link_name = "ecs_os_set_api_defaults")
	os_set_api_defaults :: proc() ---;

	@(link_name = "ecs_os_log")
	os_log :: proc(fmt: cstring) ---;

	@(link_name = "ecs_os_warn")
	os_warn :: proc(fmt: cstring) ---;

	@(link_name = "ecs_os_err")
	os_err :: proc(fmt: cstring) ---;

	@(link_name = "ecs_os_dbg")
	os_dbg :: proc(fmt: cstring) ---;

	@(link_name = "ecs_os_enable_dbg")
	os_enable_dbg :: proc(enable: bool) ---;

	@(link_name = "ecs_os_dbg_enabled")
	os_dbg_enabled :: proc() -> bool ---;

	@(link_name = "ecs_sleepf")
	sleepf :: proc(t: f64) ---;

	@(link_name = "ecs_time_measure")
	time_measure :: proc(start: ^Time) -> f64 ---;

	@(link_name = "ecs_time_sub")
	time_sub :: proc(t1: Time, t2: Time) -> Time ---;

	@(link_name = "Timeo_double")
	time_to_double :: proc(t: Time) -> f64 ---;

	@(link_name = "ecs_os_memdup")
	os_memdup :: proc(src: rawptr, size: u32) -> rawptr ---;
}



foreign flecs_lib {
	// util/vector
	@(link_name = "ecs_vector_new")
	vector_new :: proc(params: ^Vector_Params, size: u32) -> ^Vector ---;

	@(link_name = "ecs_vector_new_from_buffer")
	vector_new_from_buffer :: proc(params: ^Vector_Params, size: u32, buffer: rawptr) -> ^Vector ---;

	@(link_name = "ecs_vector_free")
	vector_free :: proc(array: ^Vector) ---;

	@(link_name = "ecs_vector_clear")
	vector_clear :: proc(array: ^Vector) ---;

	@(link_name = "ecs_vector_add")
	vector_add :: proc(array_inout: ^rawptr /* Vector** */, params: ^Vector_Params) -> rawptr ---;

	@(link_name = "ecs_vector_addn")
	vector_addn :: proc(array_inout: ^rawptr /* Vector** */, params: ^Vector_Params, count: u32) -> rawptr ---;

	@(link_name = "ecs_vector_get")
	vector_get :: proc(array: ^Vector, params: ^Vector_Params, index: u32) -> rawptr ---;

	@(link_name = "ecs_vector_get_index")
	vector_get_index :: proc(array: ^Vector, params: ^Vector_Params, elem: rawptr) -> u32 ---;

	@(link_name = "ecs_vector_last")
	vector_last :: proc(array: ^Vector, params: ^Vector_Params) -> rawptr ---;

	@(link_name = "ecs_vector_remove")
	vector_remove :: proc(array: ^Vector, params: ^Vector_Params, elem: rawptr) -> u32 ---;

	@(link_name = "ecs_vector_remove_last")
	vector_remove_last :: proc(array: ^Vector) ---;

	@(link_name = "ecs_vector_pop")
	vector_pop :: proc(array: ^Vector, params: ^Vector_Params, value: rawptr) -> bool ---;

	@(link_name = "ecs_vector_move_index")
	vector_move_index :: proc(dst_array: ^rawptr /* Vector** */, src_array: ^Vector, params: ^Vector_Params, index: u32) -> u32 ---;

	@(link_name = "ecs_vector_remove_index")
	vector_remove_index :: proc(array: ^Vector, params: ^Vector_Params, index: u32) -> u32 ---;

	@(link_name = "ecs_vector_reclaim")
	vector_reclaim :: proc(array: ^rawptr /* Vector** */, params: ^Vector_Params) ---;

	@(link_name = "ecs_vector_set_size")
	vector_set_size :: proc(array: ^rawptr /* Vector** */, params: ^Vector_Params, size: u32) -> u32 ---;

	@(link_name = "ecs_vector_set_count")
	vector_set_count :: proc(array: ^rawptr /* Vector** */, params: ^Vector_Params, size: u32) -> u32 ---;

	@(link_name = "ecs_vector_count")
	vector_count :: proc(array: ^Vector) -> u32 ---;

	@(link_name = "ecs_vector_size")
	vector_size :: proc(array: ^Vector) -> u32 ---;

	@(link_name = "ecs_vector_first")
	vector_first :: proc(array: ^Vector) -> rawptr ---;

	@(link_name = "ecs_vector_sort")
	vector_sort :: proc(array: ^Vector, params: ^Vector_Params, compare_action: proc(rawptr, rawptr) -> i32) ---;

	@(link_name = "ecs_vector_memory")
	vector_memory :: proc(array: ^Vector, params: ^Vector_Params, allocd: ^u32, used: ^u32) ---;

	@(link_name = "ecs_vector_copy")
	vector_copy :: proc(src: ^Vector, params: ^Vector_Params) -> ^Vector ---;
}



foreign flecs_lib {
	// include/flecs
	@(link_name = "ecs_init")
	init :: proc() -> ^World ---;

	@(link_name = "ecs_init_w_args")
	init_w_args :: proc(argc: i32, argv: []cstring) -> ^World ---;

	@(link_name = "ecs_fini")
	fini :: proc(world: ^World) -> i32 ---;

	@(link_name = "ecs_quit")
	quit :: proc(world: ^World) ---;

	@(link_name = "ecs_progress")
	progress :: proc(world: ^World, delta_time: f32) -> bool ---;

	@(link_name = "ecs_set_target_fps")
	set_target_fps :: proc(world: ^World, fps: f32) ---;

	@(link_name = "ecs_get_target_fps")
	get_target_fps :: proc(world: ^World) -> f32 ---;

	@(link_name = "ecs_get_delta_time")
	get_delta_time :: proc(world: ^World) -> f32 ---;

	@(link_name = "ecs_set_context")
	set_context :: proc(world: ^World, ctx: rawptr) ---;

	@(link_name = "ecs_get_context")
	get_context :: proc(world: ^World) -> rawptr ---;

	@(link_name = "ecs_get_tick")
	get_tick :: proc(world: ^World) -> u32 ---;

	@(link_name = "ecs_dim")
	dim :: proc(world: ^World, entity_count: u32) ---;

	@(link_name = "_ecs_dim_type")
	dim_type :: proc(world: ^World, typ: ^Vector, entity_count: u32) ---;

	@(link_name = "ecs_set_entity_range")
	set_entity_range :: proc(world: ^World, id_start: u64, id_end: u64) ---;

	@(link_name = "ecs_enable_range_check")
	enable_range_check :: proc(world: ^World, enable: bool) -> bool ---;

	@(link_name = "_ecs_new")
	new :: proc(world: ^World, typ: ^Vector) -> u64 ---;

	@(link_name = "_ecs_new_w_count")
	new_w_count :: proc(world: ^World, typ: ^Vector, count: u32) -> u64 ---;

	@(link_name = "ecs_set_w_data")
	set_w_data :: proc(world: ^World, data: ^Table_Data) -> u64 ---;

	@(link_name = "_ecs_new_child")
	new_child :: proc(world: ^World, parent: u64, typ: ^Vector) -> u64 ---;

	@(link_name = "_ecs_new_child_w_count")
	new_child_w_count :: proc(world: ^World, parent: u64, typ: ^Vector, count: u32) -> u64 ---;

	@(link_name = "_ecs_new_instance")
	new_instance :: proc(world: ^World, base: u64, typ: ^Vector) -> u64 ---;

	@(link_name = "_ecs_new_instance_w_count")
	new_instance_w_count :: proc(world: ^World, base: u64, typ: ^Vector, count: u32) -> u64 ---;

	@(link_name = "ecs_clone")
	clone :: proc(world: ^World, entity: u64, copy_value: bool) -> u64 ---;

	@(link_name = "ecs_delete")
	delete :: proc(world: ^World, entity: u64) ---;

	@(link_name = "ecs_delete_w_filter")
	delete_w_filter :: proc(world: ^World, filter: ^Filter) ---;

	@(link_name = "_ecs_add")
	add :: proc(world: ^World, entity: u64, typ: ^Vector) ---;

	@(link_name = "ecs_add_entity")
	add_entity :: proc(world: ^World, entity: u64, to_add: u64) ---;

	@(link_name = "_ecs_remove")
	remove :: proc(world: ^World, entity: u64, typ: ^Vector) ---;

	@(link_name = "ecs_remove_entity")
	remove_entity :: proc(world: ^World, entity: u64, to_remove: u64) ---;

	@(link_name = "_ecs_add_remove")
	add_remove :: proc(world: ^World, entity: u64, to_add: ^Vector, to_remove: ^Vector) ---;

	@(link_name = "ecs_adopt")
	adopt :: proc(world: ^World, entity: u64, parent: u64) ---;

	@(link_name = "ecs_orphan")
	orphan :: proc(world: ^World, entity: u64, parent: u64) ---;

	@(link_name = "ecs_inherit")
	inherit :: proc(world: ^World, entity: u64, base: u64) ---;

	@(link_name = "ecs_disinherit")
	disinherit :: proc(world: ^World, entity: u64, base: u64) ---;

	@(link_name = "_ecs_add_remove_w_filter")
	add_remove_w_filter :: proc(world: ^World, to_add: ^Vector, to_remove: ^Vector, filter: ^Filter) ---;

	@(link_name = "_ecs_get_ptr")
	get_ptr :: proc(world: ^World, entity: u64, typ: ^Vector) -> rawptr ---;

	@(link_name = "_ecs_set_ptr")
	set_ptr :: proc(world: ^World, entity: u64, component: u64, size: u32, ptr: rawptr) -> u64 ---;

	@(link_name = "_ecs_has")
	has :: proc(world: ^World, entity: u64, typ: ^Vector) -> bool ---;

	@(link_name = "_ecs_has_owned")
	has_owned :: proc(world: ^World, entity: u64, typ: ^Vector) -> bool ---;

	@(link_name = "_ecs_has_any")
	has_any :: proc(world: ^World, entity: u64, typ: ^Vector) -> bool ---;

	@(link_name = "_ecs_has_any_owned")
	has_any_owned :: proc(world: ^World, entity: u64, typ: ^Vector) -> bool ---;

	@(link_name = "ecs_has_entity")
	has_entity :: proc(world: ^World, entity: u64, component: u64) -> bool ---;

	@(link_name = "ecs_has_entity_owned")
	has_entity_owned :: proc(world: ^World, entity: u64, component: u64) -> bool ---;

	@(link_name = "ecs_contains")
	contains :: proc(world: ^World, parent: u64, child: u64) -> bool ---;

	@(link_name = "_ecs_get_parent")
	get_parent :: proc(world: ^World, entity: u64, component: u64) -> u64 ---;

	@(link_name = "ecs_get_type")
	get_type :: proc(world: ^World, entity: u64) -> ^Vector ---;

	@(link_name = "ecs_get_id")
	get_id :: proc(world: ^World, entity: u64) -> cstring ---;

	@(link_name = "_ecs_count")
	count :: proc(world: ^World, typ: ^Vector) -> u32 ---;

	@(link_name = "ecs_count_w_filter")
	count_w_filter :: proc(world: ^World, filter: ^Filter) -> u32 ---;

	@(link_name = "ecs_lookup")
	lookup :: proc(world: ^World, id: cstring) -> u64 ---;

	@(link_name = "ecs_lookup_child")
	lookup_child :: proc(world: ^World, parent: u64, id: cstring) -> u64 ---;

	@(link_name = "_ecs_column")
	column :: proc(rows: ^Rows, size: u32, column: u32) -> rawptr ---;

	@(link_name = "ecs_is_shared")
	is_shared :: proc(rows: ^Rows, column: u32) -> bool ---;

	@(link_name = "_ecs_field")
	field :: proc(rows: ^Rows, size: u32, column: u32, row: u32) -> rawptr ---;

	@(link_name = "ecs_column_source")
	column_source :: proc(rows: ^Rows, column: u32) -> u64 ---;

	@(link_name = "ecs_column_entity")
	column_entity :: proc(rows: ^Rows, column: u32) -> u64 ---;

	@(link_name = "ecs_column_type")
	column_type :: proc(rows: ^Rows, column: u32) -> ^Vector ---;

	@(link_name = "ecs_is_readonly")
	is_readonly :: proc(rows: ^Rows, column: u32) -> bool ---;

	@(link_name = "ecs_table_type")
	table_type :: proc(rows: ^Rows) -> ^Vector ---;

	@(link_name = "ecs_table_column")
	table_column :: proc(rows: ^Rows, column: u32) -> rawptr ---;

	@(link_name = "ecs_filter_iter")
	filter_iter :: proc(world: ^World, filter: ^Filter) -> Filter_Iter ---;

	@(link_name = "ecs_snapshot_filter_iter")
	snapshot_filter_iter :: proc(world: ^World, snapshot: ^Snapshot, filter: ^Filter) -> Filter_Iter ---;

	@(link_name = "ecs_filter_next")
	filter_next :: proc(iter: ^Filter_Iter) -> bool ---;

	@(link_name = "ecs_enable")
	enable :: proc(world: ^World, system: u64, enabled: bool) ---;

	@(link_name = "ecs_set_period")
	set_period :: proc(world: ^World, system: u64, period: f32) ---;

	@(link_name = "ecs_is_enabled")
	is_enabled :: proc(world: ^World, system: u64) -> bool ---;

	@(link_name = "ecs_run")
	run :: proc(world: ^World, system: u64, delta_time: f32, param: rawptr) -> u64 ---;

	@(link_name = "_ecs_run_w_filter")
	run_w_filter :: proc(world: ^World, system: u64, delta_time: f32, offset: u32, limit: u32, filter: ^Vector, param: rawptr) -> u64 ---;

	@(link_name = "ecs_set_system_context")
	set_system_context :: proc(world: ^World, system: u64, ctx: rawptr) ---;

	@(link_name = "ecs_get_system_context")
	get_system_context :: proc(world: ^World, system: u64) -> rawptr ---;

	@(link_name = "ecs_set_system_status_action")
	set_system_status_action :: proc(world: ^World, system: u64, action: proc(^World, u64, System_Status, rawptr), ctx: rawptr) ---;

	@(link_name = "Snapshotake")
	snapshot_take :: proc(world: ^World, filter: ^Filter) -> ^Snapshot ---;

	@(link_name = "ecs_snapshot_restore")
	snapshot_restore :: proc(world: ^World, snapshot: ^Snapshot) ---;

	@(link_name = "ecs_snapshot_copy")
	snapshot_copy :: proc(world: ^World, snapshot: ^Snapshot, filter: ^Filter) -> ^Snapshot ---;

	@(link_name = "ecs_snapshot_free")
	snapshot_free :: proc(world: ^World, snapshot: ^Snapshot) ---;

	@(link_name = "ecs_reader_init")
	reader_init :: proc(world: ^World) -> Reader ---;

	@(link_name = "ecs_snapshot_reader_init")
	snapshot_reader_init :: proc(world: ^World, snapshot: ^Snapshot) -> Reader ---;

	@(link_name = "ecs_reader_read")
	reader_read :: proc(buffer: cstring, size: u32, reader: ^Reader) -> u32 ---;

	@(link_name = "ecs_writer_init")
	writer_init :: proc(world: ^World) -> Writer ---;

	@(link_name = "ecs_writer_write")
	writer_write :: proc(buffer: cstring, size: u32, writer: ^Writer) -> i32 ---;

	@(link_name = "_ecs_import")
	import_ :: proc(world: ^World, mod: proc(^World, i32), module_name: cstring, flags: i32, handles_out: rawptr, handles_size: u32) -> u64 ---;

	@(link_name = "ecs_import_from_library")
	import_from_library :: proc(world: ^World, library_name: cstring, module_name: cstring, flags: i32) -> u64 ---;

	@(link_name = "ecs_type_from_entity")
	type_from_entity :: proc(world: ^World, entity: u64) -> ^Vector ---;

	@(link_name = "ecs_type_to_entity")
	type_to_entity :: proc(world: ^World, typ: ^Vector) -> u64 ---;

	@(link_name = "ecs_type_add")
	type_add :: proc(world: ^World, typ: ^Vector, entity: u64) -> ^Vector ---;

	@(link_name = "ecs_type_remove")
	type_remove :: proc(world: ^World, typ: ^Vector, entity: u64) -> ^Vector ---;

	@(link_name = "ecs_type_merge")
	type_merge :: proc(world: ^World, typ: ^Vector, type_add: ^Vector, type_remove: ^Vector) -> ^Vector ---;

	@(link_name = "ecs_type_find")
	type_find :: proc(world: ^World, array: ^u64, count: u32) -> ^Vector ---;

	@(link_name = "ecs_type_get_entity")
	type_get_entity :: proc(world: ^World, typ: ^Vector, index: u32) -> u64 ---;

	@(link_name = "ecs_type_has_entity")
	type_has_entity :: proc(world: ^World, typ: ^Vector, entity: u64) -> bool ---;

	@(link_name = "ecs_expr_to_type")
	expr_to_type :: proc(world: ^World, expr: cstring) -> ^Vector ---;

	@(link_name = "ecs_type_to_expr")
	type_to_expr :: proc(world: ^World, typ: ^Vector) -> cstring ---;

	@(link_name = "ecs_type_match_w_filter")
	type_match_w_filter :: proc(world: ^World, typ: ^Vector, filter: ^Filter) -> bool ---;

	@(link_name = "ecs_type_index_of")
	type_index_of :: proc(typ: ^Vector, entity: u64) -> i16 ---;

	@(link_name = "ecs_set_threads")
	set_threads :: proc(world: ^World, threads: u32) ---;

	@(link_name = "ecs_get_threads")
	get_threads :: proc(world: ^World) -> u32 ---;

	@(link_name = "ecs_get_thread_index")
	get_thread_index :: proc(world: ^World) -> u16 ---;

	@(link_name = "ecs_merge")
	merge :: proc(world: ^World) ---;

	@(link_name = "ecs_set_automerge")
	set_automerge :: proc(world: ^World, auto_merge: bool) ---;

	@(link_name = "ecs_enable_admin")
	enable_admin :: proc(world: ^World, port: u16) -> i32 ---;

	@(link_name = "ecs_enable_console")
	enable_console :: proc(world: ^World) -> i32 ---;
}




foreign flecs_lib {
	// util/api_support
	@(link_name = "ecs_new_entity")
	new_entity :: proc(world: ^World, id: cstring, components: cstring) -> u64 ---;

	@(link_name = "ecs_new_component")
	new_component :: proc(world: ^World, id: cstring, size: u32) -> u64 ---;

	@(link_name = "ecs_new_system")
	new_system :: proc(world: ^World, id: cstring, kind: System_Kind, sig: cstring, action: proc(^Rows)) -> u64 ---;

	@(link_name = "ecs_new_type")
	new_type :: proc(world: ^World, id: cstring, components: cstring) -> u64 ---;

	@(link_name = "ecs_new_prefab")
	new_prefab :: proc(world: ^World, id: cstring, sig: cstring) -> u64 ---;

	@(link_name = "ecs_strerror")
	strerror :: proc(error_code: u32) -> cstring ---;

	@(link_name = "_ecs_abort")
	abort :: proc(error_code: u32, param: cstring, file: cstring, line: u32) ---;

	@(link_name = "_ecs_assert")
	assert :: proc(condition: bool, error_code: u32, param: cstring, condition_str: cstring, file: cstring, line: u32) ---;

	@(link_name = "_ecs_parser_error")
	parser_error :: proc(name: cstring, expr: cstring, column: i32, fmt: cstring) ---;
}



foreign flecs_lib {
	// util/chunked
	@(link_name = "_ecs_chunked_new")
	chunked_new :: proc(element_size: u32, chunk_size: u32, chunk_count: u32) -> ^Chunked ---;

	@(link_name = "ecs_chunked_free")
	chunked_free :: proc(chunked: ^Chunked) ---;

	@(link_name = "ecs_chunked_clear")
	chunked_clear :: proc(chunked: ^Chunked) ---;

	@(link_name = "_ecs_chunked_add")
	chunked_add :: proc(chunked: ^Chunked, size: u32) -> rawptr ---;

	@(link_name = "_ecs_chunked_remove")
	chunked_remove :: proc(chunked: ^Chunked, size: u32, index: u32) -> rawptr ---;

	@(link_name = "_ecs_chunked_get")
	chunked_get :: proc(chunked: ^Chunked, size: u32, index: u32) -> rawptr ---;

	@(link_name = "ecs_chunked_count")
	chunked_count :: proc(chunked: ^Chunked) -> u32 ---;

	@(link_name = "_ecs_chunked_get_sparse")
	chunked_get_sparse :: proc(chunked: ^Chunked, size: u32, index: u32) -> rawptr ---;

	@(link_name = "ecs_chunked_indices")
	chunked_indices :: proc(chunked: ^Chunked) -> ^u32 ---;

	@(link_name = "ecs_chunked_copy")
	chunked_copy :: proc(src: ^Chunked) -> ^Chunked ---;

	@(link_name = "ecs_chunked_memory")
	chunked_memory :: proc(chunked: ^Chunked, allocd: ^u32, used: ^u32) ---;
}


foreign flecs_lib {
	// util/map
	@(link_name = "ecs_map_new")
	map_new :: proc(size: u32, elem_size: u32) -> ^Map ---;

	@(link_name = "ecs_map_free")
	map_free :: proc(mappy: ^Map) ---;

	@(link_name = "ecs_map_memory")
	map_memory :: proc(mappy: ^Map, total: ^u32, used: ^u32) ---;

	@(link_name = "ecs_map_count")
	map_count :: proc(mappy: ^Map) -> u32 ---;

	@(link_name = "ecs_map_set_size")
	map_set_size :: proc(mappy: ^Map, size: u32) -> u32 ---;

	@(link_name = "ecs_map_data_size")
	map_data_size :: proc(mappy: ^Map) -> u32 ---;

	@(link_name = "ecs_map_grow")
	map_grow :: proc(mappy: ^Map, size: u32) -> u32 ---;

	@(link_name = "ecs_map_bucket_count")
	map_bucket_count :: proc(mappy: ^Map) -> u32 ---;

	@(link_name = "ecs_map_clear")
	map_clear :: proc(mappy: ^Map) ---;

	@(link_name = "_ecs_map_set")
	map_set :: proc(mappy: ^Map, key_hash: u64, data: rawptr, size: u32) -> rawptr ---;

	@(link_name = "_ecs_map_has")
	map_has :: proc(mappy: ^Map, key_hash: u64, value_out: rawptr, size: u32) -> bool ---;

	@(link_name = "ecs_map_get_ptr")
	map_get_ptr :: proc(mappy: ^Map, key_hash: u64) -> rawptr ---;

	@(link_name = "ecs_map_remove")
	map_remove :: proc(mappy: ^Map, key_hash: u64) -> i32 ---;

	@(link_name = "ecs_map_copy")
	map_copy :: proc(mappy: ^Map) -> ^Map ---;

	@(link_name = "ecs_map_iter")
	map_iter :: proc(mappy: ^Map) -> Map_Iter ---;

	@(link_name = "ecs_map_hasnext")
	map_hasnext :: proc(it: ^Map_Iter) -> bool ---;

	@(link_name = "ecs_map_next")
	map_next :: proc(it: ^Map_Iter) -> rawptr ---;

	@(link_name = "ecs_map_next_w_size")
	map_next_w_size :: proc(it: ^Map_Iter, size: u32) -> rawptr ---;

	@(link_name = "ecs_map_next_w_key")
	map_next_w_key :: proc(it: ^Map_Iter, key_out: ^u64) -> rawptr ---;

	@(link_name = "ecs_map_next_w_key_w_size")
	map_next_w_key_w_size :: proc(it: ^Map_Iter, key_out: ^u64, size: u32) -> rawptr ---;

	// util/stats
	@(link_name = "FlecsStatsImport")
	flecs_stats_import :: proc(world: ^World, flags: i32) ---;
}
