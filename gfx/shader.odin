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
	defer if success do delete(data);;
	if !success do panic("could not open effect file");

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


// Shader parameter get/set procs
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

			floats := mem.slice_ptr(param.effect_value.value.float, cast(int)param.effect_value.value_count);
			return maf.Mat32{{floats[0], floats[4]}, {floats[1], floats[5]}, {floats[2], floats[6]}};
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

			dst := mem.slice_ptr(param.effect_value.value.float, cast(int)param.effect_value.value_count);
			dst[0] = value[0][0];
			dst[1] = value[1][0];
			dst[2] = value[2][0];
			dst[4] = value[0][1];
			dst[5] = value[1][1];
			dst[6] = value[2][1];
			return;
		}
	}
}

shader_set_mat3 :: proc(shader: ^Shader, name: string, value: ^maf.Mat3) {
	params := mem.slice_ptr(shader.mojo_effect.params, cast(int)shader.mojo_effect.param_count);
	for param in params {
		if cast(string)param.effect_value.name == name {
			assert(param.effect_value.type.parameter_type == .Float && param.effect_value.type.parameter_class == .Matrix_Rows);
			assert(param.effect_value.type.rows == 3 && param.effect_value.type.columns == 3);

			dst := mem.slice_ptr(param.effect_value.value.float, cast(int)param.effect_value.value_count);
			dst[0] = value[0][0];
			dst[1] = value[1][0];
			dst[2] = value[2][0];
			dst[4] = value[0][1];
			dst[5] = value[1][1];
			dst[6] = value[2][1];
			dst[8] = value[0][2];
			dst[9] = value[1][2];
			dst[10] = value[2][2];

			return;
		}
	}
}

shader_set_mat4 :: proc(shader: ^Shader, name: string, value: ^maf.Mat4) {
	params := mem.slice_ptr(shader.mojo_effect.params, cast(int)shader.mojo_effect.param_count);
	for param in params {
		if cast(string)param.effect_value.name == name {
			assert(param.effect_value.type.parameter_type == .Float && param.effect_value.type.parameter_class == .Matrix_Rows);
			assert(param.effect_value.type.rows == 4 && param.effect_value.type.columns == 4);

			dst := mem.slice_ptr(param.effect_value.value.float, cast(int)param.effect_value.value_count);
			dst[0] = value[0][0];
			dst[1] = value[1][0];
			dst[2] = value[2][0];
			dst[2] = value[3][0];
			dst[4] = value[0][1];
			dst[5] = value[1][1];
			dst[6] = value[2][1];
			dst[2] = value[3][1];
			dst[8] = value[0][2];
			dst[9] = value[1][2];
			dst[10] = value[2][2];
			dst[11] = value[3][2];
			dst[12] = value[0][3];
			dst[13] = value[1][3];
			dst[14] = value[2][3];
			dst[15] = value[3][3];

			return;
		}
	}
}
