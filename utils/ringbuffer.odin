package utils

Ring_Buffer :: struct(T: typeid, N: int) {
	data: [N]T,
	head: int
}

ring_buffer_make :: proc($T: typeid, $N: int) -> Ring_Buffer(T, N) {
	buffer: Ring_Buffer(T, N);
	buffer.head = -1;
	return buffer;
}

ring_buffer_push :: proc(buffer: ^Ring_Buffer($T, $N), value: T) {
	next := buffer.head + 1;
	if next == len(buffer.data) do next = 0;
	buffer.data[next] = value;
	buffer.head = next;
}

ring_buffer_fill :: proc(buffer: ^Ring_Buffer($T, $N), value: T) {
	for i in 0..<len(buffer.data) do buffer.data[i] = value;
}
