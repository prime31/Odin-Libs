package tweens

Tween :: struct {
	pos: f32,
	pre_delay: f32,
	post_delay: f32,
	paused: bool,
	done: bool,
	cb: TweenTickFn,
	ctx: rawptr,
	kind: Kind,
	start: f32,
	end: f32,
	duration: f32
}

TweenTickFn :: proc(ctx: rawptr, tween: ^Tween);


tween :: proc(start, end, duration: f32, kind: Kind) -> Tween {
	return Tween{
		kind = kind,
		start = start,
		end = end,
		duration = duration
	};
}

set_cb :: proc(tween: ^Tween, ctx: rawptr, cb: TweenTickFn) {
	tween.ctx = ctx;
	tween.cb = cb;
}

set_delay :: proc(tween: ^Tween, pre_delay, post_delay: f32) {
	tween.pre_delay = pre_delay;
	tween.post_delay = post_delay;
}

tick :: proc(tween: ^Tween, dt: f32) {
	if tween.paused || tween.done { return; }

	delta := dt;
	if tween.pre_delay > 0 {
		tween.pre_delay -= delta;
		if tween.pre_delay > 0 { return; }
		if tween.pre_delay < 0 {
			delta = -tween.pre_delay;
			tween.pre_delay = 0;
		}
	}

	tween.pos += delta;
	if tween.pos > tween.duration {
		tween.pos = tween.duration;
		if tween.post_delay > 0 {
			tween.post_delay -= delta;
		}
		if tween.post_delay <= 0 {
			tween.done = true;
			if tween.cb != nil {
				tween.cb(tween.ctx, tween);
			}
		}
	}
}

value :: proc(tween: ^Tween) -> f32 {
	return tween.start + eval(tween, tween.pos / tween.duration) * (tween.end - tween.start);
}
