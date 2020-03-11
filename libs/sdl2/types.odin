package sdl


Init_Flags :: enum u32 {
	Timer = 0x00000001,
	Audio = 0x00000010,
	Video = 0x00000020,
	Joystick = 0x00000200,
	Haptic = 0x00001000,
	GameController = 0x00002000,
	Events = 0x00004000,
	NoParachute = 0x00100000,
	Everything = Timer | Audio | Video | Events | Joystick | Haptic | GameController
}

Window_Flags :: enum u32 {
	Fullscreen = 0x00000001,
	Open_GL = 0x00000002,
	Shown = 0x00000004,
	Hidden = 0x00000008,
	Borderless = 0x00000010,
	Resizable = 0x00000020,
	Minimized = 0x00000040,
	Maximized = 0x00000080,
	Input_Grabbed = 0x00000100,
	Input_Focus = 0x00000200,
	Mouse_Focus = 0x00000400,
	Fullscreen_Desktop = Fullscreen | 0x00001000,
	Foreign = 0x00000800,
	Allow_High_DPI = 0x00002000,
	Mouse_Capture = 0x00004000,
	Always_On_Top = 0x00008000,
	Skip_Taskbar = 0x00010000,
	Utility = 0x00020000,
	Tooltip = 0x00040000,
	Popup_Menu = 0x00080000,
	Vulkan = 0x00100000
}

Window_Pos :: enum i32 {
	Undefined = 0x1FFF0000,
	Centered = 0x2FFF0000
}

Renderer_Flags :: enum u32 {
	Software = 0x00000001,
	Accelerated = 0x00000002,
	Present_VSync = 0x00000004,
	Target_Texture = 0x00000008
}

Texture_Access :: enum i32 {
    Static = 0,
    Streaming,
    Target
}

Blend_Mode :: enum i32 {
	None = 0x00000000,
	Blend = 0x00000001,
	Add = 0x00000002,
	Mod = 0x00000004
}

Error_Code :: enum i32 {
	No_Mem,
	FRead,
	FWrite,
	FSeek,
	Unsupported,
	Last_Error
}

Joystick_Power_Level :: enum i32 {
	Unknown = -1,
	Empty,
	Low,
	Medium,
	Full,
	Wired,
	Max
}

Hint_Priority :: enum i32 {
	Default,
	Normal,
	Override
}

Thread_Priority :: enum i32 {
	Low,
	Normal,
	High
}

Assert_State :: enum i32 {
	Retry,
	Break,
	Abort,
	Ignore,
	Always_Ignore
}

Event_Action :: enum i32 {
	Add_Event,
	Peek_Event,
	Get_Event
}

Hit_Test_Result :: enum i32 {
	Normal,
	Draggable,
	Resize_Top_Left,
	Resize_Top,
	Resize_Top_Right,
	Resize_Right,
	Resize_Bottom_Right,
	Resize_Bottom,
	Resize_Bottom_Left,
	Resize_Left
}

Bool :: enum i32 {
	False,
	True
}

Window_Shape_Modes :: enum i32 {
	Default,
	Binarize_Alpha,
	Reverse_Binarize_Alpha,
	Color_Key
}

Keymod :: enum i32 {
	None = 0x0000,
	LShift = 0x0001,
	RShift = 0x0002,
	LCtrl = 0x0040,
	RCtrl = 0x0080,
	LAlt = 0x0100,
	RAlt = 0x0200,
	LGui = 0x0400,
	RGui = 0x0800,
	Num = 0x1000,
	Caps = 0x2000,
	Mode = 0x4000,
	Reserved = 0x8000
}

Renderer_Flip :: enum i32 {
	None = 0x00000000,
	Horizontal = 0x00000001,
	Vertical = 0x00000002
}

GL_Attr :: enum i32 {
	Red_Size,
	Green_Size,
	Blue_Size,
	Alpha_Size,
	Buffer_Size,
	Doublebuffer,
	Depth_Size,
	Stencil_Size,
	Accum_Red_Size,
	Accum_Green_Size,
	Accum_Blue_Size,
	Accum_Alpha_Size,
	Stereo,
	Multisamplebuffers,
	Multisample_Samples,
	Accelerated_Visual,
	Retained_Backing,
	Context_Major_Version,
	Context_Minor_Version,
	Context_EGL,
	Context_Flags,
	Context_Profile_Mask,
	Share_With_Current_Context,
	Framebuffer_SRGB_Capable,
	Context_Release_Behavior
}

GL_Context_Flag :: enum i32 {
	Debug              = 0x0001,
	Forward_Compatible = 0x0002,
	Robust_Access      = 0x0004,
	Reset_Isolation    = 0x0008
}

GL_Context_Profile :: enum i32 {
	Core           = 0x0001,
	Compatibility  = 0x0002,
	ES             = 0x0004
}

Message_Box_Color_Type :: enum i32 {
	Background,
	Text,
	Button_Border,
	Button_Background,
	Button_Selected,
	Max
}

Audio_Status :: enum i32 {
	Stopped = 0,
	Playing,
	Paused
}

Power_State :: enum i32 {
	Unknown,
	On_Battery,
	No_Battery,
	Charging,
	Charged
}

Log_Category :: enum i32 {
    Application,
    Error,
    Assert,
    System,
    Audio,
    Video,
    Render,
    Input,
    Test,

    Custom = 19
}

Log_Priority :: enum i32 {
	Verbose = 1,
	Debug,
	Info,
	Warn,
	Error,
	Critical,
	Num_Log_Priorities
}

// Input stuff


Game_Controller_Button :: enum i32 {
	Invalid = -1,
	A,
	B,
	X,
	Y,
	Back,
	Guide,
	Start,
	Left_Stick,
	Right_Stick,
	Left_Shoulder,
	Right_Shoulder,
	DPad_Up,
	DPad_Down,
	DPad_Left,
	DPad_Right,
	Max
}

Game_Controller_Axis :: enum i32 {
	Invalid = -1,
	LeftX,
	LeftY,
	RightX,
	RightY,
	Trigger_Left,
	Trigger_Right,
	Max
}

Game_Controller_Bind_Type :: enum i32 {
	None = 0,
	Button,
	Axis,
	Hat
}

