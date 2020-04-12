package main

import "core:os"
import "core:fmt"
import "core:mem"
import "core:math"
import "core:math/linalg"
import "shared:engine"
import "shared:engine/gfx"
import "shared:engine/maf"
import "shared:engine/libs/sdl"
import "shared:engine/libs/fna"
import "shared:engine/libs/imgui"


vert_decl: fna.Vertex_Declaration;
shader: ^gfx.Shader;
ibuff: ^fna.Buffer;
texture: ^fna.Texture;
quad_shader: ^gfx.Shader;
vert_buff_binding: fna.Vertex_Buffer_Binding;
mesh: ^gfx.Mesh;
t:f32 = 0;

main :: proc() {
	engine.run(init, update, render);
}

init :: proc() {
	quad_prepper();
}

update :: proc() {
	imgui.im_text("whatever");
	imgui.drag_float("Thing", &t);
	imgui.bullet();
	if imgui.button("Im a Button") do fmt.println("-------------- buttton");
	imgui.im_text("whatever");
	imgui.bullet();
	imgui.im_text("whatever");
}

render :: proc() {
	draw_quad();
}


draw_quad :: proc() {
	sampler_state := fna.Sampler_State{
		address_u = .Wrap,
		address_v = .Wrap,
		address_w = .Wrap,
		filter = .Point,
		max_anisotropy = 4
	};
	fna.verify_sampler(gfx.fna_device, 0, texture, &sampler_state);
	gfx.shader_apply(quad_shader);

	fna.apply_vertex_buffer_bindings(gfx.fna_device, &vert_buff_binding, 1, 0, 0);
	fna.draw_indexed_primitives(gfx.fna_device, .Triangle_List, 0, 0, 4, 0, 2, ibuff, ._16_Bit);

	gfx.mesh_draw(mesh, 4);
}

quad_prepper :: proc() {
	create_texture();
	vert_decl := gfx.vertex_decl_for_type(gfx.Vert_Pos_Tex_Col);

	// buffers
	vertices := [?]gfx.Vert_Pos_Tex_Col{
		{{220, 	20}, {1.0, 0.0}, 0xFF0099FF},
		{{20, 	20}, {0.0, 0.0}, 0xFFFFFFFF},
		{{20, 	220}, {0.0, 1.0}, 0xFFFFFFFF},
		{{220, 	220}, {1.0, 1.0}, 0xFFFF99FF}
	};

	vbuff := gfx.new_vert_buffer_from_type(gfx.Vert_Pos_Tex_Col, len(vertices));
	gfx.set_vertex_buffer_data(vbuff, &vertices);

	indices := [?]i16{0, 1, 2, 2, 3, 0};
	ibuff = gfx.new_index_buffer(len(indices));
	gfx.set_index_buffer_data(ibuff, &indices);

	// bindings
	vert_buff_binding = fna.Vertex_Buffer_Binding{vbuff, vert_decl, 0, 0};

	// load an effect
	quad_shader = gfx.new_shader("effects/VertexColorTexture.fxb");
	transform := maf.mat32_ortho(640, 480);
	gfx.shader_set_mat32(quad_shader, "TransformMatrix", &transform);


	// mesh
	for v, i in vertices {
		vertices[i].pos.x += 300;
		vertices[i].pos.y += 200;
	}

	mesh = gfx.new_mesh(gfx.Vert_Pos_Tex_Col, 4, 6);
	gfx.set_vertex_buffer_data(mesh.vert_buffer, &vertices);
	gfx.set_index_buffer_data(mesh.index_buffer, &indices);
}

create_texture :: proc() {
	pixels := [?]u32 {0xFFFFFFFF, 0xFF000000, 0xFFFFFFFF, 0xFF000000,
		0xFF000000, 0xFFFFFFFF, 0xFF000000, 0xFFFFFFFF,
		0xFFFFFFFF, 0xFF000000, 0xFFFFFFFF, 0xFF000000,
		0xFF000000, 0xFFFFFFFF, 0xFF000000, 0xFFFFFFFF};

	texture = fna.create_texture_2d(gfx.fna_device, .Color, 4, 4, 1, 0);
	fna.set_texture_data_2d(gfx.fna_device, texture, .Color, 0, 0, 4, 4, 0, &pixels, size_of(pixels));

	sampler_state := fna.Sampler_State{
		filter = .Point,
		max_anisotropy = 4
	};

	fna.verify_sampler(gfx.fna_device, 0, texture, &sampler_state);
}
