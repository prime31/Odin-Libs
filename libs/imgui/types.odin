package imgui

import "core:mem";

////////////////////////////
// Types
ID        :: distinct u32;
DrawIdx   :: distinct u16;
Wchar     :: distinct u16;
TextureID :: distinct rawptr;

///////////////////////////
// DUMMY STRUCTS
Context            :: struct {}
DrawListSharedData :: struct {}

///////////////////////////
// Actual structs
Nav_Layer :: enum i32 {
	Main = 0,
	Menu = 1,
	Count = 2
}

Vec1 :: struct {
	x: f32
}

Vec2 :: struct {
	x : f32,
	y : f32,
}

Vec4 :: struct {
	x : f32,
	y : f32,
	z : f32,
	w : f32,
}

Rect :: struct {
	min: Vec2,
	max: Vec2
}

Menu_Columns :: struct {
	spacing: f32,
	width: f32,
	next_width: f32,
	pos: [3]f32,
	next_widths: [3]f32
}

Axis :: enum i32 {
	None = -1,
	X = 0,
	Y = 1
}

Dock_Node_State :: enum i32 {
	Unknown,
	Host_Window_Hidden_Because_Single_Window,
	Host_Window_Hidden_Because_Windows_Are_Resizing,
	Host_Window_Visible
}

Style :: struct {
	alpha                     : f32,
	window_padding            : Vec2,
	window_rounding           : f32,
	window_border_size        : f32,
	window_min_size           : Vec2,
	window_title_align        : Vec2,
	child_rounding            : f32,
	child_border_size         : f32,
	popup_rounding            : f32,
	popup_border_size         : f32,
	frame_padding             : Vec2,
	frame_rounding            : f32,
	frame_border_size         : f32,
	item_spacing              : Vec2,
	item_inner_spacing        : Vec2,
	touch_extra_padding       : Vec2,
	indent_spacing            : f32,
	columns_min_spacing       : f32,
	scrollbar_size            : f32,
	scrollbar_rounding        : f32,
	grab_min_size             : f32,
	grab_rounding             : f32,
	button_text_align         : Vec2,
	display_window_padding    : Vec2,
	display_safe_area_padding : Vec2,
	mouse_cursor_scale        : f32,
	aa_lines                  : bool,
	aa_fill                   : bool,
	curve_tessellation_tol    : f32,
	colors                    : [Style_Color.COUNT]Vec4,
}