System_Cursor :: enum i32 {
	Arrow,
	IBeam,
	Wait,
	Crosshair,
	Wait_Arrow,
	Size_NWSE,
	Size_NESW,
	Size_WE,
	Size_NS,
	Size_All,
	No,
	Hand,
	Num_System_Cursors
}


Scancode :: enum i32 {
	Unknown = 0,

	A = 4,
	B = 5,
	C = 6,
	D = 7,
	E = 8,
	F = 9,
	G = 10,
	H = 11,
	I = 12,
	J = 13,
	K = 14,
	L = 15,
	M = 16,
	N = 17,
	O = 18,
	P = 19,
	Q = 20,
	R = 21,
	S = 22,
	T = 23,
	U = 24,
	V = 25,
	W = 26,
	X = 27,
	Y = 28,
	Z = 29,

	// Number row
	Nr1 = 30,
	Nr2 = 31,
	Nr3 = 32,
	Nr4 = 33,
	Nr5 = 34,
	Nr6 = 35,
	Nr7 = 36,
	Nr8 = 37,
	Nr9 = 38,
	Nr0 = 39,

	Return = 40,
	Escape = 41,
	Backspace = 42,
	Tab = 43,
	Space = 44,

	Minus = 45,
	Equals = 46,
	Leftbracket = 47,
	Rightbracket = 48,
	Backslash = 49,
	Nonushash = 50, // ???
	Semicolon = 51,
	Apostrophe = 52,
	Grave = 53,
	Comma = 54,
	Period = 55,
	Slash = 56,

	Caps_Lock = 57,

	F1 = 58,
	F2 = 59,
	F3 = 60,
	F4 = 61,
	F5 = 62,
	F6 = 63,
	F7 = 64,
	F8 = 65,
	F9 = 66,
	F10 = 67,
	F11 = 68,
	F12 = 69,

	Print_Screen = 70,
	Scroll_Lock = 71,
	Pause = 72,
	Insert = 73,
	Home = 74,
	Page_Up = 75,
	Delete = 76,
	End = 77,
	Page_Down = 78,
	Right = 79,
	Left = 80,
	Down = 81,
	Up = 82,

	Num_Lock_Clear = 83,
	Kp_Divide = 84,
	Kp_Multiply = 85,
	Kp_Minus = 86,
	Kp_Plus = 87,
	Kp_Enter = 88,
	Kp_1 = 89,
	Kp_2 = 90,
	Kp_3 = 91,
	Kp_4 = 92,
	Kp_5 = 93,
	Kp_6 = 94,
	Kp_7 = 95,
	Kp_8 = 96,
	Kp_9 = 97,
	Kp_0 = 98,
	Kp_Period = 99,

	Non_US_Backslash = 100,
	Application = 101,
	Power = 102,
	Kp_Equals = 103,
	F13 = 104,
	F14 = 105,
	F15 = 106,
	F16 = 107,
	F17 = 108,
	F18 = 109,
	F19 = 110,
	F20 = 111,
	F21 = 112,
	F22 = 113,
	F23 = 114,
	F24 = 115,
	Execute = 116,
	Help = 117,
	Menu = 118,
	Select = 119,
	Stop = 120,
	Again = 121,
	Undo = 122,
	Cut = 123,
	Copy = 124,
	Paste = 125,
	Find = 126,
	Mute = 127,
	Volume_Up = 128,
	Volume_Down = 129,
	Kp_Comma = 133,
	Kp_Equals_AS400 = 134,

	International1 = 135,
	International2 = 136,
	International3 = 137,
	International4 = 138,
	International5 = 139,
	International6 = 140,
	International7 = 141,
	International8 = 142,
	International9 = 143,
	Lang1 = 144,
	Lang2 = 145,
	Lang3 = 146,
	Lang4 = 147,
	Lang5 = 148,
	Lang6 = 149,
	Lang7 = 150,
	Lang8 = 151,
	Lang9 = 152,

	Alt_Erase = 153,
	Sys_Req = 154,
	Cancel = 155,
	Clear = 156,
	Prior = 157,
	Return2 = 158,
	Separator = 159,
	Out = 160,
	Oper = 161,
	Clear_Again = 162,
	Cr_Sel = 163,
	Ex_Sel = 164,

	Kp_00 = 176,
	Kp_000 = 177,
	Thousands_Separator = 178,
	Decimal_Separator = 179,
	Currency_Unit = 180,
	Currency_Sub_Unit = 181,
	Kp_Left_Paren = 182,
	Kp_Right_Paren = 183,
	Kp_Left_Brace = 184,
	Kp_Right_Brace = 185,
	Kp_Tab = 186,
	Kp_Backspace = 187,
	Kp_A = 188,
	Kp_B = 189,
	Kp_C = 190,
	Kp_D = 191,
	Kp_E = 192,
	Kp_F = 193,
	Kp_Xor = 194,
	Kp_Power = 195,
	Kp_Percent = 196,
	Kp_Less = 197,
	Kp_Greater = 198,
	Kp_Ampersand = 199,
	Kp_Dbl_Ampersand = 200,
	Kp_Vertical_Bar = 201,
	Kp_Dbl_Vertical_Bar = 202,
	Kp_Colon = 203,
	Kp_Hash = 204,
	Kp_Space = 205,
	Kp_At = 206,
	Kp_Exclam = 207,
	Kp_Mem_Store = 208,
	Kp_Mem_Recall = 209,
	Kp_Mem_Clear = 210,
	Kp_Mem_Add = 211,
	Kp_Mem_Subtract = 212,
	Kp_Mem_Multiply = 213,
	Kp_Mem_Divide = 214,
	Kp_Plus_Minus = 215,
	Kp_Clear = 216,
	Kp_Clear_Entry = 217,
	Kp_Binary = 218,
	Kp_Octal = 219,
	Kp_Decimal = 220,
	Kp_Hexadecimal = 221,

	LCtrl = 224,
	LShift = 225,
	LAlt = 226,
	LGui = 227,
	RCtrl = 228,
	RShift = 229,
	RAlt = 230,
	RGui = 231,

	Mode = 257,

	Audio_Next = 258,
	Audio_Prev = 259,
	Audio_Stop = 260,
	Audio_Play = 261,
	Audio_Mute = 262,
	Media_Select = 263,
	WWW = 264,
	Mail = 265,
	Calculator = 266,
	Computer = 267,
	Ac_Search = 268,
	Ac_Home = 269,
	Ac_Back = 270,
	Ac_Forward = 271,
	Ac_Stop = 272,
	Ac_Refresh = 273,
	Ac_Bookmarks = 274,

	Brightness_Down = 275,
	Brightness_Up = 276,
	Display_Switch = 277,
	Kb_Dillum_Toggle = 278,
	Kb_Dillum_Down = 279,
	Kb_Dillum_Up = 280,
	Eject = 281,
	Sleep = 282,

	App1 = 283,
	App2 = 284,

	Num_Scancodes = 512
}

