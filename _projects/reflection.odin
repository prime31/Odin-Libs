package main

import "core:fmt"
import "core:runtime";
import "shared:engine/libs/fna"
import "shared:engine/gfx"

Vertex :: struct {
	pos: [2]f32,
	uv: [2]f32,
	col: u32
};

main :: proc() {
	// vert_decl := gfx.vertex_decl_for_type(gfx.Vert_Pos_Col, .Position, .Color);
	vert_decl := gfx.vertex_decl_for_type(gfx.Vert_Pos_Col);
	fmt.println("v_dcl", vert_decl);

	buff := gfx.new_vert_buffer(vert_decl, 4);
	buff2 := gfx.new_vert_buffer(gfx.Vert_Pos_Col, 4);
	fmt.println(buff, buff2);


	vertices := [?]Vertex{
		{{+0.5, -0.5}, {1.0, 1.0}, 0xFF0099FF},
		{{-0.5, -0.5}, {0.0, 1.0}, 0xFFFFFFFF},
		{{-0.5, +0.5}, {0.0, 0.0}, 0xFFFFFFFF},
		{{+0.5, +0.5}, {1.0, 0.0}, 0xFFFF99FF}
	};

	gfx.set_vertex_buffer_data(buff, &vertices);

	indices := [?]i16{0, 1, 2, 2, 3, 0};
	gfx.set_index_buffer_data(buff2, &indices);
}


