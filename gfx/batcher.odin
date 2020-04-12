package gfx

import "shared:engine/libs/fna"
import "shared:engine/maf"
import "core:fmt"

Batcher :: struct {
	mesh: ^Dynamic_Mesh(Vert_Pos_Tex_Col),
	shader: ^Shader,
	last_tex: ^fna.Texture,
	quad_cnt: i32,
	last_appended_quad_cnt: i32,
	vbuff_offset: i32
}

new_batcher :: proc(sprite_cnt: i32 = 1024) -> ^Batcher {
	batcher := new(Batcher);
	batcher.mesh = new_dynamic_mesh(Vert_Pos_Tex_Col, sprite_cnt * 4, sprite_cnt * 6, true);
	batcher.shader = new_shader("effects/VertexColorTexture.fxb");

	for i in 0..<sprite_cnt {
		// TODO: make this: 0, 1, 2, 0, 2, 3 and match vert assignment below
		batcher.mesh.indices[i * 3 * 2 + 0] = i16(i) * 4 + 0;
		batcher.mesh.indices[i * 3 * 2 + 1] = i16(i) * 4 + 1;
		batcher.mesh.indices[i * 3 * 2 + 2] = i16(i) * 4 + 2;
		batcher.mesh.indices[i * 3 * 2 + 3] = i16(i) * 4 + 2;
		batcher.mesh.indices[i * 3 * 2 + 4] = i16(i) * 4 + 3;
		batcher.mesh.indices[i * 3 * 2 + 5] = i16(i) * 4 + 0;
	}

	dynamic_mesh_update_indices(batcher.mesh);

	return batcher;
}

free_batcher :: proc(batcher: ^Batcher) {
	free_dynamic_mesh(batcher.mesh);
	free(batcher);
}

batcher_end :: proc(batcher: ^Batcher) {
	batcher_flush(batcher);
	batcher.last_tex = nil;
	batcher.quad_cnt = 0;
	batcher.last_appended_quad_cnt = 0;
	batcher.vbuff_offset = 0;
}

batcher_flush :: proc(batcher: ^Batcher) {
	total_quads := batcher.quad_cnt - batcher.last_appended_quad_cnt;
	if total_quads == 0 do return;

	// TODO: move this to Dynamic_Mesh with an append
	total_verts := total_quads * 4;
	base_vertex := batcher.last_appended_quad_cnt * 4;
	verts := batcher.mesh.verts[base_vertex:batcher.quad_cnt * 4];
	set_vertex_buffer_data(batcher.mesh.vert_buffer, &verts, batcher.vbuff_offset);

	batcher.last_appended_quad_cnt = batcher.quad_cnt;
	batcher.vbuff_offset += i32(len(verts) * size_of(Vert_Pos_Tex_Col));

	transform := maf.mat32_ortho(640, 480);
	shader_set_mat32(batcher.shader, "TransformMatrix", &transform);
	shader_apply(batcher.shader);

	dynamic_mesh_draw(batcher.mesh, base_vertex, total_verts);
}

batcher_draw_tex :: proc(batcher: ^Batcher, texture: Texture, x, y: f32) {
	// TODO: only flush if we actually run out of verts so that we upload verts only once.
	// this will require storing the texture for each quad.
	if batcher.last_tex != texture.texture {
		batcher_flush(batcher);
		batcher.last_tex = texture;
		texture_bind(texture);
	}

	base_vert := batcher.quad_cnt * 4;
	batcher.quad_cnt += 1;

	batcher.mesh.verts[base_vert + 0].pos = {x + cast(f32)texture.width, y};
	batcher.mesh.verts[base_vert + 0].uv = {1, 0};
	batcher.mesh.verts[base_vert + 0].col = 0xFFFFFFFF;

	batcher.mesh.verts[base_vert + 1].pos = {x, y};
	batcher.mesh.verts[base_vert + 1].uv = {0, 0};
	batcher.mesh.verts[base_vert + 1].col = 0xFFFFFFFF;

	batcher.mesh.verts[base_vert + 2].pos = {x, y + cast(f32)texture.height};
	batcher.mesh.verts[base_vert + 2].uv = {0, 1};
	batcher.mesh.verts[base_vert + 2].col = 0xFFFFFFFF;

	batcher.mesh.verts[base_vert + 3].pos = {x + cast(f32)texture.width, y + cast(f32)texture.height};
	batcher.mesh.verts[base_vert + 3].uv = {1, 1};
	batcher.mesh.verts[base_vert + 3].col = 0xFFFFFFFF;
}
