package fontstash

when ODIN_OS == "darwin" do foreign import fs "native/libfontstash.a";

@(default_calling_convention="c")
foreign fs {
	// Contructor and destructor.
    @(link_name = "fonsCreateInternal")
    create_internal :: proc(params : ^Params) -> ^Context ---;

    @(link_name = "fonsDeleteInternal")
    delete_internal :: proc(s : ^Context) ---;

    @(link_name = "fonsSetErrorCallback")
    set_error_callback :: proc(s : ^Context, unamed0 : #type proc(), uptr : rawptr) ---;

    @(link_name = "fonsGetAtlasSize")
    get_atlas_size :: proc(s : ^Context, width : ^_c.int, height : ^_c.int) ---;

    @(link_name = "fonsExpandAtlas")
    expand_atlas :: proc(s : ^Context, width : _c.int, height : _c.int) -> _c.int ---;

    @(link_name = "fonsResetAtlas")
    reset_atlas :: proc(stash : ^Context, width : _c.int, height : _c.int) -> _c.int ---;

    // Add/manage fonts
    @(link_name = "fonsGetFontByName")
    get_font_by_name :: proc(s : ^Context, name : cstring) -> _c.int ---;

    @(link_name = "fonsAddFallbackFont")
    add_fallback_font :: proc(stash : ^Context, base : _c.int, fallback : _c.int) -> _c.int ---;

    // State handling
    @(link_name = "fonsPushState")
    push_state :: proc(s : ^Context) ---;

    @(link_name = "fonsPopState")
    pop_state :: proc(s : ^Context) ---;

    @(link_name = "fonsClearState")
    clear_state :: proc(s : ^Context) ---;

    // State setting
    @(link_name = "fonsSetSize")
    set_size :: proc(s : ^Context, size : _c.float) ---;

    @(link_name = "fonsSetColor")
    set_color :: proc(s : ^Context, color : _c.uint) ---;

    @(link_name = "fonsSetSpacing")
    set_spacing :: proc(s : ^Context, spacing : _c.float) ---;

    @(link_name = "fonsSetBlur")
    set_blur :: proc(s : ^Context, blur : _c.float) ---;

    @(link_name = "fonsSetAlign")
    set_align :: proc(s : ^Context, align : _c.int) ---;

    @(link_name = "fonsSetFont")
    set_font :: proc(s : ^Context, font : _c.int) ---;

    // Draw text
    @(link_name = "fonsDrawText")
    draw_text :: proc(s : ^Context, x : _c.float, y : _c.float, str : cstring, end : cstring) -> _c.float ---;

    // Measure text
    @(link_name = "fonsTextBounds")
    text_bounds :: proc(s : ^Context, x : _c.float, y : _c.float, str : cstring, end : cstring, bounds : ^_c.float) -> _c.float ---;

    @(link_name = "fonsLineBounds")
    line_bounds :: proc(s : ^Context, y : _c.float, miny : ^_c.float, maxy : ^_c.float) ---;

    @(link_name = "fonsVertMetrics")
    vert_metrics :: proc(s : ^Context, ascender : ^_c.float, descender : ^_c.float, lineh : ^_c.float) ---;

    // Text iterator
    @(link_name = "fonsTextIterInit")
    text_iter_init :: proc(stash : ^Context, iter : ^TextIter, x : _c.float, y : _c.float, str : cstring, end : cstring) -> _c.int ---;

    @(link_name = "fonsTextIterNext")
    text_iter_next :: proc(stash : ^Context, iter : ^TextIter, quad : ^Quad) -> _c.int ---;

    // Pull texture changes
    @(link_name = "fonsGetTextureData")
    get_texture_data :: proc(stash : ^Context, width : ^_c.int, height : ^_c.int) -> ^_c.uchar ---;

    @(link_name = "fonsValidateTexture")
    validate_texture :: proc(s : ^Context, dirty : ^_c.int) -> _c.int ---;

    // Draws the stash texture for debugging
    @(link_name = "fonsDrawDebug")
    draw_debug :: proc(s : ^Context, x : _c.float, y : _c.float) ---;
}

