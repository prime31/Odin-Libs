package imgui;

Window_Flags :: enum i32 {
    None                      = 0,
    NoTitleBar                = 1 << 0,
    NoResize                  = 1 << 1,
    NoMove                    = 1 << 2,
    NoScrollbar               = 1 << 3,
    NoScrollWithMouse         = 1 << 4,
    NoCollapse                = 1 << 5,
    AlwaysAutoResize          = 1 << 6,
    NoSavedSettings           = 1 << 8,
    NoInputs                  = 1 << 9,
    MenuBar                   = 1 << 10,
    HorizontalScrollbar       = 1 << 11,
    NoFocusOnAppearing        = 1 << 12,
    NoBringToFrontOnFocus     = 1 << 13,
    AlwaysVerticalScrollbar   = 1 << 14,
    AlwaysHorizontalScrollbar = 1 << 15,
    AlwaysUseWindowPadding    = 1 << 16,
    NoNavInputs               = 1 << 18,
    NoNavFocus                = 1 << 19,
    NoNav                     = NoNavInputs | NoNavFocus,
    NavFlattened              = 1 << 23,
    ChildWindow               = 1 << 24,
    Tooltip                   = 1 << 25,
    Popup                     = 1 << 26,
    Modal                     = 1 << 27,
    ChildMenu                 = 1 << 28,
    Dock_Node_Host            = 1 << 29
}

Input_Text_Flags :: enum i32 {
    None                = 0,
    CharsDecimal        = 1 << 0,
    CharsHexadecimal    = 1 << 1,
    CharsUppercase      = 1 << 2,
    CharsNoBlank        = 1 << 3,
    AutoSelectAll       = 1 << 4,
    EnterReturnsTrue    = 1 << 5,
    CallbackCompletion  = 1 << 6,
    CallbackHistory     = 1 << 7,
    CallbackAlways      = 1 << 8,
    CallbackCharFilter  = 1 << 9,
    AllowTabInput       = 1 << 10,
    CtrlEnterForNewLine = 1 << 11,
    NoHorizontalScroll  = 1 << 12,
    AlwaysInsertMode    = 1 << 13,
    ReadOnly            = 1 << 14,
    Password            = 1 << 15,
    NoUndoRedo          = 1 << 16,
    CharsScientific     = 1 << 17,
    CallbackResize      = 1 << 18,
    Multiline           = 1 << 20,
    No_Mark_Edited      = 1 << 21
}

Tree_Node_Flags :: enum i32 {
    None                 = 0,
    Selected             = 1 << 0,
    Framed               = 1 << 1,
    AllowItemOverlap     = 1 << 2,
    NoTreePushOnOpen     = 1 << 3,
    NoAutoOpenOnLog      = 1 << 4,
    DefaultOpen          = 1 << 5,
    OpenOnDoubleClick    = 1 << 6,
    OpenOnArrow          = 1 << 7,
    Leaf                 = 1 << 8,
    Bullet               = 1 << 9,
    FramePadding         = 1 << 10,
    NavLeftJumpsBackHere = 1 << 13,
    CollapsingHeader     = Framed | NoTreePushOnOpen | NoAutoOpenOnLog
}

Selectable_Flags :: enum i32 {
    None             = 0,
    DontClosePopups  = 1 << 0,
    SpanAllColumns   = 1 << 1,
    AllowDoubleClick = 1 << 2,
    Disabled         = 1 << 3,
    Allow_Item_Overlap = 1 << 4
}

Combo_Flags :: enum i32 {
    None           = 0,
    PopupAlignLeft = 1 << 0,
    HeightSmall    = 1 << 1,
    HeightRegular  = 1 << 2,
    HeightLarge    = 1 << 3,
    HeightLargest  = 1 << 4,
    NoArrowButton  = 1 << 5,
    NoPreview      = 1 << 6,
    HeightMask     = HeightSmall | HeightRegular | HeightLarge | HeightLargest
}

Tab_Bar_Flags :: enum i32 {
    None = 0,
    Reorderable = 1,
    Auto_Select_New_Tabs = 2,
    Tab_List_Popup_Button = 4,
    No_Close_With_Middle_Mouse_Button = 8,
    No_Tab_List_Scrolling_Buttons = 16,
    No_Tooltip = 32,
    Fitting_Policy_Resize_Down = 64,
    Fitting_Policy_Scroll = 128,
    Fitting_Policy_Mask = 192,
    Fitting_Policy_Default = 64
}

Tab_Item_Flags :: enum i32 {
    None = 0,
    Unsaved_Document = 1,
    Set_Selected = 2,
    No_Close_With_Middle_Mouse_Button = 4,
    No_Push_Id = 8
}