SDLK_UNKNOWN :: 0;

SDLK_RETURN :: '\r';
SDLK_ESCAPE :: '\033';
SDLK_BACKSPACE :: '\b';
SDLK_TAB :: '\t';
SDLK_SPACE :: ' ';
SDLK_EXCLAIM :: '!';
SDLK_QUOTEDBL :: '"';
SDLK_HASH :: '#';
SDLK_PERCENT :: '%';
SDLK_DOLLAR :: '$';
SDLK_AMPERSAND :: '&';
SDLK_QUOTE :: '\'';
SDLK_LEFTPAREN :: '(';
SDLK_RIGHTPAREN :: ')';
SDLK_ASTERISK :: '*';
SDLK_PLUS :: '+';
SDLK_COMMA :: ',';
SDLK_MINUS :: '-';
SDLK_PERIOD :: '.';
SDLK_SLASH :: '/';
SDLK_0 :: '0';
SDLK_1 :: '1';
SDLK_2 :: '2';
SDLK_3 :: '3';
SDLK_4 :: '4';
SDLK_5 :: '5';
SDLK_6 :: '6';
SDLK_7 :: '7';
SDLK_8 :: '8';
SDLK_9 :: '9';
SDLK_COLON :: ':';
SDLK_SEMICOLON :: ';';
SDLK_LESS :: '<';
SDLK_EQUALS :: '=';
SDLK_GREATER :: '>';
SDLK_QUESTION :: '?';
SDLK_AT :: '@';

SDLK_LEFTBRACKET :: '[';
SDLK_BACKSLASH :: '\\';
SDLK_RIGHTBRACKET :: ']';
SDLK_CARET :: '^';
SDLK_UNDERSCORE :: '_';
SDLK_BACKQUOTE :: '`';
SDLK_a :: 'a';
SDLK_b :: 'b';
SDLK_c :: 'c';
SDLK_d :: 'd';
SDLK_e :: 'e';
SDLK_f :: 'f';
SDLK_g :: 'g';
SDLK_h :: 'h';
SDLK_i :: 'i';
SDLK_j :: 'j';
SDLK_k :: 'k';
SDLK_l :: 'l';
SDLK_m :: 'm';
SDLK_n :: 'n';
SDLK_o :: 'o';
SDLK_p :: 'p';
SDLK_q :: 'q';
SDLK_r :: 'r';
SDLK_s :: 's';
SDLK_t :: 't';
SDLK_u :: 'u';
SDLK_v :: 'v';
SDLK_w :: 'w';
SDLK_x :: 'x';
SDLK_y :: 'y';
SDLK_z :: 'z';

SDLK_CAPSLOCK :: Scancode.Caps_Lock | SDLK_SCANCODE_MASK;

SDLK_F1 :: Scancode.F1 | SDLK_SCANCODE_MASK;
SDLK_F2 :: Scancode.F2 | SDLK_SCANCODE_MASK;
SDLK_F3 :: Scancode.F3 | SDLK_SCANCODE_MASK;
SDLK_F4 :: Scancode.F4 | SDLK_SCANCODE_MASK;
SDLK_F5 :: Scancode.F5 | SDLK_SCANCODE_MASK;
SDLK_F6 :: Scancode.F6 | SDLK_SCANCODE_MASK;
SDLK_F7 :: Scancode.F7 | SDLK_SCANCODE_MASK;
SDLK_F8 :: Scancode.F8 | SDLK_SCANCODE_MASK;
SDLK_F9 :: Scancode.F9 | SDLK_SCANCODE_MASK;
SDLK_F10 :: Scancode.F10 | SDLK_SCANCODE_MASK;
SDLK_F11 :: Scancode.F11 | SDLK_SCANCODE_MASK;
SDLK_F12 :: Scancode.F12 | SDLK_SCANCODE_MASK;

SDLK_PRINTSCREEN :: Scancode.Print_Screen | SDLK_SCANCODE_MASK;
SDLK_SCROLLLOCK :: Scancode.Scroll_Lock | SDLK_SCANCODE_MASK;
SDLK_PAUSE :: Scancode.Pause | SDLK_SCANCODE_MASK;
SDLK_INSERT :: Scancode.Insert | SDLK_SCANCODE_MASK;
SDLK_HOME :: Scancode.Home | SDLK_SCANCODE_MASK;
SDLK_PAGEUP :: Scancode.Page_Up | SDLK_SCANCODE_MASK;
SDLK_DELETE :: '\177';
SDLK_END :: Scancode.End | SDLK_SCANCODE_MASK;
SDLK_PAGEDOWN :: Scancode.Page_Down | SDLK_SCANCODE_MASK;
SDLK_RIGHT :: Scancode.Right | SDLK_SCANCODE_MASK;
SDLK_LEFT :: Scancode.Left | SDLK_SCANCODE_MASK;
SDLK_DOWN :: Scancode.Down | SDLK_SCANCODE_MASK;
SDLK_UP :: Scancode.Up | SDLK_SCANCODE_MASK;

