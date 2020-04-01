package main

import "core:fmt"
import "core:runtime";
import "shared:engine/libs/fna"

Vertex :: struct {
	pos: [2]f32,
	uv: [2]f32,
	col: u32
};

main :: proc() {
    vert_elements := vertex_elements_for_type(Vertex, .Position, .Texture_Coordinate, .Color);
    fmt.println(vert_elements);
}


// returns a []Vertex_Element for the type. usages should be the Vertex_Element_Usage for each field in order
vertex_elements_for_type :: proc(type: typeid, usages: ..fna.Vertex_Element_Usage) -> []fna.Vertex_Element {
    ti_base := runtime.type_info_base(type_info_of(type));
    ti, is_struct := ti_base.variant.(runtime.Type_Info_Struct);

    assert(is_struct);
    assert(len(usages) == len(ti.types));

    get_format :: proc(field_type: typeid, usage: fna.Vertex_Element_Usage) -> fna.Vertex_Element_Format {
    	if usage == .Color do return .Color;

    	field_ti := runtime.type_info_base(type_info_of(field_type));
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
    								case: fmt.panicf("invalid int array count");
    							}
    						}
    						case: fmt.panicf("invalid int array type");
    					}
    				}
    				case runtime.Type_Info_Float: {
    					switch arr_field_ti.size {
    						case 2: {
   								switch t.count {
				    				case 2: return .Half_Vector2;
				    				case 4: return .Half_Vector4;
				    				case: fmt.panicf("invalid float array count");
				    			}
    						}
    						case 4: {
	   							switch t.count {
				    				case 2: return .Vector2;
				    				case 3: return .Vector3;
				    				case 4: return .Vector4;
				    				case: fmt.panicf("invalid float array count");
				    			}
    						}
    						case: fmt.panicf("invalid float array type");
    					}
    				}
    			}
    		}
    		case runtime.Type_Info_Float: {
    			assert(field_ti.size == 4);
    			return .Single;
    		}
    		case: fmt.panicf("invalid type");
    	}
    	return .Vector2;
    }

    vert_elements := make([]fna.Vertex_Element, len(ti.types));
    for i in 0..<len(ti.types) {
    	vert_elements[i] = fna.Vertex_Element{
    		offset = cast(i32)ti.offsets[i],
    		vertex_element_format = get_format(ti.types[i].id, usages[i]),
    		vertex_element_usage = usages[i],
    		usage_index = 0
    	};
    }

    return vert_elements;
}
