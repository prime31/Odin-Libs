package flecs

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

System_Kind :: enum {
	on_load,
	post_load,
	pre_update,
	on_update,
	on_validate,
	post_update,
	pre_store,
	on_store,
	manual,
	on_add,
	on_remove,
	on_set
}