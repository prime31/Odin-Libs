package flecs

// TODO: should the `int`s be `i32`s?

World :: struct {}

Rows :: struct {
	world: ^World,
	system: u64,
	columns: ^int,
	column_count: u16,
	table: rawptr,
	table_columns: rawptr,
	system_data: rawptr,
	references: ^Reference,
	components: ^u64,
	entities: ^u64,
	param: rawptr,
	delta_time: f32,
	world_time: f32,
	frame_offset: u32,
	table_offset: u32,
	offset: u32,
	count: u32,
	interrupted_by: u64
}

Reference :: struct {}

Snapshot :: struct {}

// util/os_api

Time :: struct {
	sec: int,
	nanosec: u32,
}

Os_Api :: struct {
	malloc: proc(u32) -> rawptr,
	realloc: proc(rawptr, u32) -> rawptr,
	calloc: proc(u32, u32) -> rawptr,
	free: proc(rawptr),
	strdup: proc(cstring) -> cstring,
	thread_new: rawptr /* proc(proc(rawptr) -> rawptr, rawptr) -> u32 */,
	thread_join: proc(u32) -> rawptr,
	mutex_new: proc() -> u32,
	mutex_free: proc(u32),
	mutex_lock: proc(u32),
	mutex_unlock: proc(u32),
	cond_new: proc() -> u32,
	cond_free: proc(u32),
	cond_signal: proc(u32),
	cond_broadcast: proc(u32),
	cond_wait: proc(u32, u32),
	sleep: proc(u32, u32),
	get_time: proc(^Time),
	log: proc(cstring, rawptr /* ...rawptr */),
	log_error: proc(cstring, rawptr /* ...rawptr */),
	log_debug: proc(cstring, rawptr /* ...rawptr */),
	log_warning: proc(cstring, rawptr /* ...rawptr */),
	abort: proc(),
	dlopen: proc(cstring) -> u32,
	dlproc: rawptr /* proc(u32, cstring) -> proc() */,
	dlclose: proc(u32),
	module_to_dl: proc(cstring) -> cstring,
}


// util/vector

Vector :: struct {
}

Vector_Params :: struct {
	move_action: proc(^Vector, ^Vector_Params, rawptr, rawptr, rawptr),
	move_ctx: rawptr,
	ctx: rawptr,
	element_size: u32,
}


// include/flecs

System_Kind :: enum i32 {
	On_Load,
	Post_Load,
	Pre_Update,
	On_Update,
	On_Validate,
	Post_Update,
	Pre_Store,
	On_Store,
	Manual,
	On_Add,
	On_Remove,
	On_Set,
}

Match_Kind :: enum i32 {
	Default = 0,
	All = 1,
	Any = 2,
	Exact = 3,
}

System_Status :: enum i32 {
	Status_None = 0,
	Enabled = 1,
	Disabled = 2,
	Activated = 3,
	Deactivated = 4,
}

Component :: struct {
	size: u32,
}

Type_Component :: struct {
	type: ^Vector,
	resolved: ^Vector,
}

Prefab :: struct {
	parent: u64,
}

Table_Data :: struct {
	row_count: u32,
	column_count: u32,
	entities: ^u64,
	components: ^u64,
	columns: ^rawptr,
}

Filter_Iter :: struct {
	filter: Filter,
	tables: ^Chunked,
	index: u32,
	rows: Rows,
}


// util/api_support

Blob_Header_Kind :: enum i32 {
	Stream_Header,
	Component_Segment,
	Table_Segment,
	Footer_Segment,
	Component_Header,
	Component_Id,
	Component_Size,
	Component_Name_Length,
	Component_Name,
	Table_Header,
	Table_Type_Size,
	Table_Type,
	Table_Size,
	Table_Column,
	Table_Column_Header,
	Table_Column_Size,
	Table_Column_Data,
	Table_Column_Name_Header,
	Table_Column_Name_Length,
	Table_Column_Name,
	Stream_Footer,
}

Filter :: struct {
	include: ^Vector,
	exclude: ^Vector,
	include_kind: Match_Kind,
	exclude_kind: Match_Kind,
}

Table :: struct {}

Table_Column :: struct {}

Component_Reader :: struct {
	state: Blob_Header_Kind,
	id_column: ^u64,
	data_column: ^Component,
	name_column: ^cstring,
	index: int,
	count: int,
	name: cstring,
	len: u32,
	written: u32,
}

Table_Reader :: struct {
	state: Blob_Header_Kind,
	table_index: u32,
	table: ^Table,
	columns: ^Table_Column,
	type_written: int,
	type: ^Vector,
	column: ^Table_Column,
	column_index: int,
	total_columns: int,
	column_data: rawptr,
	column_size: u32,
	column_written: u32,
	row_index: int,
	row_count: u32,
	name: cstring,
	name_len: u32,
	name_written: u32,
}