SDLK_NUMLOCKCLEAR :: Scancode.Num_Lock_Clear | SDLK_SCANCODE_MASK;
SDLK_KP_DIVIDE :: Scancode.Kp_Divide | SDLK_SCANCODE_MASK;
SDLK_KP_MULTIPLY :: Scancode.Kp_Multiply | SDLK_SCANCODE_MASK;
SDLK_KP_MINUS :: Scancode.Kp_Minus | SDLK_SCANCODE_MASK;
SDLK_KP_PLUS :: Scancode.Kp_Plus | SDLK_SCANCODE_MASK;
SDLK_KP_ENTER :: Scancode.Kp_Enter | SDLK_SCANCODE_MASK;
SDLK_KP_1 :: Scancode.Kp_1 | SDLK_SCANCODE_MASK;
SDLK_KP_2 :: Scancode.Kp_2 | SDLK_SCANCODE_MASK;
SDLK_KP_3 :: Scancode.Kp_3 | SDLK_SCANCODE_MASK;
SDLK_KP_4 :: Scancode.Kp_4 | SDLK_SCANCODE_MASK;
SDLK_KP_5 :: Scancode.Kp_5 | SDLK_SCANCODE_MASK;
SDLK_KP_6 :: Scancode.Kp_6 | SDLK_SCANCODE_MASK;
SDLK_KP_7 :: Scancode.Kp_7 | SDLK_SCANCODE_MASK;
SDLK_KP_8 :: Scancode.Kp_8 | SDLK_SCANCODE_MASK;
SDLK_KP_9 :: Scancode.Kp_9 | SDLK_SCANCODE_MASK;
SDLK_KP_0 :: Scancode.Kp_0 | SDLK_SCANCODE_MASK;
SDLK_KP_PERIOD :: Scancode.Kp_Period | SDLK_SCANCODE_MASK;

SDLK_APPLICATION :: Scancode.Application | SDLK_SCANCODE_MASK;
SDLK_POWER :: Scancode.Power | SDLK_SCANCODE_MASK;
SDLK_KP_EQUALS :: Scancode.Kp_Equals | SDLK_SCANCODE_MASK;
SDLK_F13 :: Scancode.F13 | SDLK_SCANCODE_MASK;
SDLK_F14 :: Scancode.F14 | SDLK_SCANCODE_MASK;
SDLK_F15 :: Scancode.F15 | SDLK_SCANCODE_MASK;
SDLK_F16 :: Scancode.F16 | SDLK_SCANCODE_MASK;
SDLK_F17 :: Scancode.F17 | SDLK_SCANCODE_MASK;
SDLK_F18 :: Scancode.F18 | SDLK_SCANCODE_MASK;
SDLK_F19 :: Scancode.F19 | SDLK_SCANCODE_MASK;
SDLK_F20 :: Scancode.F20 | SDLK_SCANCODE_MASK;
SDLK_F21 :: Scancode.F21 | SDLK_SCANCODE_MASK;
SDLK_F22 :: Scancode.F22 | SDLK_SCANCODE_MASK;
SDLK_F23 :: Scancode.F23 | SDLK_SCANCODE_MASK;
SDLK_F24 :: Scancode.F24 | SDLK_SCANCODE_MASK;
SDLK_EXECUTE :: Scancode.Execute | SDLK_SCANCODE_MASK;
SDLK_HELP :: Scancode.Help | SDLK_SCANCODE_MASK;
SDLK_MENU :: Scancode.Menu | SDLK_SCANCODE_MASK;
SDLK_SELECT :: Scancode.Select | SDLK_SCANCODE_MASK;
SDLK_STOP :: Scancode.Stop | SDLK_SCANCODE_MASK;
SDLK_AGAIN :: Scancode.Again | SDLK_SCANCODE_MASK;
SDLK_UNDO :: Scancode.Undo | SDLK_SCANCODE_MASK;
SDLK_CUT :: Scancode.Cut | SDLK_SCANCODE_MASK;
SDLK_COPY :: Scancode.Copy | SDLK_SCANCODE_MASK;
SDLK_PASTE :: Scancode.Paste | SDLK_SCANCODE_MASK;
SDLK_FIND :: Scancode.Find | SDLK_SCANCODE_MASK;
SDLK_MUTE :: Scancode.Mute | SDLK_SCANCODE_MASK;
SDLK_VOLUMEUP :: Scancode.Volume_Up | SDLK_SCANCODE_MASK;
SDLK_VOLUMEDOWN :: Scancode.Volume_Down | SDLK_SCANCODE_MASK;
SDLK_KP_COMMA :: Scancode.Kp_Comma | SDLK_SCANCODE_MASK;
SDLK_KP_EQUALSAS400 :: Scancode.Kp_Equals_AS400 | SDLK_SCANCODE_MASK;

SDLK_ALTERASE :: Scancode.Alt_Erase | SDLK_SCANCODE_MASK;
SDLK_SYSREQ :: Scancode.Sys_Req | SDLK_SCANCODE_MASK;
SDLK_CANCEL :: Scancode.Cancel | SDLK_SCANCODE_MASK;
SDLK_CLEAR :: Scancode.Clear | SDLK_SCANCODE_MASK;
SDLK_PRIOR :: Scancode.Prior | SDLK_SCANCODE_MASK;
SDLK_RETURN2 :: Scancode.Return2 | SDLK_SCANCODE_MASK;
SDLK_SEPARATOR :: Scancode.Separator | SDLK_SCANCODE_MASK;
SDLK_OUT :: Scancode.Out | SDLK_SCANCODE_MASK;
SDLK_OPER :: Scancode.Oper | SDLK_SCANCODE_MASK;
SDLK_CLEARAGAIN :: Scancode.Clear_Again | SDLK_SCANCODE_MASK;
SDLK_CRSEL :: Scancode.Cr_Sel | SDLK_SCANCODE_MASK;
SDLK_EXSEL :: Scancode.Ex_Sel | SDLK_SCANCODE_MASK;

