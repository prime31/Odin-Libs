package gfx





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
