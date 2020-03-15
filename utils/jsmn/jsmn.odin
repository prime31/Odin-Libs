package jsmn

import "core:fmt"
import "core:os"

// port of the fantastic jsmn: https://github.com/zserge/jsmn
// includes some additions such as a non-strict mode that doesnt require commas

Kind :: enum {
	Undefined,
	Object,
	Array,
	String,
	Number,
	Bool,
	Null
}

Error :: enum {
	No_Error = 0,
	No_Memory = -1,			// Not enough tokens were provided
	Invalid_Char = -2,		// Invalid character inside JSON string
	Partial_Packet = -3		// The string is not a full JSON packet, more bytes expected
}

Token :: struct {
	kind: Kind,
	start: i32,
	end: i32,
	size: i32,
	parent: i32
}

Parser :: struct {
	strict: bool,			// strict or non-strict parsing
	tokens: [dynamic]Token,	// array of tokens found while parsing
	pos: int,				// offset in the JSON string
	toknext: i32,			// next token to allocate
	toksuper: i32			// superior token node, e.g. parent object or array
}


parser :: proc(strict: bool = false) -> Parser {
	return Parser{
		strict = strict,
		tokens = make([dynamic]Token, 0, 1000, context.temp_allocator) // TODO: necessary to make() this manually? should we use the temp allocator?
	};
}

free :: proc(parser: Parser) {
	delete(parser.tokens);
}

// Parse JSON string and fills Parser.tokens with all the tokens found
parse :: proc(parser: ^Parser, js: []byte) -> Error {
	// reset state
	clear(&parser.tokens);
	parser.toknext = 0;
	parser.toksuper = -1;
	count := 0;

	for parser.pos = 0; parser.pos < len(js); parser.pos += 1 {
		c := js[parser.pos];
		switch c {
			case '{', '[': {
				count += 1;
				token := Token{
					start = -1,
					end = -1,
					parent = -1
				};

				if parser.toksuper != -1 {
					t := &parser.tokens[parser.toksuper];
					if parser.strict {
						// In strict mode an object or array can't become a key
						if t.kind == .Object {
							return .Invalid_Char;
						}
					}

					t.size += 1;
					token.parent = parser.toksuper;
				}
				token.kind = c == '{' ? .Object : .Array;
				token.start = cast(i32)parser.pos;

				append(&parser.tokens, token);
				parser.toknext += 1;
				parser.toksuper = parser.toknext - 1;
			}
			case '}', ']': {
				kind := c == '}' ? Kind.Object : Kind.Array;

				if parser.toknext < 1 {
					return .Invalid_Char;
				}

				token := &parser.tokens[parser.toknext - 1];
				for {
					if token.start != -1 && token.end == -1 {
						if token.kind != kind {
							return .Invalid_Char;
						}
						token.end = cast(i32)parser.pos + 1;
						parser.toksuper = token.parent;
						break;
					}

					if token.parent == -1 {
						if token.kind != kind || parser.toksuper == -1 {
							return .Invalid_Char;
						}
						break;
					}
					token = &parser.tokens[token.parent];
				}
			}
			case '"': {
				r := parse_string(parser, js);
				if r != .No_Error {
					return r;
				}
				count += 1;
				if parser.toksuper != -1 {
					parser.tokens[parser.toksuper].size += 1;
				}
			}
			case '\t', '\r', ' ': {}
			case '\n': {
				// if we are not strict and we hit an EOL we do exactly as we would with a ',' because commas are optional
				if !parser.strict {
					if parser.toksuper != -1 && parser.tokens[parser.toksuper].kind != .Array && parser.tokens[parser.toksuper].kind != .Object {
						parser.toksuper = parser.tokens[parser.toksuper].parent;
					}
				}
			}
			case ':': {
				parser.toksuper = parser.toknext - 1;
			}
			case ',': {
				if parser.toksuper != -1 && parser.tokens[parser.toksuper].kind != .Array && parser.tokens[parser.toksuper].kind != .Object {
					parser.toksuper = parser.tokens[parser.toksuper].parent;
				}
			}
			case '-', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 't', 'f', 'n': {
				// In strict mode primitives are: numbers and booleans
				// And they must not be keys of the object
				if parser.strict {
					if parser.toksuper != -1 {
						t := &parser.tokens[parser.toksuper];

						if t.kind == .Object || (t.kind == .String && t.size != 0) {
							return .Invalid_Char;
						}
					}
				}

				r := parse_primitive(parser, js);
				if r != .No_Error {
					return r;
				}
				count += 1;
				if parser.toksuper != -1 {
					parser.tokens[parser.toksuper].size += 1;
				}
			}
			case: {
				// In non-strict mode every unquoted value is a primitive
				if !parser.strict {
					r := parse_primitive(parser, js);
					if r != .No_Error {
						return r;
					}
					count += 1;
					if parser.toksuper != -1 {
						parser.tokens[parser.toksuper].size += 1;
					}
				} else {
					// unexpected char in strict mode
					return .Invalid_Char;
				}
			}
		} // end match
	} // end for

	return .No_Error;
}

