package imgui

import "core:os"
import "core:fmt"
import "core:mem"
import "shared:engine/maf"
import "shared:engine/gfx"
import "shared:engine/libs/fna"

@(private)
font_texture: gfx.Texture;
@(private)
vert_decl: fna.Vertex_Declaration;
@(private)
vert_buffer_size: i32;
@(private)
vert_buffer: ^fna.Buffer;
@(private)
index_buffer_size: i32;
@(private)
index_buffer: ^fna.Buffer;
@(private)
vert_buffer_binding: fna.Vertex_Buffer_Binding;
@(private)
shader: ^gfx.Shader;
@(private)
device: ^fna.Device;


fna_init :: proc(fna_device: ^fna.Device) {
	device = fna_device;
	shader = gfx.new_shader("effects/VertexColorTexture.fxb");

	vert_decl = gfx.vertex_decl_for_type(gfx.Vertex);

	create_context();
	io := get_io();
	io.config_flags |= .DockingEnable;
	// io.config_flags |= .ViewportsEnable;

	style_colors_dark(get_style());

	font_atlas_add_font_default(io.fonts, nil);
	width, height : i32;
	pixels: ^u8;
	font_atlas_get_text_data_as_rgba32(io.fonts, &pixels, &width, &height);

	font_texture = gfx.new_texture_from_data(pixels, width, height, gfx.default_sampler_state);

	// font_texture = fna.create_texture_2d(device, .Color, width, height, 1, 0);
	// fna.set_texture_data_2d(device, font_texture, .Color, 0, 0, width, height, 0, pixels, width * height * size_of(pixels));

	font_atlas_set_text_id(io.fonts, font_texture.fna_texture);
	font_atlas_clear_tex_data(io.fonts);
}

fna_render :: proc() {
	render();

	io := get_io();
	draw_data := get_draw_data();
	if draw_data.total_vtx_count == 0 do return;

	draw_data_scale_clip_rects(draw_data, io.display_framebuffer_scale);
	fna_update_buffers(draw_data);

	width  := i32(draw_data.display_size.x * io.display_framebuffer_scale.x);
	height := i32(draw_data.display_size.y * io.display_framebuffer_scale.y);

	transform := maf.mat32_ortho(cast(f32)width, cast(f32)height);
	gfx.shader_set_mat32(shader, "TransformMatrix", &transform);
	gfx.shader_apply(shader);


	bindings_updated: u8 = 1;
	vert_buffer_binding = fna.Vertex_Buffer_Binding{vert_buffer, vert_decl, 0, 0};


	rasterizer_state := fna.Rasterizer_State{
		scissor_test_enable = 1
	};
	fna.apply_rasterizer_state(device, &rasterizer_state);


	new_list := mem.slice_ptr(draw_data.cmd_lists, int(draw_data.cmd_lists_count));
	for list in new_list {
		fna.set_vertex_buffer_data(device, vert_buffer, 0, list.vtx_buffer.data, list.vtx_buffer.size, size_of(DrawVert), size_of(DrawVert), .None);
		fna.set_index_buffer_data(device, index_buffer, 0, list.idx_buffer.data, list.idx_buffer.size * size_of(DrawIdx), .None);

		clip_off := draw_data.display_pos;
		cmds := mem.slice_ptr(list.cmd_buffer.data, int(list.cmd_buffer.size));
		for cmd, idx in cmds {
			if cmd.user_callback != nil {
				// the magic reset call back is cmd.user_callback: ImDrawCallback_ResetRenderState which is -1
				if cast(uintptr)cast(rawptr)cmd.user_callback == ~uintptr(0) {
					fmt.panicf("imgui panic. reset state detected");
				} else {
					cmd.user_callback(list, &cmds[idx]);
				}
			} else {
				clip_rect := fna.Rect{
					i32(cmd.clip_rect.x - clip_off.x),
					i32(cmd.clip_rect.y - clip_off.y),
					cast(i32)(cmd.clip_rect.z - clip_off.x - cmd.clip_rect.x),
					cast(i32)(cmd.clip_rect.w - clip_off.y - cmd.clip_rect.y)
				};

				if clip_rect.x < width && clip_rect.y < height && clip_rect.h >= 0 && clip_rect.w >= 0 {
					fna.set_scissor_rect(device, &clip_rect);
					gfx.texture_bind(cast(^fna.Texture)cmd.texture_id);

					fna.apply_vertex_buffer_bindings(device, &vert_buffer_binding, 1, bindings_updated, cast(i32)cmd.vtx_offset);
					fna.draw_indexed_primitives(device, .Triangle_List, cast(i32)cmd.vtx_offset, 0, list.vtx_buffer.size, cast(i32)cmd.idx_offset, cast(i32)cmd.elem_count / 3, index_buffer, ._16_Bit);
					bindings_updated = 0;
				}
			}
		} // for cmd, idx in cmds
	} // for list in new_list

	clip_rect := fna.Rect{0, 0, width, height};
	fna.set_scissor_rect(device, &clip_rect);
}

@(private)
fna_update_buffers :: proc(draw_data: ^DrawData) {
	if draw_data.total_vtx_count == 0 do return;

	// Expand buffers if we need more room
	if draw_data.total_vtx_count > vert_buffer_size {
		fmt.println("Regenerating vertex buffer");
		vert_buffer_size = cast(i32)(cast(f32)draw_data.total_vtx_count * 1.5);
		vert_buffer = fna.gen_vertex_buffer(device, 0, .Write_Only, vert_buffer_size, vert_decl.vertex_stride);
	}

	if draw_data.total_idx_count > index_buffer_size {
		fmt.println("Regenerating index buffer");
		index_buffer_size = cast(i32)(cast(f32)draw_data.total_idx_count * 1.5);
		index_buffer = fna.gen_index_buffer(device, 1, .Write_Only, index_buffer_size, ._16_Bit);
	}
}