IO :: struct {
	config_flags                     : Config_Flags,
	backend_flags                    : Backend_Flags,
	display_size                     : Vec2,
	delta_time                       : f32,
	ini_saving_rate                  : f32,
	ini_filename                     : cstring,
	log_filename                     : cstring,
	mouse_double_click_time          : f32,
	mouse_double_click_max_dist      : f32,
	mouse_drag_threshold             : f32,
	key_map                          : [Key.COUNT]i32,
	key_repeat_delay                 : f32,
	key_repeat_rate                  : f32,
	user_data                        : rawptr,

	fonts                            : ^FontAtlas,
	font_global_scale                : f32,
	font_allow_user_scaling          : bool,
	font_default                     : ^Font,
	display_framebuffer_scale        : Vec2,

	// Docking options (when ImGuiConfigFlags_DockingEnable is set)
	config_docking_no_split            : bool,
	config_docking_with_shift          : bool,
	config_docking_always_tab_bar      : bool,
	config_docking_transparent_payload : bool,

	// Viewport options (when ImGuiConfigFlags_ViewportsEnable is set)
	config_viewports_no_auto_merge      : bool,
	config_viewportsno_task_bar_icon    : bool,
	config_viewports_no_decoration      : bool,
	config_viewports_no_default_parent  : bool,

	// Miscellaneous options
	mouse_draw_cursor                : bool,
	config_mac_osx_behaviors         : bool,
	config_input_text_cursor_blink   : bool,
	config_windows_resize_from_edges : bool,
	config_windows_move_from_title_bar_only : bool,
	ConfigWindowsMemoryCompactTimer	 : f32,

	// Platform Functions
    BackendPlatformName				 : cstring,
    BackendRendererName				 : cstring,
    BackendPlatformUserData			 : rawptr,
    BackendRendererUserData			 : rawptr,
    BackendLanguageUserData			 : rawptr,

    // Optional: Access OS clipboard
	get_clipboard_text_fn            : proc "c" (user_data: rawptr) -> cstring,
	set_clipboard_text_fn            : proc "c" (user_data: rawptr, text: cstring),
	clipboard_user_data              : rawptr,

	render_draw_lists_fn_unused      : rawptr, // obsolete

	// Input - Fill before calling NewFrame()
	mouse_pos                        : Vec2,
	mouse_down                       : [5]bool,
	mouse_wheel                      : f32,
	mouse_wheel_h                    : f32,
	mouse_hovered_viewport			 : ID,
	key_ctrl                         : bool,
	key_shift                        : bool,
	key_alt                          : bool,
	key_super                        : bool,
	keys_down                        : [512]bool,
	nav_inputs                       : [Nav_Input.COUNT]f32,

	// Output - Updated by NewFrame() or EndFrame()/Render()
	want_capture_mouse               : bool,
	want_capture_keyboard            : bool,
	want_text_input                  : bool,
	want_set_mouse_pos               : bool,
	want_save_ini_settings           : bool,
	nav_active                       : bool,
	nav_visible                      : bool,
	framerate                        : f32,
	metrics_render_vertices          : i32,
	metrics_render_indices           : i32,
	metrics_render_windows           : i32,
	metrics_active_windows           : i32,
	metrics_active_allocations       : i32,
	mouse_delta                      : Vec2,

	// [Internal] Dear ImGui will maintain those fields. Forward compatibility not guaranteed!
	key_mods 						 : Key_Mod_Flags,
	mouse_pos_prev                   : Vec2,
	mouse_clicked_pos                : [5]Vec2,
	mouse_clicked_time               : [5]f64,
	mouse_clicked                    : [5]bool,
	mouse_double_clicked             : [5]bool,
	mouse_released                   : [5]bool,
	mouse_down_owned                 : [5]bool,
	mouse_down_duration              : [5]f32,
	mouse_down_duration_prev         : [5]f32,
	mouse_drag_max_distance_abs      : [5]Vec2,
	mouse_drag_max_distance_sqr      : [5]f32,
	keys_down_duration               : [512]f32,
	keys_down_duration_prev          : [512]f32,
	nav_inputs_down_duration         : [Nav_Input.COUNT]f32,
	nav_inputs_down_duration_prev    : [Nav_Input.COUNT]f32,
	input_queue_characters           : ImVector(Wchar)
}

ImVector :: struct(T : typeid) {
	size     : i32,
	capacity : i32,
	data     : ^T,
}

ImNewDummy :: struct {} //TODO(Hoej): ?????

OnceUponAFrame :: struct {
	ref_frame : i32,
}

TextFilter :: struct {
	input_buf  : [256]byte,
	filters    : ImVector(TextRange), //<TextRange>
	count_grep : i32,
}

TextBuffer :: struct {
	buf : ImVector(byte), // <char>
}

Storage :: struct
{
	data : ImVector(Pair), // <Pair>
}

InputTextCallbackData :: struct {
	event_flag      : Input_Text_Flags,
	flags           : Input_Text_Flags,
	user_data       : rawptr,
	event_char      : Wchar,
	event_key       : Key,
	buf             : ^byte,
	buf_text_len    : i32,
	buf_size        : i32,
	buf_dirty       : bool,
	cursor_pos      : i32,
	selection_start : i32,
	selection_end   : i32,
}

SizeCallbackData :: struct {
	user_data    : rawptr,
	pos          : Vec2,
	current_size : Vec2,
	desired_size : Vec2,
}

Payload :: struct {
	data             : rawptr,
	data_size        : i32,
	source_id        : ID,
	source_parent_id : ID,
	data_frame_count : i32,
	data_type        : [32+1]byte,
	preview          : bool,
	delivery         : bool,
}

Color :: struct {
	value : Vec4,
}

ListClipper :: struct {
	start_pos_y   : f32,
	items_height  : f32,
	items_count   : i32,
	step_no       : i32,
	display_start : i32,
	display_end   : i32,
}

