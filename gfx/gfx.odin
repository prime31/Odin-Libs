package gfx

import "core:fmt"
import "shared:engine/libs/fna"


// TODO: wrap these all up in a single struct
@(private)
render_target_bindings: fna.Render_Target_Binding;
@(private)
presentation_params: fna.Presentation_Parameters;
@(private)
_default_pass: Default_Offscreen_Pass;
@(private)
_batcher: ^Batcher;
@(private)
default_fontbook: ^Font_Book;
@(private)
default_font_bytes := #load("ProggyTiny.ttf");
@(private)
viewport: fna.Viewport;
default_sampler_state: fna.Sampler_State = {filter = .Point, max_anisotropy = 4};
fna_device: ^fna.Device;

init :: proc(params: ^fna.Presentation_Parameters, disable_debug_render: bool, design_w, design_h: i32, resolution_policy: Resolution_Policy) {
	presentation_params = params^;
	fna_device = fna.create_device(&presentation_params, 0);
	set_presentation_interval(.One);
	set_default_graphics_state();

	set_viewport({0, 0, params.back_buffer_width, params.back_buffer_height, 0, 1});

	_batcher = new_batcher();

	pixels := [?]u32 {0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF};
	_white_tex = new_texture_from_data(&pixels[0], 2, 2, default_sampler_state);

	default_fontbook = new_fontbook(256, 256);
	fontbook_add_font_mem(default_fontbook, default_font_bytes, false);
	fontbook_set_size(default_fontbook, 10);

	_default_pass = new_defaultoffscreenpass(design_w, design_h, resolution_policy);
	fmt.println(_default_pass);

	_debug_render_enabled = !disable_debug_render;
	debug_init();
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

	rasterizer_state := fna.Rasterizer_State{};
	fna.apply_rasterizer_state(fna_device, &rasterizer_state);

	depth_stencil := fna.Depth_Stencil_State{};
	fna.set_depth_stencil_state(fna_device, &depth_stencil);
}

clear :: proc(color: fna.Vec4, options: fna.Clear_Options = .All, depth: f32 = 1, stencil: i32 = 0) {
	color := color;
	fna.clear(fna_device, options, &color, depth, stencil);
}

set_viewport :: proc(new_viewport: fna.Viewport) {
	viewport = new_viewport;
	fna.set_viewport(fna_device, &viewport);
}

set_default_sampler_state :: proc(sampler_state: fna.Sampler_State) do default_sampler_state = sampler_state;

set_presentation_interval :: proc(present_interval: fna.Present_Interval) {
	fna.set_presentation_interval(fna_device, present_interval);
}

get_resolution_scaler :: proc() -> Resolution_Scaler do return _default_pass.scaler;

set_render_texture :: proc(render_texture: ^Render_Texture) {
	// early out if we have nothing to change
	if render_target_bindings.texture == nil && render_texture == nil do return;
	if render_texture != nil && render_target_bindings.texture == render_texture.fna_texture do return;

	new_width, new_height: i32;
	clear_target: fna.Render_Target_Usage;

	// unsetting a render texture
	if render_texture == nil {
		fna.set_render_targets(fna_device, nil, 0, nil, .None);
		render_target_bindings.texture = nil;

		new_width = presentation_params.back_buffer_width;
		new_height = presentation_params.back_buffer_height;
		clear_target = presentation_params.render_target_usage;

		// we dont need to Resolve the previous target since we dont support mips and multisampling
	} else {
		render_target_bindings.width = render_texture.width;
		render_target_bindings.height = render_texture.height;
		render_target_bindings.texture = render_texture;

		fna.set_render_targets(fna_device, &render_target_bindings, 1, render_texture.depth_stencil_buffer, render_texture.depth_stencil_format);

		new_width = render_texture.width;
		new_height = render_texture.height;
		clear_target = render_texture.render_target_usage;

		// we dont need to Resolve the previous target since we dont support mips and multisampling
	}

	// Apply new state, clear target if requested
	set_viewport({0, 0, new_width, new_height, 0, 1});

	scissor := fna.Rect{0, 0, new_width, new_height};
	fna.set_scissor_rect(fna_device, &scissor);

	if clear_target == .Discard_Contents do clear({0, 0, 0, 1});
}
