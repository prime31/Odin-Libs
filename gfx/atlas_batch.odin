package gfx

import "core:fmt"
import "shared:engine/libs/fna"
import "shared:engine/maf"

Atlas_Batch :: struct {
	mesh: ^Dynamic_Mesh(Vertex),
	sprite_count: i32,
	max_sprites: i32,
	texture: Texture,
	buffer_dirty: bool
}

new_atlasbatch :: proc(texture: Texture, max_sprites: i32 = 256) -> ^Atlas_Batch {
	batcher := new(Atlas_Batch);
	batcher.mesh = new_dynamicmesh(Vertex, max_sprites * 4, max_sprites * 6);
	batcher.max_sprites = max_sprites;
	batcher.texture = texture;

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

free_atlasbatch :: proc(batch: ^Atlas_Batch) {
	free_dynamicmesh(batch.mesh);
	free(batch);
}

@(private)
atlasbatch_ensure_capacity :: proc(batch: ^Atlas_Batch) -> bool {
	if batch.sprite_count == batch.max_sprites {
		fmt.eprint("atlas batch full!");
		return false;
	}
	return true;
}

atlasbatch_set :: proc(batch: ^Atlas_Batch, index: i32, quad: ^maf.Quad, mat: ^maf.Mat32, color: maf.Color = maf.COL_WHITE) {
	// copy the quad positions, uvs and color into vertex array transforming them with the matrix as we do it
	vert_index := index * 4;

	mat := mat;
	if mat == nil {
		matrix := maf.MAT32_IDENTITY;
		mat = &matrix;
	}

	maf.mat32_transform_quad(mat, batch.mesh.verts[vert_index:vert_index + 4], quad, color);
	batch.buffer_dirty = true;
}

atlasbatch_set_viewport :: proc(batch: ^Atlas_Batch, index: i32, viewport: maf.Rect, mat: ^maf.Mat32, color: maf.Color = maf.COL_WHITE) {
	quad := maf.quad(viewport.x, viewport.y, viewport.w, viewport.h, batch.texture.width, batch.texture.height);
	atlasbatch_set(batch, index, &quad, mat, color);
}

atlasbatch_add :: proc(batch: ^Atlas_Batch, quad: ^maf.Quad, mat: ^maf.Mat32, color: maf.Color = maf.COL_WHITE) -> i32 {
	if !atlasbatch_ensure_capacity(batch) do return -1;

	atlasbatch_set(batch, batch.sprite_count, quad, mat, color);

	batch.sprite_count += 1;
	return batch.sprite_count - 1;
}

atlasbatch_add_viewport :: proc(batch: ^Atlas_Batch, viewport: maf.Rect, mat: ^maf.Mat32, color: maf.Color = maf.COL_WHITE) -> i32 {
	quad := maf.quad(viewport.x, viewport.y, viewport.w, viewport.h, batch.texture.width, batch.texture.height);
	return atlasbatch_add(batch, &quad, mat, color);
}

atlasbatch_draw :: proc(batch: ^Atlas_Batch) {
	if batch.buffer_dirty {
		dynamicmesh_append_vert_slice(batch.mesh, 0, batch.sprite_count * 4);
		batch.buffer_dirty = false;
	}

	texture_bind(batch.texture);
	dynamicmesh_draw(batch.mesh, 0, batch.sprite_count * 4);
}
