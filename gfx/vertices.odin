package gfx

import "core:fmt";
import "core:runtime";
import "core:intrinsics";
import "shared:engine/maf"
import "shared:engine/libs/fna"

// default, 2D vertex type
Vertex :: struct {
	pos: maf.Vec2,
	uv: maf.Vec2,
	col: u32
};

Vert_Pos_Col :: struct {
	pos: maf.Vec2,
	col: u32
};

Vert_Pos_Tex :: struct {
	pos: maf.Vec2,
	uv: maf.Vec2
};

Vert_Pos_Col_Tex :: struct {
	pos: maf.Vec2,
	col: u32,
	uv: maf.Vec2
};

@(private)
vert_decl_cache: map[typeid]fna.Vertex_Declaration = make(map[typeid]fna.Vertex_Declaration);


// Vertex Buffers

// creates a new vertex buffer from a built-in vertex type
new_vert_buffer_from_type :: proc(vertex_type: typeid, vertex_count: i32, is_dynamic: bool = false, usage: fna.Buffer_Usage = .Write_Only) -> ^fna.Buffer {
	vert_decl := vertex_decl_for_type(vertex_type);
	return fna.gen_vertex_buffer(fna_device, is_dynamic ? 1 : 0, usage, vertex_count, vert_decl.vertex_stride);
}

// creates a new vertex buffer from a Vertex_Declaration
new_vert_buffer_from_declaration :: proc(vert_declaration: fna.Vertex_Declaration, vertex_count: i32, is_dynamic: bool = false, usage: fna.Buffer_Usage = .Write_Only) -> ^fna.Buffer {
	return fna.gen_vertex_buffer(fna_device, is_dynamic ? 1 : 0, usage, vertex_count, vert_declaration.vertex_stride);
}

new_vert_buffer :: proc{new_vert_buffer_from_type, new_vert_buffer_from_declaration};

free_vert_buffer :: proc(buffer: ^fna.Buffer) {
	fna.add_dispose_vertex_buffer(fna_device, buffer);
}

set_vertex_buffer_data :: proc(buffer: ^fna.Buffer, data: ^$T, offset_in_bytes: i32 = 0, options: fna.Set_Data_Options = .None)
	where intrinsics.type_is_indexable(T) {
	element_size := cast(i32)size_of(intrinsics.type_elem_type(T));
	fna.set_vertex_buffer_data(fna_device, buffer, offset_in_bytes, &data[0], cast(i32)len(data) * element_size, 1, 1, options);
}


// Index Buffers

new_index_buffer :: proc(index_count: i32, is_dynamic: bool = false, usage: fna.Buffer_Usage = .Write_Only, index_element_size: fna.Index_Element_Size = ._16_Bit) -> ^fna.Buffer {
	return fna.gen_index_buffer(fna_device, is_dynamic ? 1 : 0, usage, index_count, index_element_size);
}

free_index_buffer :: proc(buffer: ^fna.Buffer) {
	fna.add_dispose_index_buffer(fna_device, buffer);
}

// for support with slices[:] it could be: data: []$T and for the data size: i32(size_of(T) * len(data))
set_index_buffer_data :: proc(buffer: ^fna.Buffer, data: ^$T, offset_in_bytes: i32 = 0, options: fna.Set_Data_Options = .None)
	where intrinsics.type_is_indexable(T) {
	element_size := cast(i32)size_of(intrinsics.type_elem_type(T));
	fna.set_index_buffer_data(fna_device, buffer, offset_in_bytes, &data[0], element_size * cast(i32)len(data), options);
}


// Helpers

vertex_decl_for_type :: proc(T: typeid) -> fna.Vertex_Declaration {
	if T in vert_decl_cache do return vert_decl_cache[T];

	vert_decl: fna.Vertex_Declaration = ---;
	switch T {
		case Vert_Pos_Col: vert_decl = vertex_decl_for_type_usages(T, .Position, .Color);
		case Vert_Pos_Tex: vert_decl = vertex_decl_for_type_usages(T, .Position, .Texture_Coordinate);
		case Vert_Pos_Col_Tex: vert_decl = vertex_decl_for_type_usages(T, .Position, .Color, .Texture_Coordinate);
		case Vertex: vert_decl = vertex_decl_for_type_usages(T, .Position, .Texture_Coordinate, .Color);
		case: panic("Invalid built-in vertex type. use vertex_decl_for_type_usages for custom types.");
	}

	vert_decl_cache[T] = vert_decl;

	return vert_decl;
}

// returns a Vertex_Declaration for type. The elements array must be freed later!
vertex_decl_for_type_usages :: proc(T: typeid, usages: ..fna.Vertex_Element_Usage) -> fna.Vertex_Declaration {
	vert_elements, stride := vertex_elements_for_type(T, ..usages);
	return fna.Vertex_Declaration{
		vertex_stride = stride,
		element_count = cast(i32)len(usages),
		elements = &vert_elements[0]
	};
}

// returns a []Vertex_Element for the type and its stride. usages should be the Vertex_Element_Usage for each field in order
@(private)
vertex_elements_for_type :: proc(T: typeid, usages: ..fna.Vertex_Element_Usage) -> ([]fna.Vertex_Element, i32) {
	ti_base := runtime.type_info_base(type_info_of(T));
	ti, is_struct := ti_base.variant.(runtime.Type_Info_Struct);

	assert(is_struct);
	assert(len(usages) == len(ti.types));

	get_format :: proc(field_ti: ^runtime.Type_Info, usage: fna.Vertex_Element_Usage) -> fna.Vertex_Element_Format {
		if usage == .Color do return .Color;

		#partial switch t in field_ti.variant {
			case runtime.Type_Info_Array: {
				arr_field_ti := runtime.type_info_base(type_info_of(t.elem.id));

				#partial switch arr_t in arr_field_ti.variant {
					case runtime.Type_Info_Integer: {
						switch arr_field_ti.size {
							case 2: {
								switch t.count {
									case 2: return .Short2;
									case 4: return .Short4;
									case: panic("invalid int array count");
								}
							}
							case: panic("invalid int array type");
						}
					}
					case runtime.Type_Info_Float: {
						switch arr_field_ti.size {
							case 2: {
								switch t.count {
									case 2: return .Half_Vector2;
									case 4: return .Half_Vector4;
									case: panic("invalid float array count");
								}
							}
							case 4: {
								switch t.count {
									case 2: return .Vector2;
									case 3: return .Vector3;
									case 4: return .Vector4;
									case: panic("invalid float array count");
								}
							}
							case: panic("invalid float array type");
						}
					}
				}
			}
			case runtime.Type_Info_Float: {
				assert(field_ti.size == 4);
				return .Single;
			}
			case: panic("invalid type");
		}
		return .Vector2;
	}

	stride: i32 = 0;
	vert_elements := make([]fna.Vertex_Element, len(ti.types));
	for i in 0..<len(ti.types) {
		field_ti := runtime.type_info_base(type_info_of(ti.types[i].id));

		vert_elements[i] = fna.Vertex_Element{
			offset = cast(i32)ti.offsets[i],
			vertex_element_format = get_format(field_ti, usages[i]),
			vertex_element_usage = usages[i],
			usage_index = 0
		};
		stride = vert_elements[i].offset + cast(i32)field_ti.size;
	}

	return vert_elements, stride;
}