DrawCmd :: struct {
	elem_count         : u32,
	clip_rect          : Vec4,
	texture_id         : TextureID,
	vtx_offset         : u32,
	idx_offset         : u32,
	user_callback      : Draw_Callback,
	user_callback_data : rawptr,
}

DrawVert :: struct {
	pos : Vec2,
	uv  : Vec2,
	col : u32,
}

DrawChannel :: struct {
	cmd_buffer : ImVector(DrawCmd), // <ImDrawCmd>
	idx_buffer : ImVector(DrawIdx), // <ImDrawIdx>
}

DrawList :: struct {
	cmd_buffer        : ImVector(DrawCmd), // <ImDrawCmd>
	idx_buffer        : ImVector(DrawIdx), // <ImDrawIdx>
	vtx_buffer        : ImVector(DrawVert), // <ImDrawVert>
	flags             : Draw_List_Flags,
	_data             : ^DrawListSharedData,
	_owner_name       : cstring,
	_vtx_current_offset : u32,
	_vtx_current_idx  : u32,
	_vtx_write_ptr    : ^DrawVert,
	_idx_write_ptr    : ^DrawIdx,
	_clip_rect_stack  : ImVector(Vec4), // <ImVec4>
	_texture_id_stack : ImVector(TextureID), // <ImTextureID>
	_path             : ImVector(Vec2), // <ImVec2>
	// _splitter         : DrawListSplitter, // below fields are from this struct
	_channels_current : i32,
	_channels_count   : i32,
	_channels         : ImVector(DrawChannel), // <ImDrawChannel>
}

DrawData :: struct {
	valid           : bool,
	cmd_lists       : ^^DrawList,
	cmd_lists_count : i32,
	total_idx_count : i32,
	total_vtx_count : i32,
	display_pos     : Vec2,
	display_size    : Vec2,
}

FontConfig :: struct {
	font_data                : rawptr,
	font_data_size           : i32,
	font_data_owned_by_atlas : bool,
	font_no                  : i32,
	size_pixels              : f32,
	oversample_h             : i32,
	oversample_v             : i32,
	pixel_snap_h             : bool,
	glyph_extra_spacing      : Vec2,
	glyph_offset             : Vec2,
	glyph_ranges             : ^Wchar,
	glyph_min_advance_x      : f32,
	glyph_max_advance_x      : f32,
	merge_mode               : bool,
	rasterizer_flags         : u32,
	rasterizer_multiply      : f32,
	name                     : [40]byte,
	dst_font                 : ^Font,
}

FontGlyph :: struct {
	Codepoint      : Wchar
	AdvanceX       : f32,
	X0, Y0, X1, Y1 : f32,
	U0, V0, U1, V1 : f32
}

FontAtlas :: struct {
	locked             : bool,
	flags              : Font_Atlas_Flags,
	tex_id             : TextureID,
	tex_desired_width  : i32,
	tex_glyph_padding  : i32,
	tex_pixels_alpha8  : ^byte,
	tex_pixels_rgba32  : ^u32,
	tex_width          : i32,
	tex_height         : i32,
	tex_uv_scale       : Vec2,
	tex_uv_white_pixel : Vec2,
	fonts              : ImVector(^Font),
	custom_rects       : ImVector(CustomRect),
	config_data        : ImVector(FontConfig),
	custom_rect_ids    : [1]i32,
}

Font :: struct {
	font_size             : f32,
	scale                 : f32,
	display_offset        : Vec2,
	glyphs                : ImVector(FontGlyph),
	index_advance_x       : ImVector(f32),
	index_lookup          : ImVector(u32),
	fallback_glyph        : ^FontGlyph,
	fallback_advance_x    : f32,
	fallback_char         : Wchar,
	config_data_count     : i16,
	config_data           : ^FontConfig,
	container_atlas       : ^FontAtlas,
	ascent                : f32, Descent,
	dirty_lookup_tables   : bool,
	metrics_total_surface : int,
};

GlyphRangesBuilder :: struct{
	used_chars : ImVector(u8),
}

CustomRect :: struct {
	id              : u32,
	width, height   : u32,
	x, y            : u32,
	glyph_advance_x : f32,
	glyph_offset    : Vec2,
	font            : ^Font,
}

