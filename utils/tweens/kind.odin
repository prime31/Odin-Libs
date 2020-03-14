package tweens

Kind :: enum {
	Linear,
	Quadratic_In,
	Quadratic_Out,
	Quadratic_In_Out,
	Cubic_In,
	Cubic_Out,
	Cubic_In_Out,
	Quartic_In,
	Quartic_Out,
	Quartic_In_Out,
	Quintic_In,
	Quintic_Out,
	Quintic_In_Out,
	Sin_In,
	Sin_Out,
	Sin_In_Out,
	Circular_In,
	Circular_Out,
	Circular_In_Out,
	Exponential_In,
	Exponential_Out,
	Exponential_In_Out,
	Elastic_In,
	Elastic_Out,
	Elastic_In_Out,
	Back_In,
	Back_Out,
	Back_In_Out,
	Bounce_In,
	Bounce_Out,
	Bounce_In_Out
}

eval :: proc(tween: ^Tween, val: f32) -> f32 {
	#partial switch tween.kind {
		case .Linear: { return linear(val); }
		case .Quadratic_In: { return quadratic_in(val); }
		case .Quadratic_Out: { return quadratic_out(val); }
		case .Quadratic_In_Out: { return quadratic_in_out(val); }
		case .Cubic_In: { return cubic_in(val); }
		case .Cubic_Out: { return cubic_out(val); }
		case .Cubic_In_Out: { return cubic_in_out(val); }
		case .Quartic_In: { return quartic_in(val); }
		case .Quartic_Out: { return quartic_out(val); }
		case .Quartic_In_Out: { return quartic_in_out(val); }
		case .Quintic_In: { return quintic_in(val); }
		case .Quintic_Out: { return quintic_out(val); }
		case .Quintic_In_Out: { return quintic_in_out(val); }
		case .Sin_In: { return sin_in(val); }
		case .Sin_Out: { return sin_out(val); }
		case .Sin_In_Out: { return sin_in_out(val); }
		case .Circular_In: { return circular_in(val); }
		case .Circular_Out: { return circular_out(val); }
		case .Circular_In_Out: { return circular_in_out(val); }
		case .Exponential_In: { return exponential_in(val); }
		case .Exponential_Out: { return exponential_out(val); }
		case .Exponential_In_Out: { return exponential_in_out(val); }
		case .Elastic_In: { return elastic_in(val); }
		case .Elastic_Out: { return elastic_out(val); }
		case .Elastic_In_Out: { return elastic_in_out(val); }
		case .Back_In: { return back_in(val); }
		case .Back_Out: { return back_out(val); }
		case .Back_In_Out: { return back_in_out(val); }
		case .Bounce_In: { return bounce_in(val); }
		case .Bounce_Out: { return bounce_out(val); }
		case .Bounce_In_Out: { return bounce_in_out(val); }
	}
	return 0;
}
