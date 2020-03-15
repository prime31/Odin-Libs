package tilemap

Tile_Id :: i32;

id :: proc(t: Tile_Id) -> i32 { return t & ~(FLIPPED_H | FLIPPED_V | FLIPPED_D); }

transformed :: proc(t: Tile_Id) -> bool { return t > FLIPPED_D; }

empty :: proc(t: Tile_Id) -> bool { return t < 0; }

flipped_h :: proc(t: Tile_Id) -> bool { return (t & FLIPPED_H) != 0; }

flipped_v :: proc(t: Tile_Id) -> bool { return (t & FLIPPED_V) != 0; }

flipped_d :: proc(t: Tile_Id) -> bool { return (t & FLIPPED_D) != 0; }
