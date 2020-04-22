package gfx

import "shared:engine/libs/fna"
import "shared:engine/maf"
import "core:fmt"

Batcher :: struct {
	mesh: ^Dynamic_Mesh(Vertex),
	shader: ^Shader,
	draw_calls: [dynamic]Draw_Call,
	draw_call_index: int,

	vert_index: i32,	// current index into the vertex array
	vert_count: i32,	// total verts that we have not yet rendered
	buffer_offset: i32,	// offset into the vertex buffer of the first non-rendered vert
	discard_next: bool	// flag for dealing with the Metal issue where we have to discard our buffer 2 times
}

@(private)
Draw_Call :: struct {
	texture: ^fna.Texture,
	vert_count: i32
}


new_batcher :: proc(max_sprites: i32 = 1024) -> ^Batcher {
	batcher := new(Batcher);
	batcher.mesh = new_dynamic_mesh(Vertex, max_sprites * 4, max_sprites * 6);
	batcher.shader = new_shader("effects/SpriteEffect.fxb");
	batcher.draw_calls = make([dynamic]Draw_Call, 10);

	indices := make([]i16, max_sprites * 6, context.temp_allocator);
	for i in 0..<max_sprites {
		indices[i * 3 * 2 + 0] = i16(i) * 4 + 0;
		indices[i * 3 * 2 + 1] = i16(i) * 4 + 1;
		indices[i * 3 * 2 + 2] = i16(i) * 4 + 2;
		indices[i * 3 * 2 + 3] = i16(i) * 4 + 0;
		indices[i * 3 * 2 + 4] = i16(i) * 4 + 2;
		indices[i * 3 * 2 + 5] = i16(i) * 4 + 3;
	}

	set_index_buffer_data(batcher.mesh.index_buffer, &indices, 0);

	return batcher;
}

free_batcher :: proc(batcher: ^Batcher) {
	free_dynamic_mesh(batcher.mesh);
	delete(batcher.draw_calls);
	free(batcher);
}

// called at the end of the frame when all drawing is complete. Flushes the batch and resets local state.
batcher_end_frame :: proc(batcher: ^Batcher) {
	batcher_flush(batcher);
	batcher.vert_index = 0;
	batcher.vert_count = 0;
	batcher.buffer_offset = 0;
}

batcher_flush :: proc(batcher: ^Batcher, discard_buffer: bool = false) {
	if batcher.vert_count == 0 do return;

	// if we ran out of space and dont support no_overwrite we have to discard the buffer
	// TODO: we can lose data on Metal with No_Overwrite. FNA3D bug or our bug?
	options: fna.Set_Data_Options = discard_buffer || batcher.discard_next || fna.supports_no_overwrite(fna_device) == 0 ? .Discard : .No_Overwrite;
	batcher.discard_next = false;

	dynamic_mesh_append_vert_slice(batcher.mesh, batcher.buffer_offset, batcher.vert_count, options);


	// TODO: move this out of the batcher
	transform := maf.mat32_ortho(cast(f32)viewport.w, cast(f32)viewport.h);
	shader_set_mat32(batcher.shader, "TransformMatrix", &transform);
	shader_apply(batcher.shader);


	// run through all our accumulated draw calls
	for i in 0..batcher.draw_call_index {
		texture_bind(batcher.draw_calls[i].texture);
		dynamic_mesh_draw(batcher.mesh, batcher.buffer_offset, batcher.draw_calls[i].vert_count);

		batcher.buffer_offset += batcher.draw_calls[i].vert_count;
		batcher.draw_calls[i].texture = nil;
	}

	batcher.draw_call_index = -1;
	batcher.vert_count = 0;
}

// ensures the vert buffer has enough space and manages the draw call command buffer when textures change
@(private)
batcher_ensure_capacity :: proc(batcher: ^Batcher, texture: ^fna.Texture, count: i32 = 4) {
	// if we run out of buffer we have to flush the batch and possibly discard the whole buffer
	if batcher.vert_index + count > cast(i32)len(batcher.mesh.verts) {
		if batcher.draw_call_index < 0 do dynamic_mesh_append_vert_slice(batcher.mesh, 0, 1, .Discard);
		else do batcher_flush(batcher, true);

		// we have to discard two frames for metal else we lose draws for some reason...
		if fna.supports_no_overwrite(fna_device) == 1 do batcher.discard_next = true;
		batcher.vert_index = 0;
		batcher.vert_count = 0;
		batcher.buffer_offset = 0;
	}

	// start a new draw call if we dont already have one going or whenever the texture changes
	if batcher.draw_call_index < 0 || batcher.draw_calls[batcher.draw_call_index].texture != texture {
		// expand our command buffer size if needed
		if batcher.draw_call_index + 1 == len(batcher.draw_calls) {
			append(&batcher.draw_calls, Draw_Call{});
		}
		batcher.draw_call_index += 1;
		batcher.draw_calls[batcher.draw_call_index].texture = texture;
		batcher.draw_calls[batcher.draw_call_index].vert_count = 0;
	}
}

@(private)
batcher_draw :: proc(batcher: ^Batcher, texture: ^fna.Texture, quad: ^maf.Quad, mat: ^maf.Mat32, color: maf.Color = maf.COL_WHITE) {
	batcher_ensure_capacity(batcher, texture);

	// copy the quad positions, uvs and color into vertex array transforming them with the matrix as we do it
	maf.mat32_transform_quad(mat, batcher.mesh.verts[batcher.vert_index:batcher.vert_index+4], quad, color);

	batcher.draw_calls[batcher.draw_call_index].vert_count += 4;
	batcher.vert_count += 4;
	batcher.vert_index += 4;
}
