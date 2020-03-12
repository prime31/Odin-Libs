package main

import "core:fmt"
import "core:mem"
import "shared:engine/libs/flecs"


V2 :: struct {
    x: f32,
    y: f32
}

main :: proc() {
    world := flecs.init();

    v2_entity := flecs.new_component(world, "V2", size_of(V2));
    flecs.new_system(world, "some system", .On_Update, "V2", move);

    e1 := flecs.new_entity(world, "e1", "V2");

    pos := V2{65, 75};
    c1 := flecs.set_ptr(world, e1, v2_entity, size_of(V2), &pos);

    flecs.progress(world, 0.016);
}

move :: proc "c" (rows: ^flecs.Rows) {
    velocities := flecs.col(V2, rows, 1);
    for i: u32 = 0; i < rows.count; i += 1 {
        vel := velocities[cast(int)i];
        fmt.println("vel[", i, "]", vel);
    }
}
