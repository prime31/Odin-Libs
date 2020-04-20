package fontstash

when ODIN_OS == "darwin" do foreign import fs "native/libfontstash.a";

@(default_calling_convention="c")
foreign fs {
	// Contructor and destructor.
    @(link_name = "fonsCreateInternal")
    create_internal :: proc(params: ^Params) -> ^Context ---;

    @(link_name = "fonsDeleteInternal")
    delete_internal :: proc(ctx: ^Context) ---;

    @(link_name = "fonsSetErrorCallback")
    set_error_callback :: proc(ctx: ^Context, unamed0: #type proc "c" (uptr: rawptr, error, val: i32), uptr: rawptr) ---;

    @(link_name = "fonsGetAtlasSize")
    get_atlas_size :: proc(ctx: ^Context, width: ^i32, height: ^i32) ---;

    @(link_name = "fonsExpandAtlas")
    expand_atlas:: proc(ctx: ^Context, width: i32, height: i32) -> i32 ---;

    @(link_name = "fonsResetAtlas")
    reset_atlas:: proc(stash: ^Context, width: i32, height: i32) -> i32 ---;

    // Add/manage fonts
    @(link_name = "fonsGetFontByName")
    get_font_by_name :: proc(ctx: ^Context, name: cstring) -> i32 ---;

    @(link_name = "fonsAddFontMem")
    add_font_mem :: proc(ctx: ^Context, name: cstring, data: rawptr, dataSize: i32, freeData: i32) -> i32 ---;

    @(link_name = "fonsAddFallbackFont")
    add_fallback_font :: proc(stash: ^Context, base: i32, fallback: i32) -> i32 ---;

    // State handling
    @(link_name = "fonsPushState")
    push_state :: proc(ctx: ^Context) ---;

    @(link_name = "fonsPopState")
    pop_state :: proc(ctx: ^Context) ---;

    @(link_name = "fonsClearState")
    clear_state :: proc(ctx: ^Context) ---;

    // State setting
    @(link_name = "fonsSetSize")
    set_size :: proc(ctx: ^Context, size: f32) ---;

    @(link_name = "fonsSetColor")
    set_color :: proc(ctx: ^Context, color: u32) ---;

    @(link_name = "fonsSetSpacing")
    set_spacing :: proc(ctx: ^Context, spacing: f32) ---;

    @(link_name = "fonsSetBlur")
    set_blur :: proc(ctx: ^Context, blur: f32) ---;

    @(link_name = "fonsSetAlign")
    set_align :: proc(ctx: ^Context, align: i32) ---;

    @(link_name = "fonsSetFont")
    set_font :: proc(ctx: ^Context, font: i32) ---;

    // Draw text
    @(link_name = "fonsDrawText")
    draw_text :: proc(ctx: ^Context, x: f32, y: f32, str: cstring, end: cstring) -> f32 ---;

    // Measure text
    @(link_name = "fonsTextBounds")
    text_boundctx:: proc(ctx: ^Context, x: f32, y: f32, str: cstring, end: cstring, boundctx: ^f32) -> f32 ---;

    @(link_name = "fonsLineBounds")
    line_boundctx:: proc(ctx: ^Context, y: f32, miny: ^f32, maxy: ^f32) ---;

    @(link_name = "fonsVertMetrics")
    vert_metricctx:: proc(ctx: ^Context, ascender: ^f32, descender: ^f32, lineh: ^f32) ---;

    // Text iterator
    @(link_name = "fonsTextIterInit")
    text_iter_init :: proc(stash: ^Context, iter: ^Text_Iter, x: f32, y: f32, str: cstring, end: cstring) -> i32 ---;

    @(link_name = "fonsTextIterNext")
    text_iter_next :: proc(stash: ^Context, iter: ^Text_Iter, quad: ^Quad) -> i32 ---;

    // Pull texture changes
    @(link_name = "fonsGetTextureData")
    get_texture_data :: proc(stash: ^Context, width: ^i32, height: ^i32) -> ^byte ---;

    @(link_name = "fonsValidateTexture")
    validate_texture :: proc(ctx: ^Context, dirty: ^i32) -> i32 ---;

    // Draws the stash texture for debugging
    @(link_name = "fonsDrawDebug")
    draw_debug :: proc(ctx: ^Context, x: f32, y: f32) ---;
}