TextRange :: struct {
	b: cstring,
	e: cstring,
}

Pair :: struct {
	key : ID,
	using _: struct #raw_union {
		val_i : i32,
		val_f : f32,
		val_p : rawptr,
	}
}

Text_Edit_Callback       :: proc "c" (data : ^InputTextCallbackData) -> i32;
Size_Constraint_Callback :: proc "c" (data : ^SizeCallbackData);
Draw_Callback            :: proc "c" (parent_list : ^DrawList, cmd : ^DrawCmd);


// Docking/Viewports
Draw_Data_Builder :: struct {
	layers: [2]ImVector(DrawList)
}

Platform_IO :: struct {
	create_window: proc "c" (vp: Viewport),
	destroy_window: proc "c" (vp: Viewport),
	show_window: proc "c" (vp: Viewport),
	set_window_position: proc "c" (vp: Viewport, pos: Vec2),
	get_window_position: proc "c" (vp: Viewport) -> Vec2,
	set_window_size: proc "c" (vp: Viewport, pos: Vec2),
	get_window_size: proc "c" (vp: Viewport) -> Vec2,
	set_window_focus: proc "c" (vp: Viewport),
	get_window_focus: proc "c" (vp: Viewport) -> bool,
	get_window_minimized: proc "c" (vp: Viewport) -> bool,
	set_window_title: proc "c" (vp: Viewport, str: cstring),
	set_window_alpha: proc "c" (vp: Viewport, alpha: f32),
	update_window: proc "c" (vp: Viewport),
	render_window: proc "c" (vp: Viewport, render_arg: rawptr),
	swap_buffers: proc "c" (vp: Viewport, render_arg: rawptr)
	// ommitted optional fields
}

Viewport_P :: struct {
	_imguiviewport: Viewport,
	idx: i32,
	last_frame_active: i32,
	last_frame_draw_lists: [2]i32,
	last_front_most_stamp_count: i32,
	last_name_hash: u32,
	last_pos: Vec2,
	alpha: f32,
	last_alpha: f32,
	platform_monitor: i16,
	platform_window_created: bool,
	window: ^Window,
	draw_lists: [2]^DrawList,
	draw_data_p: DrawData,
	draw_data_builder: Draw_Data_Builder,
	last_platform_pos: Vec2,
	last_platform_size: Vec2,
	last_renderer_size: Vec2,
	curr_work_offset_min: Vec2,
	curr_work_offset_max: Vec2
}

Viewport :: struct {
	id: ID,
	flags: i32, // ImGuiViewportFlags
	pos: Vec2,
	size: Vec2,
	work_offset_min: Vec2,
	work_offset_max: Vec2,
	dpi_scale: f32,
	draw_data: ^DrawData,
	parent_viewport_id: ID,
	renderer_user_data: rawptr,
	platform_user_data: rawptr,
	platform_handle: rawptr,
	platform_handle_raw: rawptr,
	platform_request_move: bool,
	platform_request_resize: bool,
	platform_request_close: bool
}

Item_Flags :: enum i32 {
	None = 0,
	No_Tab_Stop = 1,
	Button_Repeat = 2,
	Disabled = 4,
	No_Nav = 8,
	No_Nav_Default_Focus = 16,
	Selectable_Dont_Close_Popup = 32,
	Mixed_Value = 64,
	Default = 0
}

Group_Data :: struct {
	backup_cursor_pos: Vec2,
	backup_cursor_max_pos: Vec2,
	backup_indent: Vec1,
	backup_group_offset: Vec1,
	backup_curr_line_size: Vec2,
	backup_curr_line_text_base_offset: f32,
	backup_active_id_is_alive: u32,
	backup_active_id_previous_frame_is_alive: bool,
	emit_item: bool
}

Vec2_Ih :: struct {
	x: i16,
	y: i16
}

