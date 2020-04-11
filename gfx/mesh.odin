package gfx

import "shared:engine/libs/fna"

Mesh :: struct {
	index_buffer: ^fna.Buffer,
	vert_buffer: ^fna.Buffer,
	vert_buffer_binding: fna.Vertex_Buffer_Binding
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
	//(device: ^Device, primitive_type: Primitive_Type, base_vertex: i32, min_vertex_index: i32, num_vertices: i32, start_index: i32, primitive_count: i32, indices: ^Buffer, index_element_size: Index_Element_Size) ---;
}
