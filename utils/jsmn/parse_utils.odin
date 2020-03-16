package jsmn

import "core:mem"
import "core:strings"
import "core:strconv"


token_as_string :: proc(token: ^Token, data: []byte) -> string {
	return strings.string_from_ptr(&data[token.start], int(token.end - token.start));
}

token_as_int :: proc(token: ^Token, data: []byte) -> int {
	return strconv.parse_int(token_as_string(token, data));
}

token_as_i32 :: proc(token: ^Token, data: []byte) -> i32 {
	//str := transmute(string)mem.Raw_String{&data[token.start], int(token.end - token.start)};
	str := string(data[token.start:token.end]);
	return cast(i32)strconv.parse_i64(str);
	// TODO: why so slow!
	// return token.end - token.start;
	// raw := mem.Raw_String{&data[token.start], int(token.end - token.start)};
	// return 1;
	// return cast(i32)strconv.parse_i64(token_as_string(token, data));
}

token_as_f32 :: proc(token: ^Token, data: []byte) -> f32 {
	return strconv.parse_f32(token_as_string(token, data));
}

// checks to see if a .string token is equal to str
token_eq_string :: proc(token: ^Token, data: []byte, str: string) -> bool {
	if token.kind != .String || len(str) != int(token.end - token.start) {
		return false;
	}

	return mem.compare_byte_ptrs(&data[token.start], &data[token.start], int(token.end - token.start)) == 0;
}

// return next token, ignoring descendants
skip_token :: proc(token: ^Token) -> ^Token {
	tok := token;
	pending := 1;
	for pending > 0 {
		pending += cast(int)tok.size - 1;
		tok = mem.ptr_offset(tok, 1);
	}

	return tok;
}

// find the first member with the given name
object_get_member :: proc(data: []byte, object: ^Token, name: string) -> ^Token {
	if object == nil || object.kind != .Object {
		return nil;
	}

	members := object.size;
	token := mem.ptr_offset(object, 1);
	for members > 0 && !token_eq_string(token, data, name) {
		members -= 1;
		token = skip_token(mem.ptr_offset(token, 1));
	}

	if members == 0 {
		return nil;
	}
	return mem.ptr_offset(token, 1);
}

// find the element at the given position of an array (starting at 0)
array_get_at :: proc(arr: ^Token, index: i32) -> ^Token {
	if arr == nil || arr.kind != .Array || index < 0 || arr.size <= index {
		return nil;
	}

	token := mem.ptr_offset(arr, 1);
	for i := cast(i32)0; i < index; i += 1 {
		token = skip_token(token);
	}
	return token;
}
