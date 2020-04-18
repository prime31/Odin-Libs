package utils

import "core:fmt"
Ring_Buffer :: struct(T: typeid, N: int) {
	data: [N+1]T,
	head: int,
	tail: int
}

ring_buffer_make :: proc($T: typeid, $N: int) -> Ring_Buffer(T, N) {
	buffer: Ring_Buffer(T, N);
	return buffer;
}

ring_buffer_push :: proc(buffer: ^Ring_Buffer($T, $N), value: T) -> bool {
	next := buffer.head + 1;
	if next >= len(buffer.data) do next = 0;
	if next == buffer.tail do return false;

	buffer.data[buffer.head] = value;
	buffer.head = next;
	return true;
}

ring_buffer_pop :: proc(buffer: ^Ring_Buffer($T, $N)) -> T {
	// if the head == tail, we don't have any data
	if buffer.head == buffer.tail {
		ret: T;
		return ret;
	}

	next := buffer.tail + 1;
	if next >= len(buffer.data) do next = 0;

	ret := buffer.data[buffer.tail];
	buffer.tail = next;
	return ret;
}

ring_buffer_fill :: proc(buffer: ^Ring_Buffer($T, $N), value: T) {
	for i in 0..<len(buffer.data) do ring_buffer_push(buffer, value);
}

