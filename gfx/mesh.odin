package gfx

import "core:fmt"
import "core:intrinsics"
import "shared:engine/libs/fna"

Mesh :: struct {
	index_buffer: ^fna.Buffer,
	vert_buffer: ^fna.Buffer,
	vert_buffer_binding: fna.Vertex_Buffer_Binding
}

// used with constantly changing verts/indices. Stores the verts/indices internally and manages partial buffer
// uploads for ease of use.
Dynamic_Mesh :: struct(T: typeid) {
	using mesh: Mesh,
	verts: []T,
	indices: []i16
}


new_mesh :: proc(vertex_type: typeid, vertex_count: i32, index_count: i32, vert_buffer_dynamic: bool = false, index_buffer_dynamic: bool = false) -> ^Mesh {
	mesh := new(Mesh);

	mesh.index_buffer = new_index_buffer(index_count, index_buffer_dynamic);
	mesh.vert_buffer = new_vert_buffer_from_type(vertex_type, vertex_count, vert_buffer_dynamic);
	mesh.vert_buffer_binding = fna.Vertex_Buffer_Binding{mesh.vert_buffer, vertex_decl_for_type(vertex_type), 0, 0};

	return mesh;
}

free_mesh :: proc(mesh: ^Mesh) {
	free_vert_buffer(mesh.vert_buffer_binding.vertex_buffer);
	free_index_buffer(mesh.index_buffer);
	free(mesh);
}

mesh_draw :: proc(mesh: ^Mesh, num_vertices: i32) {
	primitive_count := num_vertices / 2; // assuming Triangle_List
	fna.apply_vertex_buffer_bindings(fna_device, &mesh.vert_buffer_binding, 1, 0, 0); // last 2 params: bindings_updated: u8, base_vertex: i32
	fna.draw_indexed_primitives(fna_device, .Triangle_List, 0, 0, num_vertices, 0, primitive_count, mesh.index_buffer, ._16_Bit);
}



new_dynamicmesh :: proc($T: typeid, vertex_count: i32, index_count: i32, index_buffer_dynamic: bool = false) -> ^Dynamic_Mesh(T) {
	mesh := new(Dynamic_Mesh(T));

	// only create the index buffer if it is dynamic
	if index_buffer_dynamic do mesh.indices = make([]i16, index_count);

	mesh.verts = make([]T, vertex_count);
	mesh.index_buffer = new_index_buffer(index_count, index_buffer_dynamic);
	mesh.vert_buffer = new_vert_buffer_from_type(T, vertex_count, true);
	mesh.vert_buffer_binding = fna.Vertex_Buffer_Binding{mesh.vert_buffer, vertex_decl_for_type(T), 0, 0};

	return mesh;
}

free_dynamicmesh :: proc(mesh: ^$T/Dynamic_Mesh) {
	if mesh.indices != nil do delete(mesh.indices);
	delete(mesh.verts);
	free_vert_buffer(mesh.vert_buffer_binding.vertex_buffer);
	free_index_buffer(mesh.index_buffer);
	free(mesh);
}

// Try not to use .None for dynamic vert buffers
dynamicmesh_update_all_verts :: proc(mesh: ^$T/Dynamic_Mesh, options: fna.Set_Data_Options = .None) {
	set_vertex_buffer_data(mesh.vert_buffer, &mesh.verts, 0, options);
}

// uploads to the GPU the slice from start to end
dynamicmesh_append_vert_slice :: proc(mesh: ^$T/Dynamic_Mesh, start_index: i32, num_verts: i32, options: fna.Set_Data_Options = .None) {
	// cheat a bit here and use the Vertex_Buffer_Binding data to get the element size of our verts
	offset_in_bytes := start_index * mesh.vert_buffer_binding.vertex_declaration.vertex_stride;
	verts := mesh.verts[start_index:start_index + num_verts];

	set_vertex_buffer_data(mesh.vert_buffer, &verts, offset_in_bytes, options);
}

dynamicmesh_update_indices :: proc(mesh: ^$T/Dynamic_Mesh, offset_in_bytes: i32 = 0) {
	assert(mesh.indices != nil);
	set_index_buffer_data(mesh.index_buffer, &mesh.indices, offset_in_bytes);
}

dynamicmesh_draw :: proc(mesh: ^$T/Dynamic_Mesh, base_vertex: i32 = 0, num_vertices: i32 = 0) {
	num_vertices := num_vertices == 0 ? cast(i32)len(mesh.verts) : num_vertices;
	primitive_count := num_vertices / 2; // assuming Triangle_List
	fna.apply_vertex_buffer_bindings(fna_device, &mesh.vert_buffer_binding, 1, 0, base_vertex); // last 2 params: bindings_updated: u8, base_vertex: i32
	fna.draw_indexed_primitives(fna_device, .Triangle_List, base_vertex, 0, num_vertices, 0, primitive_count, mesh.index_buffer, ._16_Bit);
}