Focused_Flags :: enum i32 {
    None                = 0,
    ChildWindows        = 1 << 0,
    RootWindow          = 1 << 1,
    AnyWindow           = 1 << 2,
    RootAndChildWindows = RootWindow | ChildWindows
}

Hovered_Flags :: enum i32 {
    None                         = 0,
    ChildWindows                 = 1 << 0,
    RootWindow                   = 1 << 1,
    AnyWindow                    = 1 << 2,
    AllowWhenBlockedByPopup      = 1 << 3,
    AllowWhenBlockedByActiveItem = 1 << 5,
    AllowWhenOverlapped          = 1 << 6,
    AllowWhenDisabled            = 1 << 7,
    RectOnly                     = AllowWhenBlockedByPopup | AllowWhenBlockedByActiveItem | AllowWhenOverlapped,
    RootAndChildWindows          = RootWindow | ChildWindows
}

Dock_Node_Flags :: enum i32 {
    None = 0,
    Keep_Alive_Only = 1,
    No_Docking_In_Central_Node = 4,
    Passthru_Central_Node = 8,
    No_Split = 16,
    No_Resize = 32,
    Auto_Hide_Tab_Bar = 64
}

Drag_Drop_Flags :: enum i32 {
    None                     = 0,
    SourceNoPreviewTooltip   = 1 << 0,
    SourceNoDisableHover     = 1 << 1,
    SourceNoHoldToOpenOthers = 1 << 2,
    SourceAllowNullID        = 1 << 3,
    SourceExtern             = 1 << 4,
    SourceAutoExpirePayload  = 1 << 5,
    AcceptBeforeDelivery     = 1 << 10,
    AcceptNoDrawDefaultRect  = 1 << 11,
    AcceptNoPreviewTooltip   = 1 << 12,
    AcceptPeekOnly           = AcceptBeforeDelivery | AcceptNoDrawDefaultRect
}

Data_Type :: enum i32 {
    S8,
    U8,
    S16,
    U16,
    S32,
    U32,
    S64,
    U64,
    Float,
    Double,
    COUNT
}

Dir :: enum i32 {
    None  = -1,
    Left  = 0,
    Right = 1,
    Up    = 2,
    Down  = 3,
    COUNT
}

Key :: enum i32 {
    Tab,
    LeftArrow,
    RightArrow,
    UpArrow,
    DownArrow,
    PageUp,
    PageDown,
    Home,
    End,
    Insert,
    Delete,
    Backspace,
    Space,
    Enter,
    Escape,
    KeyPadEnter,
    A,
    C,
    V,
    X,
    Y,
    Z,
    COUNT
}

Nav_Input :: enum i32 {
    Activate,
    Cancel,
    Input,
    Menu,
    DpadLeft,
    DpadRight,
    DpadUp,
    DpadDown,
    LStickLeft,
    LStickRight,
    LStickUp,
    LStickDown,
    FocusPrev,
    FocusNext,
    TweakSlow,
    TweakFast,
    KeyMenu,
    KeyLeft,
    KeyRight,
    KeyUp,
    KeyDown,
    COUNT,
    InternalStart = KeyMenu
};

Config_Flags :: enum i32 {
    None                 = 0,
    NavEnableKeyboard    = 1 << 0,
    NavEnableGamepad     = 1 << 1,
    NavEnableSetMousePos = 1 << 2,
    NavNoCaptureKeyboard = 1 << 3,
    NoMouse              = 1 << 4,
    NoMouseCursorChange  = 1 << 5,
    DockingEnable        = 1 << 6,
    ViewportsEnable      = 1 << 10,
    DpiEnableScaleViewports = 1 << 14,
    DpiEnableScaleFonts  = 1 << 15,
    IsSRGB               = 1 << 20,
    IsTouchScreen        = 1 << 21
}

Backend_Flags :: enum i32 {
    None                    = 0,
    HasGamepad              = 1 << 0,
    HasMouseCursors         = 1 << 1,
    HasSetMousePos          = 1 << 2,
    RendererHasVtxOffset    = 1 << 3,
    PlatformHasViewports    = 1 << 10,
    HasMouseHoveredViewport = 1 << 11,
    RendererHasViewports    = 1 << 12
}

Key_Mod_Flags :: enum i32 {
    None = 0,
    Ctrl = 1 << 0,
    Shift = 1 << 1,
    Alt = 1 << 2,
    Super = 1 << 3
}