SDLK_KP_00 :: Scancode.Kp_00 | SDLK_SCANCODE_MASK;
SDLK_KP_000 :: Scancode.Kp_000 | SDLK_SCANCODE_MASK;
SDLK_THOUSANDSSEPARATOR :: Scancode.Thousands_Separator | SDLK_SCANCODE_MASK;
SDLK_DECIMALSEPARATOR :: Scancode.Decimal_Separator | SDLK_SCANCODE_MASK;
SDLK_CURRENCYUNIT :: Scancode.Currency_Unit | SDLK_SCANCODE_MASK;
SDLK_CURRENCYSUBUNIT :: Scancode.Currency_Sub_Unit | SDLK_SCANCODE_MASK;
SDLK_KP_LEFTPAREN :: Scancode.Kp_Left_Paren | SDLK_SCANCODE_MASK;
SDLK_KP_RIGHTPAREN :: Scancode.Kp_Right_Paren | SDLK_SCANCODE_MASK;
SDLK_KP_LEFTBRACE :: Scancode.Kp_Left_Brace | SDLK_SCANCODE_MASK;
SDLK_KP_RIGHTBRACE :: Scancode.Kp_Right_Brace | SDLK_SCANCODE_MASK;
SDLK_KP_TAB :: Scancode.Kp_Tab | SDLK_SCANCODE_MASK;
SDLK_KP_BACKSPACE :: Scancode.Kp_Backspace | SDLK_SCANCODE_MASK;
SDLK_KP_A :: Scancode.Kp_A | SDLK_SCANCODE_MASK;
SDLK_KP_B :: Scancode.Kp_B | SDLK_SCANCODE_MASK;
SDLK_KP_C :: Scancode.Kp_C | SDLK_SCANCODE_MASK;
SDLK_KP_D :: Scancode.Kp_D | SDLK_SCANCODE_MASK;
SDLK_KP_E :: Scancode.Kp_E | SDLK_SCANCODE_MASK;
SDLK_KP_F :: Scancode.Kp_F | SDLK_SCANCODE_MASK;
SDLK_KP_XOR :: Scancode.Kp_Xor | SDLK_SCANCODE_MASK;
SDLK_KP_POWER :: Scancode.Kp_Power | SDLK_SCANCODE_MASK;
SDLK_KP_PERCENT :: Scancode.Kp_Percent | SDLK_SCANCODE_MASK;
SDLK_KP_LESS :: Scancode.Kp_Less | SDLK_SCANCODE_MASK;
SDLK_KP_GREATER :: Scancode.Kp_Greater | SDLK_SCANCODE_MASK;
SDLK_KP_AMPERSAND :: Scancode.Kp_Ampersand | SDLK_SCANCODE_MASK;
SDLK_KP_DBLAMPERSAND :: Scancode.Kp_Dbl_Ampersand | SDLK_SCANCODE_MASK;
SDLK_KP_VERTICALBAR :: Scancode.Kp_Vertical_Bar | SDLK_SCANCODE_MASK;
SDLK_KP_DBLVERTICALBAR :: Scancode.Kp_Dbl_Vertical_Bar | SDLK_SCANCODE_MASK;
SDLK_KP_COLON :: Scancode.Kp_Colon | SDLK_SCANCODE_MASK;
SDLK_KP_HASH :: Scancode.Kp_Hash | SDLK_SCANCODE_MASK;
SDLK_KP_SPACE :: Scancode.Kp_Space | SDLK_SCANCODE_MASK;
SDLK_KP_AT :: Scancode.Kp_At | SDLK_SCANCODE_MASK;
SDLK_KP_EXCLAM :: Scancode.Kp_Exclam | SDLK_SCANCODE_MASK;
SDLK_KP_MEMSTORE :: Scancode.Kp_Mem_Store | SDLK_SCANCODE_MASK;
SDLK_KP_MEMRECALL :: Scancode.Kp_Mem_Recall | SDLK_SCANCODE_MASK;
SDLK_KP_MEMCLEAR :: Scancode.Kp_Mem_Clear | SDLK_SCANCODE_MASK;
SDLK_KP_MEMADD :: Scancode.Kp_Mem_Add | SDLK_SCANCODE_MASK;
SDLK_KP_MEMSUBTRACT :: Scancode.Kp_Mem_Subtract | SDLK_SCANCODE_MASK;
SDLK_KP_MEMMULTIPLY :: Scancode.Kp_Mem_Multiply | SDLK_SCANCODE_MASK;
SDLK_KP_MEMDIVIDE :: Scancode.Kp_Mem_Divide | SDLK_SCANCODE_MASK;
SDLK_KP_PLUSMINUS :: Scancode.Kp_Plus_Minus | SDLK_SCANCODE_MASK;
SDLK_KP_CLEAR :: Scancode.Kp_Clear | SDLK_SCANCODE_MASK;
SDLK_KP_CLEARENTRY :: Scancode.Kp_Clear_Entry | SDLK_SCANCODE_MASK;
SDLK_KP_BINARY :: Scancode.Kp_Binary | SDLK_SCANCODE_MASK;
SDLK_KP_OCTAL :: Scancode.Kp_Octal | SDLK_SCANCODE_MASK;
SDLK_KP_DECIMAL :: Scancode.Kp_Decimal | SDLK_SCANCODE_MASK;
SDLK_KP_HEXADECIMAL :: Scancode.Kp_Hexadecimal | SDLK_SCANCODE_MASK;

SDLK_LCTRL :: Scancode.LCtrl | SDLK_SCANCODE_MASK;
SDLK_LSHIFT :: Scancode.LShift | SDLK_SCANCODE_MASK;
SDLK_LALT :: Scancode.LAlt | SDLK_SCANCODE_MASK;
SDLK_LGUI :: Scancode.LGui | SDLK_SCANCODE_MASK;
SDLK_RCTRL :: Scancode.RCtrl | SDLK_SCANCODE_MASK;
SDLK_RSHIFT :: Scancode.RShift | SDLK_SCANCODE_MASK;
SDLK_RALT :: Scancode.RAlt | SDLK_SCANCODE_MASK;
SDLK_RGUI :: Scancode.RGui | SDLK_SCANCODE_MASK;

SDLK_MODE :: Scancode.Mode | SDLK_SCANCODE_MASK;