Window :: struct {
	name: cstring,
	id: ID,
	flags: i32,
	flags_previous_frame: i32,
	window_class: Window_Class,
	viewport: ^Viewport_P,
	viewport_id: u32,
	viewport_pos: Vec2,
	viewport_allow_platform_monitor_extend: i32,
	pos: Vec2,
	size: Vec2,
	size_full: Vec2,
	content_size: Vec2,
	content_size_explicit: Vec2,
	window_padding: Vec2,
	window_rounding: f32,
	window_border_size: f32,
	name_buf_len: i32,
	move_id: u32,
	child_id: u32,
	scroll: Vec2,
	scroll_max: Vec2,
	scroll_target: Vec2,
	scroll_target_center_ratio: Vec2,
	scrollbar_sizes: Vec2,
	scrollbar_x: bool,
	scrollbar_y: bool,
	viewport_owned: bool,
	active: bool,
	was_active: bool,
	write_accessed: bool,
	collapsed: bool,
	want_collapse_toggle: bool,
	skip_items: bool,
	appearing: bool,
	hidden: bool,
	is_fallback_window: bool,
	has_close_button: bool,
	resize_border_held: byte,
	begin_count: i16,
	begin_order_within_parent: i16,
	begin_order_within_context: i16,
	popup_id: u32,
	auto_fit_frames_x: byte,
	auto_fit_frames_y: byte,
	auto_fit_child_axises: byte,
	auto_fit_only_grows: bool,
	auto_pos_last_direction: i32,
	hidden_frames_can_skip_items: i32,
	hidden_frames_cannot_skip_items: i32,
	set_window_pos_allow_flags: i32,
	set_window_size_allow_flags: i32,
	set_window_collapsed_allow_flags: i32,
	set_window_dock_allow_flags: i32,
	set_window_pos_val: Vec2,
	set_window_pos_pivot: Vec2,
	id_stack: ImVector(ID),
	dc: Window_Temp_Data,
	outer_rect_clipped: Rect,
	inner_rect: Rect,
	inner_clip_rect: Rect,
	work_rect: Rect,
	clip_rect: Rect,
	content_region_rect: Rect,
	hit_test_hole_size: Vec2_Ih,
	hit_test_hole_offset: Vec2_Ih,
	last_frame_active: i32,
	last_frame_just_focused: i32,
	last_time_active: f32,
	item_width_default: f32,
	state_storage: Storage,
	columns_storage: ImVector(Columns),
	font_window_scale: f32,
	font_dpi_scale: f32,
	settings_offset: i32,
	draw_list: ^DrawList,
	draw_list_inst: DrawList,
	parent_window: ^Window,
	root_window: ^Window,
	root_window_dock_stop: ^Window,
	root_window_for_title_bar_highlight: ^Window,
	root_window_for_nav: ^Window,
	nav_last_child_nav_window: ^Window,
	nav_last_ids: [2]u32,
	nav_rect_rel: [2]Rect,
	memory_compacted: bool,
	memory_draw_list_idx_capacity: i32,
	memory_draw_list_vtx_capacity: i32,
	dock_node: ^Dock_Node,
	dock_node_as_host: ^Dock_Node,
	dock_id: u32,
	dock_tab_item_status_flags: i32,
	dock_tab_item_rect: Rect,
	dock_order: i16,
	dock_is_active: bool,
	dock_tab_is_visible: bool,
	dock_tab_want_close: bool
}

Window_Temp_Data :: struct {
	cursor_pos: Vec2,
	cursor_pos_prev_line: Vec2,
	cursor_start_pos: Vec2,
	cursor_max_pos: Vec2,
	curr_line_size: Vec2,
	prev_line_size: Vec2,
	curr_line_text_base_offset: f32,
	prev_line_text_base_offset: f32,
	indent: Vec1,
	columns_offset: Vec1,
	group_offset: Vec1,
	last_item_id: u32,
	last_item_status_flags: i32,
	last_item_rect: Rect,
	last_item_display_rect: Rect,
	nav_layer_current: Nav_Layer,
	nav_layer_current_mask: i32,
	nav_layer_active_mask: i32,
	nav_layer_active_mask_next: i32,
	nav_focus_scope_id_current: u32,
	nav_hide_highlight_one_frame: bool,
	nav_has_scroll: bool,
	menu_bar_appending: bool,
	menu_bar_offset: Vec2,
	menu_columns: Menu_Columns,
	tree_depth: i32,
	tree_jump_to_parent_on_pop_mask: u32,
	child_windows: ImVector(Window),
	state_storage: ^Storage,
	current_columns: ^Columns,
	layout_type: i32,
	parent_layout_type: i32,
	focus_counter_regular: i32,
	focus_counter_tab_stop: i32,
	item_flags: i32,
	item_width: f32,
	text_wrap_pos: f32,
	item_flags_stack: ImVector(Item_Flags),
	item_width_stack: ImVector(f32),
	text_wrap_pos_stack: ImVector(f32),
	group_stack: ImVector(Group_Data),
	stack_sizes_backup: [6]i16
}

