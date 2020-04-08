package imgui

import "shared:engine/libs/sdl"

when ODIN_OS == "windows" do foreign import imgui_impl "native/imgui_impl.lib";
// when ODIN_OS == "linux" do foreign import imgui_impl "";
// when ODIN_OS == "darwin" do foreign import imgui_impl "native/libimgui_impl.a";
when ODIN_OS == "darwin" do foreign import imgui_impl "native/libimgui_impl.dylib";


@(default_calling_convention="c")
foreign imgui_impl {
	// SDL2
    ImGui_ImplSDL2_InitForOpenGL :: proc(window: ^sdl.Window, gl_context: rawptr) -> bool ---;
    ImGui_ImplSDL2_ProcessEvent :: proc(event: ^sdl.Event) -> bool ---;
    ImGui_ImplSDL2_NewFrame :: proc(window: ^sdl.Window) ---;
    ImGui_ImplSDL2_Shutdown :: proc() ---;

    // OpenGL 3
    ImGui_ImplOpenGL3_Init :: proc(glsl_version: cstring) -> bool ---;
    ImGui_ImplOpenGL3_NewFrame :: proc() ---;
    ImGui_ImplOpenGL3_RenderDrawData :: proc(draw_data: ^DrawData) ---;
    ImGui_ImplOpenGL3_Shutdown :: proc() ---;
}



// ImGui lifecycle helpers, wrapping ImGui, SDL2 Impl and GL Impl methods
// BEFORE calling init_for_gl a gl loader lib must be called! You must use the same one
// used in the makefile when imgui was compiled!
impl_init_for_gl :: proc(glsl_version: cstring, window: ^sdl.Window, gl_context: rawptr) {
	create_context();
	ImGui_ImplSDL2_InitForOpenGL(window, gl_context);
	ImGui_ImplOpenGL3_Init(glsl_version);
}

impl_new_frame :: proc(window: ^sdl.Window) {
	ImGui_ImplOpenGL3_NewFrame();
	ImGui_ImplSDL2_NewFrame(window);
	new_frame();
}

impl_render :: proc() {
	ImGui_ImplOpenGL3_RenderDrawData(get_draw_data());
}

impl_shutdown :: proc() {
	ImGui_ImplOpenGL3_Shutdown();
	ImGui_ImplSDL2_Shutdown();
	destroy_context();
}


// returns true if the event is handled by imgui and should be ignored
impl_handle_event :: proc(evt: ^sdl.Event) -> bool {
	if ImGui_ImplSDL2_ProcessEvent(evt) {
		#partial switch evt.type {
			case .Mouse_Wheel, .Mouse_Button_Down: { return get_io().want_capture_mouse; }
			case .Text_Input, .Key_Down, .Key_Up: { return get_io().want_capture_keyboard; }
			case .Window_Event: { return true }
			case: { return false }
		}
	}
	return false;
}