Style_Color :: enum i32 {
    Text,
    Text_Disabled,
    Window_Bg,
    Child_Bg,
    Popup_Bg,
    Border,
    Bordershadow,
    Frame_Bg,
    Frame_Bghovered,
    Frame_Bgactive,
    Title_Bg,
    Title_Bg_Active,
    Title_Bg_Collapsed,
    Menu_Bar_Bg,
    Scrollbar_Bg,
    Scrollbar_Grab,
    Scrollbar_Grab_Hovered,
    Scrollbar_Grabactive,
    Check_Mark,
    Slider_Grab,
    Slider_Grab_Active,
    Button,
    Button_Hovered,
    Button_Active,
    Header,
    Header_Hovered,
    Headeractive,
    Separator,
    Separatorhovered,
    Separatoractive,
    Resize_Grip,
    Resize_Griphovered,
    Resize_Grip_Active,
    Plot_Lines,
    Plot_Lineshovered,
    Plot_Histogram,
    Plot_Histogramhovered,
    Textselectedbg,
    Drag_Drop_Target,
    Nav_Highlight,
    Nav_Windowing_Highlight,
    Nav_Windowing_Dim_Bg,
    Modal_Window_Dim_Bg,
    COUNT
}

Style_Var :: enum i32 {
    Alpha,
    Window_Padding,
    Window_Rounding,
    Window_Border_Size,
    Window_Min_Size,
    Window_Title_Align,
    Child_Rounding,
    Child_Border_Size,
    Popup_Rounding,
    Popup_Border_Size,
    Frame_Padding,
    Frame_Rounding,
    Frame_Border_Size,
    Item_Spacing,
    Item_Inner_Spacing,
    Indent_Spacing,
    Scrollbar_Size,
    Scrollbar_Rounding,
    Grab_Min_Size,
    Grab_Rounding,
    Button_Text_Align,
    Selectable_Text_Align,
    COUNT
}

Color_Edit_Flags :: enum i32 {
    None = 0,
    No_Alpha = 2,
    No_Picker = 4,
    No_Options = 8,
    No_Small_Preview = 16,
    No_Inputs = 32,
    No_Tooltip = 64,
    No_Label = 128,
    No_Side_Preview = 256,
    No_Drag_Drop = 512,
    No_Border = 1024,
    Alpha_Bar = 65536,
    Alpha_Preview = 131072,
    Alpha_Preview_Half = 262144,
    Hdr = 524288,
    Display_Rgb = 1048576,
    Display_Hsv = 2097152,
    Display_Hex = 4194304,
    Uint8 = 8388608,
    Float = 16777216,
    Picker_Hue_Bar = 33554432,
    Picker_Hue_Wheel = 67108864,
    Input_Rgb = 134217728,
    Input_Hsv = 268435456,
    Options_Default = 177209344,
    Display_Mask = 7340032,
    Data_Type_Mask = 25165824,
    Picker_Mask = 100663296,
    Input_Mask = 402653184
}

Mouse_Button :: enum i32 {
    Left = 0,
    Right = 1,
    Middle = 2,
    Count = 5
}

Mouse_Cursor :: enum i32 {
    None = -1,
    Arrow = 0,
    Text_Input = 1,
    Resize_All = 2,
    Resize_Ns = 3,
    Resize_Ew = 4,
    Resize_Nesw = 5,
    Resize_Nwse = 6,
    Hand = 7,
    Not_Allowed = 8,
    Count = 9
}

Set_Cond :: enum i32 {
    Always = 1,
    Once = 2,
    First_Use_Ever = 4,
    Appearing = 8
}

Draw_Corner_Flags :: enum i32 {
    None = 0,
    Top_Left = 1,
    Top_Right = 2,
    Bot_Left = 4,
    Bot_Right = 8,
    Top = 3,
    Bot = 12,
    Left = 5,
    Right = 10,
    All = 15
}

Draw_List_Flags :: enum i32 {
    None = 0,
    Anti_Aliased_Lines = 1,
    Anti_Aliased_Fill = 2,
    Allow_Vtx_Offset = 4
}

Font_Atlas_Flags :: enum i32 {
    None = 0,
    Power_Of_Two_Height = 1,
    Mouse_Cursors = 2
}

Viewport_Flags :: enum i32 {
    None = 0,
    No_Decoration = 1,
    No_Task_Bar_Icon = 2,
    No_Focus_On_Appearing = 4,
    No_Focus_On_Click = 8,
    No_Inputs = 16,
    No_Renderer_Clear = 32,
    Top_Most = 64,
    Minimized = 128,
    No_Auto_Merge = 256,
    Can_Host_Other_Windows = 512
}