Columns :: struct {
	id: ID,
	flags: i32,
	is_first_frame: bool,
	is_being_resized: bool,
	current: i32,
	count: i32,
	off_min_x: f32,
	off_max_x: f32,
	line_min_y: f32,
	line_max_y: f32,
	host_cursor_pos_y: f32,
	host_cursor_max_pos_x: f32,
	host_clip_rect: Rect,
	host_work_rect: Rect,
	columns: ImVector(Column_Data),
	// splitter         : DrawListSplitter, // below fields are from this struct
	_channels_current : i32,
	_channels_count   : i32,
	_channels         : ImVector(DrawChannel), // <ImDrawChannel>
}

Column_Data :: struct {
	offset_norm: f32,
	offset_norm_before_resize: f32,
	flags: i32,
	clip_rect: Rect
}

Window_Class :: struct {
	class_id: u32,
	parent_viewport_id: u32,
	viewport_flags_override_set: i32,
	viewport_flags_override_clear: i32,
	dock_node_flags_override_set: i32,
	dock_node_flags_override_clear: i32,
	docking_always_tab_bar: bool,
	docking_allow_unclassed: bool
}

Dock_Node :: struct {
	id: ID,
	shared_flags: i32,
	local_flags: i32,
	parent_node: ^Dock_Node,
	child_nodes: [2]^Dock_Node,
	windows: ImVector(Window),
	tab_bar: ^Tab_Bar,
	pos: Vec2,
	size: Vec2,
	size_ref: Vec2,
	split_axis: Axis,
	window_class: Window_Class,
	state: Dock_Node_State,
	host_window: ^Window,
	visible_window: ^Window,
	central_node: ^Dock_Node,
	only_node_with_windows: ^Dock_Node,
	last_frame_alive: i32,
	last_frame_active: i32,
	last_frame_focused: i32,
	last_focused_node_id: u32,
	selected_tab_id: u32,
	want_close_tab_id: u32,
	authority_for_pos: i32,
	authority_for_size: i32,
	authority_for_viewport: i32,
	is_visible: bool,
	is_focused: bool,
	has_close_button: bool,
	has_window_menu_button: bool,
	enable_close_button: bool,
	want_close_all: bool,
	want_lock_size_once: bool,
	want_mouse_move: bool,
	want_hidden_tab_bar_update: bool,
	want_hidden_tab_bar_toggle: bool,
	marked_for_pos_size_write: bool
}

Tab_Bar :: struct {
	tabs: ImVector(Tab_Item),
	id: ID,
	selected_tab_id: u32,
	next_selected_tab_id: u32,
	visible_tab_id: u32,
	curr_frame_visible: i32,
	prev_frame_visible: i32,
	bar_rect: Rect,
	last_tab_content_height: f32,
	offset_max: f32,
	offset_max_ideal: f32,
	offset_next_tab: f32,
	scrolling_anim: f32,
	scrolling_target: f32,
	scrolling_target_dist_to_visibility: f32,
	scrolling_speed: f32,
	flags: i32,
	reorder_request_tab_id: u32,
	reorder_request_dir: byte,
	want_layout: bool,
	visible_tab_was_submitted: bool,
	last_tab_item_idx: i16,
	frame_padding: Vec2,
	tabs_names: Text_Buffer
}

Text_Buffer :: struct {
	buf: ImVector(cstring)
}

Tab_Item :: struct {
	id: ID,
	flags: i32,
	window: ^Window,
	last_frame_visible: i32,
	last_frame_selected: i32,
	name_offset: i32,
	offset: f32,
	width: f32,
	content_width: f32
}