SDLK_AUDIONEXT :: Scancode.Audio_Next | SDLK_SCANCODE_MASK;
SDLK_AUDIOPREV :: Scancode.Audio_Prev | SDLK_SCANCODE_MASK;
SDLK_AUDIOSTOP :: Scancode.Audio_Stop | SDLK_SCANCODE_MASK;
SDLK_AUDIOPLAY :: Scancode.Audio_Play | SDLK_SCANCODE_MASK;
SDLK_AUDIOMUTE :: Scancode.Audio_Mute | SDLK_SCANCODE_MASK;
SDLK_MEDIASELECT :: Scancode.Media_Select | SDLK_SCANCODE_MASK;
SDLK_WWW :: Scancode.WWW | SDLK_SCANCODE_MASK;
SDLK_MAIL :: Scancode.Mail | SDLK_SCANCODE_MASK;
SDLK_CALCULATOR :: Scancode.Calculator | SDLK_SCANCODE_MASK;
SDLK_COMPUTER :: Scancode.Computer | SDLK_SCANCODE_MASK;
SDLK_AC_SEARCH :: Scancode.Ac_Search | SDLK_SCANCODE_MASK;
SDLK_AC_HOME :: Scancode.Ac_Home | SDLK_SCANCODE_MASK;
SDLK_AC_BACK :: Scancode.Ac_Back | SDLK_SCANCODE_MASK;
SDLK_AC_FORWARD :: Scancode.Ac_Forward | SDLK_SCANCODE_MASK;
SDLK_AC_STOP :: Scancode.Ac_Stop | SDLK_SCANCODE_MASK;
SDLK_AC_REFRESH :: Scancode.Ac_Refresh | SDLK_SCANCODE_MASK;
SDLK_AC_BOOKMARKS :: Scancode.Ac_Bookmarks | SDLK_SCANCODE_MASK;

SDLK_BRIGHTNESSDOWN :: Scancode.Brightness_Down | SDLK_SCANCODE_MASK;
SDLK_BRIGHTNESSUP :: Scancode.Brightness_Up | SDLK_SCANCODE_MASK;
SDLK_DISPLAYSWITCH :: Scancode.Display_Switch | SDLK_SCANCODE_MASK;
SDLK_KBDILLUMTOGGLE :: Scancode.Kb_Dillum_Toggle | SDLK_SCANCODE_MASK;
SDLK_KBDILLUMDOWN :: Scancode.Kb_Dillum_Down | SDLK_SCANCODE_MASK;
SDLK_KBDILLUMUP :: Scancode.Kb_Dillum_Up | SDLK_SCANCODE_MASK;
SDLK_EJECT :: Scancode.Eject | SDLK_SCANCODE_MASK;
SDLK_SLEEP :: Scancode.Sleep | SDLK_SCANCODE_MASK;

SDLK_SCANCODE_MASK :: Scancode(1<<30);

Mousecode :: enum i32 {
	Left   = 1 << 0,
	Middle = 1 << 1,
	Right  = 1 << 2,
	X1 	   = 1 << 3,
	X2 	   = 1 << 4
}


Hat :: enum i32 {
	Centered = 0x00,
	Up = 0x01,
	Right = 0x02,
	Down = 0x04,
	Left = 0x08,
	Right_Up = Right | Up,
	Right_Down = Right | Down,
	Left_Up = Left | Up,
	Left_Down = Left | Down
}

Event_Type :: enum u32 {
	First_Event = 0,

	Quit = 0x100,

	App_Terminating = 257,
	App_Low_Memory = 258,
	App_Will_Enter_Background = 259,
	App_Did_Enter_Background = 260,
	App_Will_Enter_Foreground = 261,
	App_Did_Enter_Foreground = 262,

	Window_Event = 0x200,
	Sys_Wm_Event = 513,

	Key_Down = 0x300,
	Key_Up = 769,
	Text_Editing = 770,
	Text_Input = 771,
	Key_Map_Changed = 772,

	Mouse_Motion = 0x400,
	Mouse_Button_Down = 1025,
	Mouse_Button_Up = 1026,
	Mouse_Wheel = 1027,

	Joy_Axis_Motion = 0x600,
	Joy_Ball_Motion = 1537,
	Joy_Hat_Motion = 1538,
	Joy_Button_Down = 1539,
	Joy_Button_Up = 1540,
	Joy_Device_Added = 1541,
	Joy_Device_Removed = 1542,

	Controller_Axis_Motion = 0x650,
	Controller_Button_Down = 1617,
	Controller_Button_Up = 1618,
	Controller_Device_Added = 1619,
	Controller_Device_Removed = 1620,
	Controller_Device_Remapped = 1621,

	Finger_Down = 0x700,
	Finger_Up = 1793,
	Finger_Motion = 1794,

	Dollar_Gesture = 0x800,
	Dollar_Record = 2049,
	Multigesture = 2050,

	Clipboard_Update = 0x900,

	Drop_File = 0x1000,
	Drop_Text = 4097,
	Drop_Begin = 4098,
	Drop_Complete = 4099,

	Audio_Device_Added = 0x1100,
	Audio_Device_Removed = 4353,

	Render_Targets_Reset = 0x2000,
	Render_Device_Reset = 8193,

	User_Event = 0x8000,

	Last_Event = 0xFFFF
}

Window_Event_ID :: enum u8 {
    None = 0,
    Shown,
    Hidden,
    Exposed,
	Moved,
    Resized,
    Size_Changed,
    Minimized,
    Maximized,
    Restored,
    Enter,
    Leave,
    Focus_Gained,
    Focus_Lost,
    Close,
    Take_Focus,
    Hit_Test
}

GL_Context :: rawptr;

Blit_Map :: struct {};
Window :: struct {};
Renderer :: struct {};
Texture :: struct {};
Cond :: struct {};
Mutex :: struct {};
Sem :: struct {};
Thread :: struct {};
Haptic :: struct {};
Joystick :: struct {};
Game_Controller :: struct {};
Cursor :: struct {};
IDirect3D_Device9 :: struct {};
Rw_Ops :: struct {};

// Unsure of these
Sys_Wm_Info :: struct {};
Sys_Wm_Msg :: struct {};

Joystick_Id :: i32;
Timer_Id :: i32;
Spin_Lock :: i32;
Tls_Id :: u32;
Audio_Device_Id :: u32;
Audio_Device :: u32;
Audio_Format :: u16;
Keycode :: i32;
Thread_Id :: u64;
Touch_Id :: i64;
Gesture_Id :: i64;
Finger_Id :: i64;

Hint_Callback :: proc "c" (interval: u32, param: rawptr) -> u32;
Event_Filter :: proc "c" (userdata: rawptr, param: ^Event) -> i32;
Timer_Callback :: proc "c" (interval: u32, param: rawptr) -> u32;
Audio_Callback :: proc "c" (userdata: rawptr, stream: ^u8, len: i32);
Assertion_Handler :: proc "c" (data: ^Assert_Data, userdata: rawptr) -> Assert_State;
Audio_Filter :: proc "c" (cvt: ^Audio_Cvt, format: Audio_Format);
Thread_Function :: proc "c" (data: rawptr) -> i32;
Hit_Test :: proc "c" (window: ^Window, area: ^Point, data: rawptr) -> Hit_Test_Result;
Windows_Message_Hook :: proc "c" (userdata: rawptr, hwnd: rawptr, message: u32, wparam: u64, lparam: i64);
Log_Output_Function :: proc "c" (userdata: rawptr, category: Log_Category, priority: Log_Priority, message: cstring);

