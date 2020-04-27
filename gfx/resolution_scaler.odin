package gfx

import "core:math"
import "shared:engine/window"


Resolution_Policy :: enum i32 {
	Default,
	No_Border,
	No_Border_Pixel_Perfect,
	Show_All,
	Show_All_Pixel_Perfect,
	Best_Fit
}

Resolution_Scaler :: struct {
	x: i32,
	y: i32,
	w: i32,
	h: i32,
	scale: f32
}

resolution_scaler_for_policy :: proc(policy: Resolution_Policy, design_w, design_h: i32) -> Resolution_Scaler {
	// non-default policy requires a design size
	assert((policy != .Default && design_w > 0 && design_h > 0) || policy == .Default);

	// common config
	w, h := window.drawable_size();

	// our render target size will be full screen for .default
	rt_w := policy == .Default ? w : design_w;
	rt_h := policy == .Default ? h : design_h;

	// scale of the screen size / render target size, used by both pixel perfect and non-pp
	res_x := f32(w) / f32(rt_w);
	res_y := f32(h) / f32(rt_h);

	scale: i32 = 1;
	scale_f: f32 = 1.0;
	aspect_ratio := f32(w) / f32(h);
	rt_aspect_ratio := f32(rt_w) / f32(rt_h);

	if policy != .Default {
		scale_f := rt_aspect_ratio > aspect_ratio ? res_x : res_y;
		scale = cast(i32)math.floor(scale_f);

		if scale < 1 {
			scale = 1;
		}
	}

	switch policy {
		case .Default: {
			win_scale := window.scale();
			width := i32(f32(w) / win_scale);
			height := i32(f32(h) / win_scale);
			return Resolution_Scaler{0, 0, width, height, win_scale};
		}
		case .No_Border, .Show_All: {
			// go for the highest scale value if we can crop (No_Border) or
			// go for the lowest scale value so everything fits properly (Show_All)
			res_scale := policy == .No_Border ? max(res_x, res_y) : min(res_x, res_y);

			x := (f32(w) - (f32(rt_w) * res_scale)) / 2.0;
			y := (f32(h) - (f32(rt_h) * res_scale)) / 2.0;

			return Resolution_Scaler{cast(i32)x, cast(i32)y, rt_w, rt_h, res_scale};
		}
		case .No_Border_Pixel_Perfect, .Show_All_Pixel_Perfect: {
			// the only difference is that no_border rounds up (instead of down) and crops. Because
			// of the round up, we flip the compare of the rt aspect ratio vs the screen aspect ratio.
			if policy == .No_Border_Pixel_Perfect {
				scale_f = rt_aspect_ratio < aspect_ratio ? res_x : res_y;
				scale = cast(i32)math.ceil(scale_f);
			}

			x := (w - (rt_w * scale)) / 2;
			y := (h - (rt_h * scale)) / 2;
			return Resolution_Scaler{x, y, rt_w, rt_h, cast(f32)scale};
		}
		case .Best_Fit: {
			// TODO: move this into some sort of safe area config
			bleed_x: i32 = 0;
			bleed_y: i32 = 0;
			safe_sx := f32(w) / f32(rt_w - bleed_x);
			safe_sy := f32(h) / f32(rt_h - bleed_y);

			res_scale := max(res_x, res_y);
			safe_scale := min(safe_sx, safe_sy);
			final_scale := min(res_scale, safe_scale);

			x := (f32(w) - (f32(rt_w) * final_scale)) / 2.0;
			y := (f32(h) - (f32(rt_h) * final_scale)) / 2.0;

			return Resolution_Scaler{cast(i32)x, cast(i32)y, rt_w, rt_h, final_scale};
		}
	}

	return Resolution_Scaler{};
}