// Fills next token with JSON string
@(private)
parse_string :: proc(parser: ^Parser, js: []byte) -> Error {
	start := cast(i32)parser.pos;
	parser.pos += 1;

	// skip starting quote
	for ; parser.pos < len(js); parser.pos += 1 {
		c := js[parser.pos];

		// Quote: end of string
		if c == '"' {
			append(&parser.tokens, Token{
				kind = .String,
				start = start + 1,
				end = cast(i32)parser.pos,
				parent = parser.toksuper
			});
			parser.toknext += 1;
			return .No_Error;
		}

		// Backslash: Quoted symbol expected
		if c == '/' && parser.pos + 1 < len(js) {
			i := 0;
			parser.pos += 1;

			switch js[parser.pos] {
				// allowed escaped symbols
				case '"', '/', '\\', 'b', 'f', 'n', 't': { break; }
				// allows escaped symbol \uXXXX
				case 'u': {
					parser.pos += 1;
					for i = 0; i < 4 && parser.pos < len(js); i += 1 {
						// If it isn't a hex character we have an error
						if (js[parser.pos] >= 48 && js[parser.pos] <= 57) ||
							(js[parser.pos] >= 65 && js[parser.pos] <= 70) ||
							(js[parser.pos] >= 97 && js[parser.pos] <= 102) {
								parser.pos += 1;
								return .Invalid_Char;
						}
						parser.pos += 1;
					}
					parser.pos -= 1;
				}
				case: {
					// unexpected symbol
					parser.pos = cast(int)start;
					return .Invalid_Char;
				}
			} // end switch
		} // end if
	} // end for

	parser.pos = cast(int)start;
	return .Partial_Packet;
}

@(private)
parse_primitive :: proc(parser: ^Parser, js: []byte) -> Error {
	start := cast(i32)parser.pos;
	non_strict_key := false;
	broke_loop := false;

	loop: for ; parser.pos < len(js); parser.pos += 1 {
		// In strict mode primitive must be followed by "," or "}" or "]". ":" is not allowed
		switch js[parser.pos] {
			case '\t', '\n', ' ', ',', ']', '}': { broke_loop = true; break loop; }
			case ':': {
				if !parser.strict {
					// if the next char is a ":" this is a key so we will set it as a string kind
					non_strict_key = true;
					broke_loop = true; break loop;
				}
			}
		}
	}

	if !broke_loop {
		if js[parser.pos] < 32 || js[parser.pos] >= 127 {
			parser.pos = cast(int)start;
			return .Invalid_Char;
		}

		if parser.strict {
			// In strict mode primitive must be followed by a comma/object/array
			parser.pos = cast(int)start;
			return .Partial_Packet;
		}
	}

	kind := Kind.Undefined;
	switch js[start] {
		case '-', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9': {
			kind = .Number;
		}
		case 't', 'f': { kind = .Bool; }
		case: { kind = .Null; }
	}

	// override the kind
	if !parser.strict && non_strict_key {
		kind = .String;
	}

	append(&parser.tokens, Token{
		kind = kind,
		start = start,
		end = cast(i32)parser.pos,
		parent = parser.toksuper
	});
	parser.toknext += 1;
	parser.pos -= 1;

	return .No_Error;
}