// Thanks gingerBill for this one!
Game_Controller_Button_Bind :: struct {
	bind_type: Game_Controller_Bind_Type,
	value: struct #raw_union {
		button: i32,
		axis:   i32,
		using hat_mask: struct {
			hat, mask: i32,
		},
	},
}

Message_Box_Data :: struct {
	flags: u32,
	window: ^Window,
	title: cstring,
	message: cstring,

	num_buttons: i32,
	buttons: ^Message_Box_Button_Data,

	color_scheme: ^Message_Box_Color_Scheme,
}

Message_Box_Button_Data :: struct {
	flags: u32,
	button_id: i32,
	text: cstring,
}

Message_Box_Color_Scheme :: struct {
	colors: [Message_Box_Color_Type.Max]Message_Box_Color,
}

Message_Box_Color :: struct {
	r, g, b: u8,
}

Assert_Data :: struct {
	always_ignore: i32,
	trigger_count: u32,
	condition: cstring,
	filename: cstring,
	linenum: i32,
	function: cstring,
	next: ^Assert_Data,
}

Window_Shape_Params :: struct #raw_union {
	binarization_cutoff: u8,
	color_key: Color,
}

Window_Shape_Mode :: struct {
	mode: Window_Shape_Modes,
	parameters: Window_Shape_Params,
}

Point :: struct {
	x: i32,
	y: i32,
}

Renderer_Info :: struct {
	name: cstring,
	flags: u32,
	num_texture_formats: u32,
	texture_formats: [16]u32,
	max_texture_width: i32,
	max_texture_height: i32,
}

Version :: struct {
	major: u8,
	minor: u8,
	patch: u8,
}

Display_Mode :: struct {
	format: u32,
	w: i32,
	h: i32,
	refresh_rate: i32,
	driver_data: rawptr,
}

Finger :: struct {
	id: Finger_Id,
	x: f32,
	y: f32,
	pressure: f32,
}

Audio_Spec :: struct {
	freq: i32,
	format: Audio_Format,
	channels: u8,
	silence: u8,
	samples: u16,
	padding: u16,
	size: u32,
	callback: Audio_Callback,
	userdata: rawptr,
}

Joystick_Guid :: struct {
	data: [16]u8,
}

Audio_Cvt :: struct {
	needed: i32,
	src_format: Audio_Format,
	dst_format: Audio_Format,
	rate_incr: i64,
	buf: ^u8,
	len: i32,
	len_cvt: i32,
	len_mult: i32,
	len_ratio: i64,
	filters: [10]Audio_Filter,
	filter_index: i32,
}

Surface :: struct {
	flags: u32,
	format: ^Pixel_Format,
	w, h: i32,
	pitch: i32,
	pixels: rawptr,

	userdata: rawptr,

	locked: i32,
	lock_data: rawptr,

	clip_rect: Rect,
	blip_map: ^Blit_Map,

	refcount: i32,
}

Color :: struct {
	r: u8,
	g: u8,
	b: u8,
	a: u8,
}

Palette :: struct {
	num_colors: i32,
	colors: ^Color,
	version: u32,
	ref_count: i32,
}

Pixel_Format :: struct {
	format: u32,
	palette: ^Palette,
	bits_per_pixel: u8,
	bytes_per_pixel: u8,
	padding: [2]u8,
	r_mask: u32,
	g_mask: u32,
	b_mask: u32,
	a_mask: u32,
	r_loss: u8,
	g_loss: u8,
	b_loss: u8,
	a_loss: u8,
	r_shift: u8,
	g_shift: u8,
	b_shift: u8,
	a_shift: u8,
	ref_count: i32,
	next: ^Pixel_Format,
}

Rect :: struct {
	x, y: i32,
	w, h: i32,
}

Atomic :: struct {
	value: i32,
}

Keysym :: struct {
	scancode: Scancode,
	sym: i32,
	mod: u16,
	unused: u32,
}

Haptic_Effect :: struct #raw_union {
	haptic_type: u16,
	constant: Haptic_Constant,
	periodic: Haptic_Periodic,
	condition: Haptic_Condition,
	ramp: Haptic_Ramp,
	left_right: Haptic_Left_Right,
	custom: Haptic_Custom,
}

Haptic_Constant :: struct {
	haptic_type: u16,
	direction: Haptic_Direction,

	length: u32,
	delay: u16,

	button: u16,
	interval: u16,

	level: i16,

	attack_length: u16,
	attack_level: u16,
	fade_length: u16,
	fade_level: u16,
}

Haptic_Periodic :: struct {
	haptic_type: u16,
	direction: Haptic_Direction,

	length: u32,
	delay: u16,

	button: u16,
	interval: u16,

	period: u16,
	magnitude: i16,
	offset: i16,
	phase: u16,

	attack_length: u16,
	attack_level: u16,
	fade_length: u16,
	fade_level: u16,
}

Haptic_Direction :: struct {
	haptic_type: u8,
	dir: [3]i32,
}

Haptic_Condition :: struct {
	haptic_type: u16,
	direction: Haptic_Direction,

	length: u32,
	delay: u16,

	button: u16,
	interval: u16,

	right_sat: [3]u16,
	left_sat: [3]u16,
	right_coeff: [3]i16,
	left_coeff: [3]i16,
	dead_band: [3]u16,
	center: [3]i16,
}

Haptic_Ramp :: struct {
	haptic_type: u16,
	direction: Haptic_Direction,

	length: u32,
	delay: u16,

	button: u16,
	interval: u16,

	start: i16,
	end: i16,

	attack_length: u16,
	attack_level: u16,
	fade_length: u16,
	fade_level: u16,
}

Haptic_Left_Right :: struct {
	haptic_type: u16,

	length: u32,

	large_magnitude: u16,
	small_magnitude: u16,
}

