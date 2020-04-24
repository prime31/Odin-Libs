package gfx

import "core:fmt"
import "shared:engine/libs/fna"
import "shared:engine/maf"

Atlas_Batch :: struct {
	mesh: ^Dynamic_Mesh(Vertex),
	sprite_count: i32,
	max_sprites: i32,
	texture: Texture
}

new_atlasbatch :: proc(texture: Texture, max_sprites: i32 = 256) -> ^Atlas_Batch {
	batcher := new(Atlas_Batch);
	batcher.mesh = new_dynamic_mesh(Vertex, max_sprites * 4, max_sprites * 6);
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
	free_dynamic_mesh(batch.mesh);
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

atlasbatch_draw :: proc(batch: ^Atlas_Batch, texture: ^fna.Texture, quad: ^maf.Quad, mat: ^maf.Mat32, color: maf.Color = maf.COL_WHITE) -> i32 {
	if !atlasbatch_ensure_capacity(batch) do return -1;

	// copy the quad positions, uvs and color into vertex array transforming them with the matrix as we do it
	vert_index := batch.sprite_count * 4;
	maf.mat32_transform_quad(mat, batch.mesh.verts[vert_index:vert_index + 4], quad, color);

	batch.sprite_count += 1;
	return batch.sprite_count - 1;
}
