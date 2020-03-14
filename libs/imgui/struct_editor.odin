package imgui

import "core:runtime";
import "core:fmt";
import "core:mem";
import "core:strings";

_internal_string_buffer := [4096]byte{};

_get_name :: proc(data : any) -> string {
    info := type_info_of(data.id);
    #partial switch ti in info.variant {
        case runtime.Type_Info_Named : return ti.name;
        case                         : return "<non-named>";
    }
}

_print_tooltip :: proc(data : any) {
    begin_tooltip();
    text("Type: %v", type_info_of(data.id));
    text("Ptr: %p", data.data);
    text("Size: %d bytes", type_info_of(data.id).size);
    end_tooltip();
}

edit_value :: proc(data: any) {
    push_id(data.data); defer pop_id();
    ti := runtime.type_info_base(type_info_of(data.id));

    #partial switch t in ti.variant {
        case runtime.Type_Info_Boolean : {
            ptr := cast(^bool)data.data;
            checkbox("##checkbox", ptr);
        }

        //TODO: Actually be able to live change array members, maybe even delete and add.
        case runtime.Type_Info_Array: {
            str := fmt.aprintf("Count = %d of %v", t.count, t.elem); defer delete(str);
            if collapsing_header(str) {
                begin_child("##child", Vec2{0, 200}); defer end_child();
                for i in 0..t.count - 1 {
                    ptr := uintptr(data.data) + uintptr(i * t.elem_size);
                    text("%#v", any{rawptr(ptr), t.elem.id});
                }
            }
        }

        case runtime.Type_Info_Slice: {
            slice := cast(^mem.Raw_Slice)data.data;
            str := fmt.aprintf("Count = %d of %v", slice.len, t.elem); defer delete(str);
            if collapsing_header(str) {
                begin_child("##child", Vec2{0, 200}); defer end_child();
                for i in 0..slice.len-1 {
                    ptr := uintptr(slice.data) + uintptr(i*t.elem_size);
                    text("%#v", any{rawptr(ptr), t.elem.id});
                }
            }
        }

        case runtime.Type_Info_Integer: {
            size := ti.size;
            signed := t.signed;
            v : i32;
            disable := false;
            if !signed {
                text("%v, Unsupported; %v", data, ti);
                return;
            }
            switch size {
                case 1  : {
                    d := data.(i8);
                    v = i32(d);
                }

                case 2 : {
                    d := data.(i16);
                    v = i32(d);
                }

                case 4 : {
                    d := data.(i32);
                    v = i32(d);
                }

                case 8 :
                    d := cast(^i64)data.data;
                    v = i32(d^);
                case : {
                    disable = true;
                }
            }

            if disable do text("Unsupported; %v", ti);
            else {
                if input_int("##int", &v) {
                    switch size {
                        case 1  : {
                            ptr := cast(^i8)data.data;
                            ptr^ = i8(v);
                        }

                        case 2  : {
                            ptr := cast(^i16)data.data;
                            ptr^ = i16(v);
                        }

                        case 4  : {
                            ptr := cast(^i32)data.data;
                            ptr^ = i32(v);
                        }

                        case 8 :
                            ptr := cast(^i64)data.data;
                            ptr^ = i64(v);
                    }
                }
            }
        }

        case runtime.Type_Info_Float: {
            switch ti.size {
                case 4 : {
                    ptr := cast(^f32)data.data;
                    drag_float("float", ptr);
                    // input_float("##float", ptr);
                }

                case 8 : {
                    v_ptr := cast(^f64)data.data;
                    v := f32(v_ptr^);
                    if input_float("##float", &v) {
                        v_ptr^ = f64(v);
                    }
                }

                case : {
                    text("Unsupported; %v", ti);
                }
            }
        }

        case runtime.Type_Info_String : {
            buf := _internal_string_buffer;
            defer mem.zero(&buf[0], len(buf));

            fmt.bprint(buf[:], data.(string));

            if input_text("##text", buf[:]) {
                buf_str := string(buf[:len(string(buf[:]))]);
                ptr := cast(^string)data.data;
                ptr^ = strings.clone(buf_str);
            }
        }

        /*case runtime.Type_Info_Struct : {
            print_struct(data);
        }*/

        case : {
            text("%#v", data);
        }
    }
    //case runtime.Type_Info_Rune:       fmt_arg(fi, v, verb);
    //case runtime.Type_Info_Float:      fmt_arg(fi, v, verb);
    //case runtime.Type_Info_Complex:    fmt_arg(fi, v, verb);
}

print_struct :: proc(data : any) {
    _ti := runtime.type_info_base(type_info_of(data.id));
    ti, _ := _ti.variant.(runtime.Type_Info_Struct);

    text("Struct Name: %s", _get_name(data));
    if is_item_hovered() {
        _print_tooltip(data);
    }
    columns(2);

    for name, idx in ti.names {
        a := any{rawptr(uintptr(data.data) +ti.offsets[idx]), ti.types[idx].id};
        text("%v", name);
        if is_item_hovered() {
            _print_tooltip(a);
        }

        next_column();
        edit_value(a);
        next_column();
    }
}

struct_editor :: proc(data : any, read_only : bool) {
    _ti := runtime.type_info_base(type_info_of(data.id));
    ti, is_struct := _ti.variant.(runtime.Type_Info_Struct);
    str := fmt.aprintf("Struct Editor: %s", _get_name(data));

    begin(str);
    if !is_struct {
        text("You did not pass a struct to the editor...");
    } else {
        print_struct(data);
    }

    columns(1);

    if collapsing_header("Fmt print") {
        text("%#v", data);
    }

    separator();
    end();
}