Haptic_Custom :: struct {
	haptic_type: u16,
	direction: Haptic_Direction,

	length: u32,
	delay: u16,

	button: u16,
	interval: u16,

	channels: u8,
	period: u16,
	samples: u16,
	data: ^u16,

	attack_length: u16,
	attack_level: u16,
	fade_length: u16,
	fade_level: u16,
}

Event :: struct #raw_union {
	type: Event_Type,
	common: Common_Event,
	window: Window_Event,
	key: Keyboard_Event,
	edit: Text_Editing_Event,
	text: Text_Input_Event,
	motion: Mouse_Motion_Event,
	button: Mouse_Button_Event,
	wheel: Mouse_Wheel_Event,
	jaxis: Joy_Axis_Event,
	jball: Joy_Ball_Event,
	jhat: Joy_Hat_Event,
	jbutton: Joy_Button_Event,
	jdevice: Joy_Device_Event,
	caxis: Controller_Axis_Event,
	cbutton: Controller_Button_Event,
	cdevice: Controller_Device_Event,
	adevice: Audio_Device_Event,
	quit: Quit_Event,
	user: User_Event,
	syswm: Sys_Wm_Event,
	tfinger: Touch_Finger_Event,
	mgesture: Multi_Gesture_Event,
	dgesture: Dollar_Gesture_Event,
	drop: Drop_Event,

	padding: [56]u8,
}

Common_Event :: struct {
	type: Event_Type,
	timestamp: u32,
}

Window_Event :: struct {
	type: Event_Type,
	timestamp: u32,
	window_id: u32,
	event: Window_Event_ID,
	padding1: u8,
	padding2: u8,
	padding3: u8,
	data1: i32,
	data2: i32,
}

Keyboard_Event :: struct {
	type: Event_Type,
	timestamp: u32,
	window_id: u32,
	state: u8,
	repeat: u8,
	padding2: u8,
	padding3: u8,
	keysym: Keysym,
}

TEXT_EDITING_EVENT_TEXT_SIZE :: 32;
Text_Editing_Event :: struct {
	type: Event_Type,
	timestamp: u32,
	window_id: u32,
	text: [TEXT_EDITING_EVENT_TEXT_SIZE]u8,
	start: i32,
	length: i32,
}


TEXT_INPUT_EVENT_TEXT_SIZE :: 32;
Text_Input_Event :: struct {
	type: Event_Type,
	timestamp: u32,
	window_id: u32,
	text: [TEXT_INPUT_EVENT_TEXT_SIZE]u8,
}

Mouse_Motion_Event :: struct {
	type: Event_Type,
	timestamp: u32,
	window_id: u32,
	which: u32,
	state: u32,
	x: i32,
	y: i32,
	xrel: i32,
	yrel: i32,
}

Mouse_Button_Event :: struct {
	type: Event_Type,
	timestamp: u32,
	window_id: u32,
	which: u32,
	button: u8,
	state: u8,
	clicks: u8,
	padding1: u8,
	x: i32,
	y: i32,
}

Mouse_Wheel_Event :: struct {
	type: Event_Type,
	timestamp: u32,
	window_id: u32,
	which: u32,
	x: i32,
	y: i32,
	direction: u32,
}

Joy_Axis_Event :: struct {
	type: Event_Type,
	timestamp: u32,
	which: i32,
	axis: u8,
	padding1: u8,
	padding2: u8,
	padding3: u8,
	value: i16,
	padding4: u16,
}

Joy_Ball_Event :: struct {
	type: Event_Type,
	timestamp: u32,
	which: i32,
	ball: u8,
	padding1: u8,
	padding2: u8,
	padding3: u8,
	xrel: i16,
	yrel: i16,
}

Joy_Hat_Event :: struct {
	type: Event_Type,
	timestamp: u32,
	which: i32,
	hat: u8,
	value: u8,
	padding1: u8,
	padding2: u8,
}

Joy_Button_Event :: struct {
	type: Event_Type,
	timestamp: u32,
	which: i32,
	button: u8,
	state: u8,
	padding1: u8,
	padding2: u8,
}

Joy_Device_Event :: struct {
	type: Event_Type,
	timestamp: u32,
	which: i32,
}

Controller_Axis_Event :: struct {
	type: Event_Type,
	timestamp: u32,
	which: i32,
	axis: u8,
	padding1: u8,
	padding2: u8,
	padding3: u8,
	value: i16,
	padding4: u16,
}

Controller_Button_Event :: struct {
	type: Event_Type,
	timestamp: u32,
	which: i32,
	button: u8,
	state: u8,
	padding1: u8,
	padding2: u8,
}

Controller_Device_Event :: struct {
	type: Event_Type,
	timestamp: u32,
	which: i32,
}

Audio_Device_Event :: struct {
	type: Event_Type,
	timestamp: u32,
	which: u32,
	iscapture: u8,
	padding1: u8,
	padding2: u8,
	padding3: u8,
}

Touch_Finger_Event :: struct {
	type: Event_Type,
	timestamp: u32,
	touch_id: i64,
	finger_id: i64,
	x: f32,
	y: f32,
	dx: f32,
	dy: f32,
	pressure: f32,
}

Multi_Gesture_Event :: struct {
	type: Event_Type,
	timestamp: u32,
	touch_id: i64,
	d_theta: f32,
	d_dist: f32,
	x: f32,
	y: f32,
	num_fingers: u16,
	padding: u16,
}

Dollar_Gesture_Event :: struct {
	type: Event_Type,
	timestamp: u32,
	touch_id: i64,
	gesture_id: i64,
	num_fingers: u32,
	error: f32,
	x: f32,
	y: f32,
}

Drop_Event :: struct {
	type: Event_Type,
	timestamp: u32,
	file: cstring,
	window_id: u32,
}

Quit_Event :: struct {
	type: Event_Type,
	timestamp: u32,
}

OS_Event :: struct {
	type: Event_Type,
	timestamp: u32,
}

User_Event :: struct {
	type: Event_Type,
	timestamp: u32,
	window_id: u32,
	code: i32,
	data1: ^rawptr,
	data2: ^rawptr,
}

Sys_Wm_Event :: struct {
	type: Event_Type,
	timestamp: u32,
	msg: ^Sys_Wm_Msg,
}