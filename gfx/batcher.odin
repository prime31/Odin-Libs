package gfx

import "shared:engine/libs/fna"
import "shared:engine/maf"
import "core:fmt"

Batcher :: struct {
	mesh: ^Dynamic_Mesh(Vertex),
	shader: ^Shader,
	draw_calls: [dynamic]Draw_Call,
	draw_call_index: int,

	quad_cnt: i32,
	last_appended_quad_cnt: i32
}

@(private)
Draw_Call :: struct {
	texture: ^fna.Texture,
	vert_count: i32
}


new_batcher :: proc(sprite_cnt: i32 = 1024) -> ^Batcher {
	batcher := new(Batcher);
	batcher.mesh = new_dynamic_mesh(Vertex, sprite_cnt * 4, sprite_cnt * 6, true);
	batcher.shader = new_shader("effects/SpriteEffect.fxb");
	batcher.draw_calls = make([dynamic]Draw_Call, 10);

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
	delete(batcher.draw_calls);
	free(batcher);
}

// called at the end of the frame when all drawing is complete. Flushes the batch and resets local state.
batcher_end :: proc(batcher: ^Batcher) {
	batcher_flush(batcher);
	batcher.quad_cnt = 0;
	batcher.last_appended_quad_cnt = 0;
}

batcher_flush :: proc(batcher: ^Batcher) {
	if batcher.draw_call_index < 0 do return;

	total_quads := batcher.quad_cnt - batcher.last_appended_quad_cnt;
	if total_quads == 0 do return;

	total_verts := total_quads * 4;
	base_vertex := batcher.last_appended_quad_cnt * 4;
	dynamic_mesh_append_vert_slice(batcher.mesh, base_vertex, batcher.quad_cnt * 4, .None);

	batcher.last_appended_quad_cnt = batcher.quad_cnt;


	// TODO: move this out of the batcher
	transform := maf.mat32_ortho(cast(f32)viewport.w, cast(f32)viewport.h);
	shader_set_mat32(batcher.shader, "TransformMatrix", &transform);
	shader_apply(batcher.shader);


	// run through all our accumulated draw calls
	for i in 0..batcher.draw_call_index {
		texture_bind(batcher.draw_calls[i].texture);
		dynamic_mesh_draw(batcher.mesh, base_vertex, batcher.draw_calls[i].vert_count);

		base_vertex += batcher.draw_calls[i].vert_count;
		batcher.draw_calls[i].texture = nil;
	}

	batcher.draw_call_index = -1;
}

batcher_draw_tex :: proc(batcher: ^Batcher, texture: Texture, x, y: f32) {
	// start a new draw call if we dont already have one going or whenever the texture changes
	if batcher.draw_call_index < 0 || batcher.draw_calls[batcher.draw_call_index].texture != texture.texture {
		// expand our command buffer size if needed
		if batcher.draw_call_index + 1 == len(batcher.draw_calls) {
			append(&batcher.draw_calls, Draw_Call{});
		}
		batcher.draw_call_index += 1;
		batcher.draw_calls[batcher.draw_call_index].texture = texture;
		batcher.draw_calls[batcher.draw_call_index].vert_count = 0;
	}

	batcher.draw_calls[batcher.draw_call_index].vert_count += 4;

	// TODO: need to maintain a per-frame tally of the current base_vert that is updated after
	// each flush then reset to 0 in batcher_end. We need this because we can flush more than once
	// per frame in the case of our verts being full. We have to do a discard when we flush because of that.

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