Reader :: struct {
	world: ^World,
	state: Blob_Header_Kind,
	tables: ^Chunked,
	component: Component_Reader,
	table: Table_Reader,
}

Name_Writer :: struct {
	name: cstring,
	written: int,
	len: int,
	max_len: int,
}

Component_Writer :: struct {
	state: Blob_Header_Kind,
	id: int,
	size: u32,
	name: Name_Writer,
}

Table_Writer :: struct {
	state: Blob_Header_Kind,
	table: ^Table,
	column: ^Table_Column,
	type_count: u32,
	type_max_count: u32,
	type_written: u32,
	type_array: ^u64,
	column_index: u32,
	column_size: u32,
	column_written: u32,
	column_data: rawptr,
	row_count: u32,
	row_index: int,
	name: Name_Writer,
}

Writer :: struct {
	world: ^World,
	state: Blob_Header_Kind,
	component: Component_Writer,
	table: Table_Writer,
	error: i32,
}


// util/chunked

Chunked :: struct {}


// util/map

Map :: struct {}

Map_Iter :: struct {
	mmap: ^Map,
	bucket_index: u32,
	node: u32,
}


// util/stats

Memory_Stat :: struct {
	allocd_bytes: u32,
	used_bytes: u32,
}

Alloc_Stats :: struct {
	malloc_count_total: u64,
	realloc_count_total: u64,
	calloc_count_total: u64,
	free_count_total: u64,
}

Row_System_Memory_Stats :: struct {
	base_memory_bytes: u32,
	columns_memory: Memory_Stat,
	components_memory: Memory_Stat,
}

Col_System_Memory_Stats :: struct {
	base_memory_bytes: u32,
	columns_memory: Memory_Stat,
	active_tables_memory: Memory_Stat,
	inactive_tables_memory: Memory_Stat,
	jobs_memory: Memory_Stat,
	other_memory_bytes: u32,
}

Memory_Stats :: struct {
	__dummy: u32,
	total_memory: Memory_Stat,
	entities_memory: Memory_Stat,
	components_memory: Memory_Stat,
	systems_memory: Memory_Stat,
	types_memory: Memory_Stat,
	tables_memory: Memory_Stat,
	stages_memory: Memory_Stat,
	world_memory: Memory_Stat,
}

Component_Stats :: struct {
	entity: u64,
	name: cstring,
	size_bytes: u16,
	memory: Memory_Stat,
	entities_count: u32,
	tables_count: u32,
}

System_Stats :: struct {
	entity: u64,
	name: cstring,
	signature: cstring,
	kind: System_Kind,
	period_seconds: f32,
	tables_matched_count: u32,
	entities_matched_count: u32,
	invoke_count_total: u64,
	seconds_total: f32,
	is_enabled: bool,
	is_active: bool,
	is_hidden: bool,
}

Type_Stats :: struct {
	entity: u64,
	name: cstring,
	type: ^Vector,
	normalized_type: ^Vector,
	entities_count: u32,
	entities_childof_count: u32,
	entities_instanceof_count: u32,
	components_count: u32,
	col_systems_count: u32,
	row_systems_count: u32,
	enabled_systems_count: u32,
	active_systems_count: u32,
	instance_count: u32,
	is_hidden: bool,
}

Table_Stats :: struct {
	type: ^Vector,
	columns_count: u32,
	rows_count: u32,
	systems_matched_count: u32,
	entity_memory: Memory_Stat,
	component_memory: Memory_Stat,
	other_memory_bytes: u32,
}

World_Stats :: struct {
	target_fps_hz: f64,
	tables_count: u32,
	components_count: u32,
	col_systems_count: u32,
	row_systems_count: u32,
	inactive_systems_count: u32,
	entities_count: u32,
	threads_count: u32,
	frame_count_total: u32,
	frame_seconds_total: f64,
	system_seconds_total: f64,
	merge_seconds_total: f64,
	world_seconds_total: f64,
	fps_hz: f64,
}

Flecs_Stats :: struct {
	EEcsAllocStats: u64,
	TEcsAllocStats: ^Vector,
	EEcsWorldStats: u64,
	TEcsWorldStats: ^Vector,
	EEcsMemoryStats: u64,
	TEcsMemoryStats: ^Vector,
	EEcsSystemStats: u64,
	TEcsSystemStats: ^Vector,
	EEcsColSystemMemoryStats: u64,
	TEcsColSystemMemoryStats: ^Vector,
	EEcsRowSystemMemoryStats: u64,
	TEcsRowSystemMemoryStats: ^Vector,
	EEcsComponentStats: u64,
	TEcsComponentStats: ^Vector,
	EEcsTableStats: u64,
	TEcsTableStats: ^Vector,
	EEcsTablePtr: u64,
	TEcsTablePtr: ^Vector,
	EEcsTypeStats: u64,
	TEcsTypeStats: ^Vector,
}
