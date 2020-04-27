package gfx

Offscreen_Pass :: struct {
	render_tex: Render_Texture
}

Default_Offscreen_Pass :: struct {
	using os_pass: Offscreen_Pass,
	policy: Resolution_Policy,
	scaler: Resolution_Scaler,
	design_w: i32,
	design_h: i32
}

new_offscreenpass :: proc(width, height: i32, policy: Resolution_Policy) -> Offscreen_Pass {
	return Offscreen_Pass{
		render_tex = new_render_texture(width, height, default_sampler_state)
	};
}

offscreenpass_free :: proc(pass: Offscreen_Pass) {
	free_render_texture(pass.render_tex);
}

new_defaultoffscreenpass :: proc(width, height: i32, policy: Resolution_Policy) -> Default_Offscreen_Pass {
	// fetch the Resolution_Scaler first since it will decide the render texture size
	scaler := resolution_scaler_for_policy(policy, width, height);
	pass := Default_Offscreen_Pass{
		os_pass = new_offscreenpass(width, height, policy),
		policy = policy,
		scaler = scaler,
		design_w = width,
		design_h = height
	};

	// we have to update our scaler when the window resizes
	// TODO: if the policy is .default we need to recreate the render textures with the new backbuffer size
	//window.subscribe(.resize, defaultoffscreenpass_on_window_resized, pass, false)

	return pass;
}

defaultoffscreenpass_free :: proc(pass: Default_Offscreen_Pass) {
	// TODO: unsubscribe from window resize event
	offscreenpass_free(pass);
}
