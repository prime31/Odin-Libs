package gfx

import "core:math"
import "shared:engine/libs/fna"
import "shared:engine/maf"
import "core:fmt"

Tringle_Batcher :: struct {
	mesh: ^Dynamic_Mesh(Vertex),
	draw_calls: [dynamic]i32,
	draw_call_index: int,

	vert_index: i32,	// current index into the vertex array
	vert_count: i32,	// total verts that we have not yet rendered
	buffer_offset: i32,	// offset into the vertex buffer of the first non-rendered vert
	discard_next: bool	// flag for dealing with the Metal issue where we have to discard our buffer 2 times
}

new_tribatch :: proc(max_tris: i32 = 150) -> ^Tringle_Batcher {
	batcher := new(Tringle_Batcher);
	batcher.mesh = new_dynamic_mesh(Vertex, max_tris * 3, max_tris * 3);
	batcher.draw_calls = make([dynamic]i32, 10);

	for i in 0..<len(batcher.mesh.verts) do batcher.mesh.verts[i].uv = {0.5, 0.5};

	indices := make([]i16, max_tris * 3, context.temp_allocator);
	for i in 0..<max_tris {
		indices[i * 3 + 0] = i16(i) * 3 + 0;
		indices[i * 3 + 1] = i16(i) * 3 + 1;
		indices[i * 3 + 2] = i16(i) * 3 + 2;
	}

	set_index_buffer_data(batcher.mesh.index_buffer, &indices, 0);

	return batcher;
}

free_tribatch :: proc(batcher: ^Tringle_Batcher) {
	free_dynamic_mesh(batcher.mesh);
	delete(batcher.draw_calls);
	free(batcher);
}

// called at the end of the frame when all drawing is complete. Flushes the batch and resets local state.
tribatch_end_frame :: proc(batcher: ^Tringle_Batcher) {
	tribatch_flush(batcher);
	batcher.vert_index = 0;
	batcher.vert_count = 0;
	batcher.buffer_offset = 0;
}

tribatch_flush :: proc(batcher: ^Tringle_Batcher, discard_buffer: bool = false) {
	if batcher.vert_count == 0 do return;

	// if we ran out of space and dont support no_overwrite we have to discard the buffer
	// TODO: we can lose data on Metal with No_Overwrite. FNA3D bug or our bug?
	options: fna.Set_Data_Options = discard_buffer || batcher.discard_next || fna.supports_no_overwrite(fna_device) == 0 ? .Discard : .No_Overwrite;
	batcher.discard_next = false;

	dynamic_mesh_append_vert_slice(batcher.mesh, batcher.buffer_offset, batcher.vert_count, options);


	// run through all our accumulated draw calls
	for i in 0..batcher.draw_call_index {
		texture_bind(_white_tex);
		dynamic_mesh_draw(batcher.mesh, batcher.buffer_offset, batcher.draw_calls[i]);
		batcher.buffer_offset += batcher.draw_calls[i];
	}

	batcher.draw_call_index = -1;
	batcher.vert_count = 0;
}

// ensures the vert buffer has enough space and manages the draw call command buffer when textures change
@(private)
tribatch_ensure_capacity :: proc(batcher: ^Tringle_Batcher, count: i32 = 3) {
	// if we run out of buffer we have to flush the batch and possibly discard the whole buffer
	if batcher.vert_index + count > cast(i32)len(batcher.mesh.verts) {
		if batcher.draw_call_index < 0 do dynamic_mesh_append_vert_slice(batcher.mesh, 0, 1, .Discard);
		else do tribatch_flush(batcher, true);

		// we have to discard two frames for metal else we lose draws for some reason...
		if fna.supports_no_overwrite(fna_device) == 1 do batcher.discard_next = true;
		batcher.vert_index = 0;
		batcher.vert_count = 0;
		batcher.buffer_offset = 0;
	}

	// start a new draw call if we dont already have one going
	if batcher.draw_call_index < 0 {
		// expand our command buffer size if needed
		if batcher.draw_call_index + 1 == len(batcher.draw_calls) {
			append(&batcher.draw_calls, 0);
		}
		batcher.draw_call_index += 1;
		batcher.draw_calls[batcher.draw_call_index] = 0;
	}
}

tribatch_draw_triangle :: proc(batcher: ^Tringle_Batcher, pt1, pt2, pt3: maf.Vec2, color: maf.Color = maf.COL_WHITE) {
	tribatch_ensure_capacity(batcher);

	// copy the quad positions, uvs and color into vertex array transforming them with the matrix after we do it
	batcher.mesh.verts[batcher.vert_index].pos = pt1;
	batcher.mesh.verts[batcher.vert_index].col = color.packed;
	batcher.mesh.verts[batcher.vert_index + 1].pos = pt2;
	batcher.mesh.verts[batcher.vert_index + 1].col = color.packed;
	batcher.mesh.verts[batcher.vert_index + 2].pos = pt3;
	batcher.mesh.verts[batcher.vert_index + 2].col = color.packed;

	mat := maf.MAT32_IDENTITY;
	maf.mat32_transform_vertex_slice(&mat, batcher.mesh.verts[batcher.vert_index:batcher.vert_index + 3]);

	batcher.draw_calls[batcher.draw_call_index] += 3;
	batcher.vert_count += 3;
	batcher.vert_index += 3;
}

tribatch_draw_circle :: proc(batcher: ^Tringle_Batcher, center: maf.Vec2, radius: f32, color: maf.Color = maf.COL_WHITE, resolution: i32 = 12) {
	tribatch_ensure_capacity(batcher, resolution);

	increment := maf.PI * 2 / cast(f32)resolution;
	theta: f32 = 0.0;

	sin_cos := maf.Vec2{math.cos(theta), math.sin(theta)};
	v0 := center + sin_cos;
	theta += increment;

	for _ in 1..resolution {
		sin_cos = maf.Vec2{math.cos(theta), math.sin(theta)};
		v1 := center + sin_cos * radius;

		sin_cos = maf.Vec2{math.cos(theta + increment), math.sin(theta + increment)};
		v2 := center + sin_cos * radius;

		tribatch_draw_triangle(batcher, v0, v1, v2, color);
		theta += increment;
	}
}

tribatch_draw_polygon :: proc(batcher: ^Tringle_Batcher, verts: []maf.Vec2, color: maf.Color = maf.COL_WHITE) {
	tribatch_ensure_capacity(batcher, i32(len(verts) / 2) + 1);

	center := verts[0];
	for i in 1..<len(verts) do center += verts[i];
	center /= cast(f32)len(verts);

	for i in 0..<len(verts) - 1 do tribatch_draw_triangle(batcher, center, verts[i], verts[i + 1], color);
	tribatch_draw_triangle(batcher, center, verts[len(verts) - 1], verts[0], color);
}