Button_Flags :: enum i32 {
    None = 0,
    Repeat = 1,
    Pressed_On_Click = 2,
    Pressed_On_Click_Release = 4,
    Pressed_On_Click_Release_Anywhere = 8,
    Pressed_On_Release = 16,
    Pressed_On_Double_Click = 32,
    Pressed_On_Drag_Drop_Hold = 64,
    Flatten_Children = 128,
    Allow_Item_Overlap = 256,
    Dont_Close_Popups = 512,
    Disabled = 1024,
    Align_Text_Base_Line = 2048,
    No_Key_Modifiers = 4096,
    No_Holding_Active_Id = 8192,
    No_Nav_Focus = 16384,
    No_Hovered_On_Focus = 32768,
    Mouse_Button_Left = 65536,
    Mouse_Button_Right = 131072,
    Mouse_Button_Middle = 262144,
    Mouse_Button_Mask = 458752,
    Mouse_Button_Shift = 16,
    Mouse_Button_Default = 65536,
    Pressed_On_Mask = 126,
    Pressed_On_Default = 4
}

Slider_Flags :: enum i32 {
    None = 0,
    Vertical = 1
}

Drag_Flags :: enum i32 {
    None = 0,
    Vertical = 1
}

Columns_Flags :: enum i32 {
    None = 0,
    No_Border = 1,
    No_Resize = 2,
    No_Preserve_Widths = 4,
    No_Force_Within_Window = 8,
    Grow_Parent_Contents_Size = 16
}

Selectable_Flags_Private :: enum i32 {
    No_Holding_Active_Id = 1048576,
    Select_On_Click = 2097152,
    Select_On_Release = 4194304,
    Span_Avail_Width = 8388608,
    Draw_Hovered_When_Held = 16777216,
    Set_Nav_Id_On_Hover = 33554432
}

Tree_Node_Flags_Private :: enum i32 {
    Im_Gui_Tree_Node_Flags_Clip_Label_For_Trailing_Button = 1048576
}

Separator_Flags :: enum i32 {
    None = 0,
    Horizontal = 1,
    Vertical = 2,
    Span_All_Columns = 4
}

Item_Status_Flags :: enum i32 {
    None = 0,
    Hovered_Rect = 1,
    Has_Display_Rect = 2,
    Edited = 4,
    Toggled_Selection = 8,
    Toggled_Open = 16,
    Has_Deactivated = 32,
    Deactivated = 64
}

Text_Flags :: enum i32 {
    Ne = 0,
    Width_For_Large_Clipped_Text = 1
}

Tooltip_Flags :: enum i32 {
    None = 0,
    Override_Previous_Tooltip = 1
}

Layout_Type :: enum i32 {
    Horizontal = 0,
    Vertical = 1
}

Plot_Type :: enum i32 {
    Lines,
    Histogram
}

Input_Read_Mode :: enum i32 {
    Down,
    Pressed,
    Released,
    Repeat,
    Repeat_Slow,
    Repeat_Fast
}

Nav_Highlight_Flags :: enum i32 {
    None = 0,
    Type_Default = 1,
    Type_Thin = 2,
    Always_Draw = 4,
    No_Rounding = 8
}

Nav_Dir_Source_Flags :: enum i32 {
    None = 0,
    Keyboard = 1,
    Pad_D_Pad = 2,
    Pad_L_Stick = 4
}

Nav_Move_Flags :: enum i32 {
    None = 0,
    Loop_X = 1,
    Loop_Y = 2,
    Wrap_X = 4,
    Wrap_Y = 8,
    Allow_Current_Nav_Id = 16,
    Also_Score_Visible_Set = 32,
    Scroll_To_Edge = 64
}

Popup_Position_Policy :: enum i32 {
    Default,
    Combo_Box
}

Next_Window_Data_Flags :: enum i32 {
    None = 0,
    Has_Pos = 1,
    Has_Size = 2,
    Has_Content_Size = 4,
    Has_Collapsed = 8,
    Has_Size_Constraint = 16,
    Has_Focus = 32,
    Has_Bg_Alpha = 64,
    Has_Viewport = 128,
    Has_Dock = 256,
    Has_Window_Class = 512
}

Next_Item_Data_Flags :: enum i32 {
    None = 0,
    Has_Width = 1,
    Has_Open = 2
}

Dock_Node_Flags_Private :: enum i32 {
    Dock_Space = 1024,
    Central_Node = 2048,
    No_Tab_Bar = 4096,
    Hidden_Tab_Bar = 8192,
    No_Window_Menu_Button = 16384,
    No_Close_Button = 32768,
    No_Docking = 65536,
    Shared_Flags_Inherit_Mask = -1,
    Local_Flags_Mask = 130160,
    Local_Flags_Transfer_Mask = 129136,
    Saved_Flags_Mask = 130080
}

Data_Authority :: enum i32 {
    Auto,
    Dock_Node,
    Window
}

Tab_Bar_Flags_Private :: enum i32 {
    Dock_Node = 1048576,
    Is_Focused = 2097152,
    Save_Settings = 4194304
}

Tab_Item_Flags_Private :: enum i32 {
    No_Close_Button = 1048576,
    Unsorted = 2097152,
    Preview = 4194304
}
