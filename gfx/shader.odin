package gfx

import "core:os"
import "core:mem"
import "core:fmt"
import "shared:engine/maf"
import "shared:engine/libs/fna"


Shader :: struct {
	using effect: ^fna.Effect
}

new_shader :: proc(file: string) -> ^Shader {
	data, success := os.read_entire_file(file);
	defer if success { delete(data); } else { panic("could not open effect file"); }

	shader := new(Shader);
	shader.effect = fna.create_effect(fna_device, &data[0], cast(u32)len(data));

	params := mem.slice_ptr(shader.mojo_effect.params, cast(int)shader.mojo_effect.param_count);
	for param in params {
		fmt.println("param", param);
	}

	return shader;
}

free_shader :: proc(shader: ^Shader) {
	fna.add_dispose_effect(fna_device, shader);
	free(shader);
}

shader_apply :: proc(shader: ^Shader) {
	state_changes := fna.Mojoshader_Effect_State_Changes{};
	fna.apply_effect(fna_device, shader, shader.mojo_effect.current_technique, 0, &state_changes);
}

shader_set :: proc{shader_set_f32, shader_set_i32, shader_set_vec2, shader_set_mat32};

shader_get_f32 :: proc(shader: ^Shader, name: string) -> f32 {
	params := mem.slice_ptr(shader.mojo_effect.params, cast(int)shader.mojo_effect.param_count);
	for param in params {
		if cast(string)param.effect_value.name == name {
			assert(param.effect_value.type.parameter_type == .Float && param.effect_value.type.parameter_class == .Scalar);
			return param.effect_value.value.float^;
		}
	}

	panic("shader param not found");
	return ---;
}

shader_set_f32 :: proc(shader: ^Shader, name: string, value: f32) {
	params := mem.slice_ptr(shader.mojo_effect.params, cast(int)shader.mojo_effect.param_count);
	for param in params {
		if cast(string)param.effect_value.name == name {
			assert(param.effect_value.type.parameter_type == .Float && param.effect_value.type.parameter_class == .Scalar);
			param.effect_value.value.float^ = value;
			return;
		}
	}
}

shader_get_i32 :: proc(shader: ^Shader, name: string) -> i32 {
	params := mem.slice_ptr(shader.mojo_effect.params, cast(int)shader.mojo_effect.param_count);
	for param in params {
		if cast(string)param.effect_value.name == name {
			assert(param.effect_value.type.parameter_type == .Int && param.effect_value.type.parameter_class == .Scalar);
			return param.effect_value.value.int^;
		}
	}

	panic("shader param not found");
	return ---;
}

shader_set_i32 :: proc(shader: ^Shader, name: string, value: i32) {
	params := mem.slice_ptr(shader.mojo_effect.params, cast(int)shader.mojo_effect.param_count);
	for param in params {
		if cast(string)param.effect_value.name == name {
			assert(param.effect_value.type.parameter_type == .Int && param.effect_value.type.parameter_class == .Scalar);
			param.effect_value.value.int^ = value;
			return;
		}
	}
}

shader_get_vec2 :: proc(shader: ^Shader, name: string) -> maf.Vec2 {
	params := mem.slice_ptr(shader.mojo_effect.params, cast(int)shader.mojo_effect.param_count);
	for param in params {
		if cast(string)param.effect_value.name == name {
			assert(param.effect_value.type.parameter_type == .Float && param.effect_value.type.parameter_class == .Vector);
			assert(param.effect_value.type.columns == 2);
			floats := mem.slice_ptr(param.effect_value.value.float, 2);
			return maf.Vec2{floats[0], floats[1]};
		}
	}

	panic("shader param not found");
	return ---;
}

shader_set_vec2 :: proc(shader: ^Shader, name: string, value: maf.Vec2) {
	params := mem.slice_ptr(shader.mojo_effect.params, cast(int)shader.mojo_effect.param_count);
	for param in params {
		if cast(string)param.effect_value.name == name {
			assert(param.effect_value.type.parameter_type == .Float && param.effect_value.type.parameter_class == .Vector);
			assert(param.effect_value.type.columns == 2);
			floats := mem.slice_ptr(param.effect_value.value.float, 2);
			floats[0] = value.x;
			floats[1] = value.y;
			return;
		}
	}
}

shader_get_mat32 :: proc(shader: ^Shader, name: string) -> maf.Mat32 {
	params := mem.slice_ptr(shader.mojo_effect.params, cast(int)shader.mojo_effect.param_count);
	for param in params {
		if cast(string)param.effect_value.name == name {
			assert(param.effect_value.type.parameter_type == .Float && param.effect_value.type.parameter_class == .Matrix_Rows);
			assert(param.effect_value.type.rows == 2 && param.effect_value.type.columns == 3);
			floats := mem.slice_ptr(param.effect_value.value.float, 6);
			return maf.Mat32{floats[0], floats[1], floats[2], floats[3], floats[4], floats[5]};
		}
	}

	panic("shader param not found");
	return ---;
}

shader_set_mat32 :: proc(shader: ^Shader, name: string, value: ^maf.Mat32) {
	params := mem.slice_ptr(shader.mojo_effect.params, cast(int)shader.mojo_effect.param_count);
	for param in params {
		if cast(string)param.effect_value.name == name {
			assert(param.effect_value.type.parameter_type == .Float && param.effect_value.type.parameter_class == .Matrix_Rows);
			assert(param.effect_value.type.rows == 2 && param.effect_value.type.columns == 3);
			mem.copy(param.effect_value.value.float, &value[0], size_of(maf.Mat32));
			return;
		}
	}
}