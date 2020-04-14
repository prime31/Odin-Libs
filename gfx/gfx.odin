package gfx

import "shared:engine/libs/fna"

@(private)
batcher: ^Batcher;
default_sampler_state: fna.Sampler_State = {filter = .Point, max_anisotropy = 4};
fna_device: ^fna.Device;

init :: proc(params: ^fna.Presentation_Parameters) {
	fna_device = fna.create_device(params, 0);
	set_presentation_interval(.One);
	set_default_graphics_state();

	vp := fna.Viewport{0, 0, params.back_buffer_width, params.back_buffer_height, -1, 1};
	fna.set_viewport(fna_device, &vp);

	batcher = new_batcher();
}

@(private)
set_default_graphics_state :: proc() {
	// alpha blend
	blend := fna.Blend_State{
		.Source_Alpha, .Inverse_Source_Alpha, .Add,
		.Source_Alpha, .Inverse_Source_Alpha, .Add,
		.All, .All, .All, .All, fna.Color{255, 255, 255, 255}, -1
	};
	fna.set_blend_state(fna_device, &blend);

	rasterizer_state := fna.Rasterizer_State{
		fill_mode = .Solid,
		cull_mode = .None
	};
	fna.apply_rasterizer_state(fna_device, &rasterizer_state);

	depth_stencil := fna.Depth_Stencil_State{};
	fna.set_depth_stencil_state(fna_device, &depth_stencil);
}

set_default_sampler_state :: proc(sampler_state: fna.Sampler_State) {
	default_sampler_state = sampler_state;
}


set_presentation_interval :: proc(present_interval: fna.Present_Interval) {
	fna.set_presentation_interval(fna_device, present_interval);
}
