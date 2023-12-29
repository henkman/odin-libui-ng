package ui

import "core:c"
import "core:c/libc"

when ODIN_OS == .Windows {
	@(extra_linker_flags = "/NODEFAULTLIB:library")
	foreign import lib {
        "windows/libui.a",
        "system:User32.lib",
        "system:Gdi32.lib",
        "system:Comctl32.lib",
        "system:Ole32.lib",
        "system:D2d1.lib",
        "system:Dwrite.lib",
        "system:UxTheme.lib",
        "system:windowscodecs.lib",
    }
} else when ODIN_OS == .Linux {
	foreign import lib {
        "linux/libui.a",
        "system:gtk-3",
        "system:gdk-3",
        "system:pangocairo-1.0",
        "system:pango-1.0",
        "system:harfbuzz",
        "system:atk-1.0",
        "system:cairo-gobject",
        "system:cairo",
        "system:gdk_pixbuf-2.0",
        "system:gio-2.0",
        "system:gobject-2.0",
        "system:glib-2.0",
    }
} else when ODIN_OS == .Darwin {
	foreign import lib {
        "macos/libui.a",
        "system:Cocoa.framework",
    }
} else {
	foreign import lib "system:libui"
}

ForEach :: enum uint {
	Continue,
	Stop,
}

InitOptions :: struct {
	Size: c.size_t,
}

Control :: struct {
	Signature:     c.uint32_t,
	OSSignature:   c.uint32_t,
	TypeSignature: c.uint32_t,
	Destroy:       proc "c" (_: ^Control),
	Handle:        proc "c" (_: ^Control) -> c.uintptr_t,
	Parent:        proc "c" (_: ^Control) -> ^Control,
	SetParent:     proc "c" (_: ^Control, _: ^Control),
	Toplevel:      proc "c" (_: ^Control) -> int,
	Visible:       proc "c" (_: ^Control) -> int,
	Show:          proc "c" (_: ^Control),
	Hide:          proc "c" (_: ^Control),
	Enabled:       proc "c" (_: ^Control, _: ^Control) -> int,
	Enable:        proc "c" (_: ^Control),
	Disable:       proc "c" (_: ^Control),
}

Window :: struct {}
Button :: struct {}
Box :: struct {}
Checkbox :: struct {}
Entry :: struct {}
Label :: struct {}
Tab :: struct {}
Group :: struct {}
SpinBox :: struct {}
Slider :: struct {}
ProgressBar :: struct {}
Separator :: struct {}
Combobox :: struct {}
EditableCombobox :: struct {}
RadioButtons :: struct {}
DateTimePicker :: struct {}
MultilineEntry :: struct {}
FontButton :: struct {}
ColorButton :: struct {}
Form :: struct {}
Grid :: struct {}
Table :: struct {}

AnyControlPtr :: union {
	^Control,
	^Window,
	^Button,
	^Box,
	^Checkbox,
	^Entry,
	^Label,
	^Tab,
	^Group,
	^SpinBox,
	^Slider,
	^ProgressBar,
	^Separator,
	^Combobox,
	^EditableCombobox,
	^RadioButtons,
	^DateTimePicker,
	^MultilineEntry,
	^FontButton,
	^ColorButton,
	^Form,
	^Grid,
	^Table,
}

MenuItem :: struct {}
Menu :: struct {}

Area :: struct {}
AreaHandler :: struct {
	Draw:         proc "c" (_: ^AreaHandler, _: ^Area, _: ^AreaDrawParams),
	MouseEvent:   proc "c" (_: ^AreaHandler, _: ^Area, _: ^AreaMouseEvent),
	MouseCrossed: proc "c" (ah: ^AreaHandler, a: ^Area, left: int),
	DragBroken:   proc "c" (_: ^AreaHandler, _: ^Area),
	KeyEvent:     proc "c" (_: ^AreaHandler, _: ^Area, _: ^AreaKeyEvent) -> int,
}
AreaDrawParams :: struct {
	Context:               ^DrawContext,
	AreaWidth, AreaHeight: f64,
	ClipX, ClipY:          f64,
	ClipWidth, ClipHeight: f64,
}

DrawContext :: struct {}

WindowResizeEdge :: enum uint {
	Left,
	Top,
	Right,
	Bottom,
	TopLeft,
	TopRight,
	BottomLeft,
	BottomRight,
}

DrawPath :: struct {}

DrawBrushType :: enum uint {
	Solid,
	LinearGradient,
	RadialGradient,
	Image,
}

DrawLineCap :: enum uint {
	Flat,
	Round,
	Square,
}
DrawLineJoin :: enum uint {
	Miter,
	Round,
	Bevel,
}
DrawFillMode :: enum uint {
	Winding,
	Alternate,
}

DrawMatrix :: struct {
	M11: f64,
	M12: f64,
	M21: f64,
	M22: f64,
	M31: f64,
	M32: f64,
}

DrawBrush :: struct {
	Type:        DrawBrushType,
	R, G, B, A:  f64,
	X0, Y0:      f64,
	X1, Y1:      f64,
	OuterRadius: f64,
	Stops:       [^]DrawBrushGradientStop,
	NumStops:    c.size_t,
}

DrawBrushGradientStop :: struct {
	Pos:        f64,
	R, G, B, A: f64,
}

DrawStrokeParams :: struct {
	Cap:        DrawLineCap,
	Join:       DrawLineJoin,
	Thickness:  f64,
	MiterLimit: f64,
	Dashes:     [^]f64,
	NumDashes:  c.size_t,
	DashPhase:  f64,
}

Attribute :: struct {}

AttributeType :: enum uint {
	Family,
	Size,
	Weight,
	Italic,
	Stretch,
	Color,
	Background,
	Underline,
	UnderlineColor,
	Features,
}

TextWeight :: enum uint {
	Minimum    = 0,
	Thin       = 100,
	UltraLight = 200,
	Light      = 300,
	Book       = 350,
	Normal     = 400,
	Medium     = 500,
	SemiBold   = 600,
	Bold       = 700,
	UltraBold  = 800,
	Heavy      = 900,
	UltraHeavy = 950,
	Maximum    = 1000,
}

TextItalic :: enum uint {
	Normal,
	Oblique,
	Italic,
}

TextStretch :: enum uint {
	UltraCondensed,
	ExtraCondensed,
	Condensed,
	SemiCondensed,
	Normal,
	SemiExpanded,
	Expanded,
	ExtraExpanded,
	UltraExpanded,
}

Underline :: enum uint {
	None,
	Single,
	Double,
	Suggestion,
}

UnderlineColor :: enum uint {
	Custom,
	Spelling,
	Grammar,
	Auxiliary,
}

OpenTypeFeatures :: struct {}
OpenTypeFeaturesForEachFunc :: #type proc "c" (
	otf: ^OpenTypeFeatures,
	a, b, c, d: c.char,
	value: libc.uint32_t,
	data: rawptr,
) -> ForEach

AttributedString :: struct {}
AttributedStringForEachAttributeFunc :: #type proc "c" (
	s: ^AttributedString,
	a: ^Attribute,
	start, end: c.size_t,
	data: rawptr,
) -> ForEach

FontDescriptor :: struct {
	Family:  cstring,
	Size:    f64,
	Weight:  TextWeight,
	Italic:  TextItalic,
	Stretch: TextStretch,
}

DrawTextLayout :: struct {}

DrawTextAlign :: enum uint {
	Left,
	Center,
	Right,
}

DrawTextLayoutParams :: struct {
	String:      ^AttributedString,
	DefaultFont: ^FontDescriptor,
	Width:       f64,
	Align:       DrawTextAlign,
}

Modifiers :: enum uint {
	Ctrl  = 1 << 0, //!< Control key.
	Alt   = 1 << 1, //!< Alternate/Option key.
	Shift = 1 << 2, //!< Shift key.
	Super = 1 << 3, //!< Super/Command/Windows key.
}

AreaMouseEvent :: struct {
	X, Y:                  f64,
	AreaWidth, AreaHeight: f64,
	Down, Up:              int,
	Count:                 int,
	Modifiers:             Modifiers,
	Held1To64:             c.uint64_t,
}

ExtKey :: enum uint {
	Escape = 1,
	Insert, // equivalent to "Help" on Apple keyboards
	Delete,
	Home,
	End,
	PageUp,
	PageDown,
	Up,
	Down,
	Left,
	Right,
	F1, // F1..F12 are guaranteed to be consecutive
	F2,
	F3,
	F4,
	F5,
	F6,
	F7,
	F8,
	F9,
	F10,
	F11,
	F12,
	N0, // numpad keys; independent of Num Lock state
	N1, // N0..N9 are guaranteed to be consecutive
	N2,
	N3,
	N4,
	N5,
	N6,
	N7,
	N8,
	N9,
	NDot,
	NEnter,
	NAdd,
	NSubtract,
	NMultiply,
	NDivide,
}

AreaKeyEvent :: struct {
	Key:       c.char,
	ExtKey:    ExtKey,
	Modifier:  Modifiers,
	Modifiers: Modifiers,
	Up:        int,
}

Align :: enum uint {
	Fill, //!< Fill area.
	Start, //!< Place at start.
	Center, //!< Place in center.
	End, //!< Place at end.
}

At :: enum uint {
	Leading, //!< Place before control.
	Top, //!< Place above control.
	Trailing, //!< Place behind control.
	Bottom, //!< Place below control.
}

Image :: struct {}

TableValue :: struct {}
TableValueType :: enum uint {
	String,
	Image,
	Int,
	Color,
}
SortIndicator :: enum uint {
	None,
	Ascending,
	Descending,
}

TableModel :: struct {}
TableModelHandler :: struct {
	NumColumns:   proc "c" (_: ^TableModelHandler, _: ^TableModel) -> int,
	ColumnType:   proc "c" (mh: ^TableModelHandler, m: ^TableModel, column: int) -> TableValueType,
	NumRows:      proc "c" (_: ^TableModelHandler, _: ^TableModel) -> int,
	CellValue:    proc "c" (
		mh: ^TableModelHandler,
		m: ^TableModel,
		row, column: int,
	) -> ^TableValue,
	SetCellValue: proc "c" (
		mh: ^TableModelHandler,
		m: ^TableModel,
		row, column: int,
		val: ^TableValue,
	),
}

TableModelColumnNeverEditable: int : -1
TableModelColumnAlwaysEditable: int : -2

TableTextColumnOptionalParams :: struct {
	ColorModelColumn: int,
}

TableParams :: struct {
	Model:                         ^TableModel,
	RowBackgroundColorModelColumn: int,
}

TableSelectionMode :: enum uint {
	None,
	ZeroOrOne, //!< Allow zero or one row to be selected.
	One, //!< Allow for exactly one row to be selected.
	ZeroOrMany, //!< Allow zero or many (multiple) rows to be selected.
}

TableSelection :: struct {
	NumRows: int, //!< Number of selected rows.
	Rows:    ^int, //!< Array containing selected row indices, NULL on empty selection.
}

@(default_calling_convention = "c", link_prefix = "ui")
foreign lib {
	Init :: proc(options: ^InitOptions) -> cstring ---
	Uninit :: proc() ---
	FreeInitError :: proc(err: ^cstring) ---
	Main :: proc() ---
	MainSteps :: proc() ---
	MainStep :: proc() ---
	Quit :: proc() ---
	QueueMain :: proc(f: proc "c" (_: rawptr), data: rawptr) ---
	Timer :: proc(milliseconds: int, f: proc "c" (_: rawptr) -> bool, data: rawptr) ---
	OnShouldQuit :: proc(f: proc "c" (_: rawptr) -> bool, data: rawptr) ---
	FreeText :: proc(text: cstring) ---

	ControlDestroy :: proc(c: AnyControlPtr) ---
	ControlHandle :: proc(c: AnyControlPtr) -> libc.uintptr_t ---
	ControlParent :: proc(c: AnyControlPtr) -> ^Control ---
	ControlSetParent :: proc(c, parent: AnyControlPtr) ---
	ControlToplevel :: proc(c: AnyControlPtr) -> bool ---
	ControlVisible :: proc(c: AnyControlPtr) -> bool ---
	ControlShow :: proc(c: AnyControlPtr) ---
	ControlHide :: proc(c: AnyControlPtr) ---
	ControlEnabled :: proc(c: AnyControlPtr) -> bool ---
	ControlEnable :: proc(c: AnyControlPtr) ---
	ControlDisable :: proc(c: AnyControlPtr) ---
	AllocControl :: proc(n: c.size_t, OSsig, typesig: libc.uint32_t, typenamestr: cstring) -> ^Control ---
	FreeControl :: proc(c: AnyControlPtr) ---
	ControlVerifySetParent :: proc(c, parent: AnyControlPtr) ---
	ControlEnabledToUser :: proc(c: AnyControlPtr) -> bool ---
	UserBugCannotSetParentOnToplevel :: proc(type: cstring) ---

	WindowTitle :: proc(w: ^Window) -> cstring ---
	WindowSetTitle :: proc(w: ^Window, title: cstring) ---
	WindowPosition :: proc(w: ^Window, x, y: int) ---
	WindowSetPosition :: proc(w: ^Window, x, y: int) ---
	WindowOnPositionChanged :: proc(w: ^Window, f: proc "c" (_: ^Window, _: rawptr), data: rawptr) ---
	WindowContentSize :: proc(w: ^Window, width, height: ^int) ---
	WindowSetContentSize :: proc(w: ^Window, width, height: int) ---
	WindowFullscreen :: proc(w: ^Window) -> bool ---
	WindowSetFullscreen :: proc(w: ^Window, fullscreen: bool) ---
	WindowOnContentSizeChanged :: proc(w: ^Window, f: proc "c" (_: ^Window, _: rawptr), data: rawptr) ---
	WindowOnClosing :: proc(w: ^Window, callback: proc "c" (_: ^Window, _: rawptr) -> bool, data: rawptr) ---
	WindowOnFocusChanged :: proc(w: ^Window, f: proc "c" (_: ^Window, _: rawptr), data: rawptr) ---
	WindowFocused :: proc(w: ^Window) -> bool ---
	WindowBorderless :: proc(w: ^Window) -> bool ---
	WindowSetBorderless :: proc(w: ^Window, borderless: bool) ---
	WindowSetChild :: proc(w: ^Window, child: AnyControlPtr) ---
	WindowMargined :: proc(w: ^Window) -> bool ---
	WindowSetMargined :: proc(w: ^Window, margined: bool) ---
	WindowResizeable :: proc(w: ^Window) -> bool ---
	WindowSetResizeable :: proc(w: ^Window, resizeable: bool) ---
	NewWindow :: proc(title: cstring, width, height: int, hasMenubar: bool) -> ^Window ---

	ButtonText :: proc(b: ^Button) -> cstring ---
	ButtonSetText :: proc(b: ^Button, text: cstring) ---
	ButtonOnClicked :: proc(b: ^Button, f: proc "c" (_: ^Button, _: rawptr), data: rawptr) ---
	NewButton :: proc(text: cstring) -> ^Button ---

	BoxAppend :: proc(b: ^Box, child: AnyControlPtr, stretchy: bool) ---
	BoxNumChildren :: proc(b: ^Box) -> int ---
	BoxDelete :: proc(b: ^Box, index: int) ---
	BoxPadded :: proc(b: ^Box) -> bool ---
	BoxSetPadded :: proc(b: ^Button, padded: bool) ---
	NewHorizontalBox :: proc() -> ^Box ---
	NewVerticalBox :: proc() -> ^Box ---

	CheckboxText :: proc(c: ^Checkbox) -> cstring ---
	CheckboxSetText :: proc(c: ^Checkbox, text: cstring) ---
	CheckboxOnToggled :: proc(c: ^Checkbox, f: proc "c" (_: ^Checkbox, _: rawptr), data: rawptr) ---
	CheckboxChecked :: proc(c: ^Checkbox) -> bool ---
	CheckboxSetChecked :: proc(c: ^Checkbox, checked: bool) ---
	NewCheckbox :: proc(text: cstring) -> ^Checkbox ---

	EntryText :: proc(e: ^Entry) -> cstring ---
	EntrySetText :: proc(e: ^Entry, text: cstring) ---
	EntryOnChanged :: proc(e: ^Entry, f: proc "c" (_: ^Entry, _: rawptr), data: rawptr) ---
	EntryReadOnly :: proc(e: ^Entry) -> bool ---
	EntrySetReadOnly :: proc(e: ^Entry, readonly: bool) ---
	NewEntry :: proc() -> ^Entry ---
	NewPasswordEntry :: proc() -> ^Entry ---
	NewSearchEntry :: proc() -> ^Entry ---

	LabelText :: proc(l: ^Label) -> cstring ---
	LabelSetText :: proc(l: ^Label, text: cstring) ---
	NewLabel :: proc(text: cstring) -> ^Label ---

	TabAppend :: proc(t: ^Tab, name: cstring, c: AnyControlPtr) ---
	TabInsertAt :: proc(t: ^Tab, name: cstring, index: int, c: AnyControlPtr) ---
	TabDelete :: proc(t: ^Tab, index: int) ---
	TabNumPages :: proc(t: ^Tab) -> int ---
	TabMargined :: proc(t: ^Tab, index: int) -> bool ---
	TabSetMargined :: proc(t: ^Tab, index: int, margined: bool) ---
	NewTab :: proc() -> ^Tab ---

	GroupTitle :: proc(g: ^Group) -> cstring ---
	GroupSetTitle :: proc(g: ^Group, title: cstring) ---
	GroupSetChild :: proc(g: ^Group, c: AnyControlPtr) ---
	GroupMargined :: proc(g: ^Group) -> bool ---
	GroupSetMargined :: proc(g: ^Group, margined: bool) ---
	NewGroup :: proc(title: cstring) -> ^Group ---

	SpinboxValue :: proc(s: ^SpinBox) -> int ---
	SpinboxSetValue :: proc(s: ^SpinBox, value: int) ---
	SpinboxOnChanged :: proc(s: ^SpinBox, f: proc "c" (_: ^SpinBox, _: rawptr), data: rawptr) ---
	NewSpinbox :: proc(min, max: int) -> ^SpinBox ---

	SliderValue :: proc(s: ^Slider) -> int ---
	SliderSetValue :: proc(s: ^Slider, value: int) ---
	SliderHasToolTip :: proc(s: ^Slider) -> bool ---
	SliderSetHasToolTip :: proc(s: ^Slider, hasToolTip: bool) ---
	SliderOnChanged :: proc(s: ^Slider, f: proc "c" (_: ^Slider, _: rawptr), data: rawptr) ---
	SliderOnReleased :: proc(s: ^Slider, f: proc "c" (_: ^Slider, _: rawptr), data: rawptr) ---
	SliderSetRange :: proc(s: ^Slider, min, max: int) ---
	NewSlider :: proc(min, max: int) -> ^Slider ---

	ProgressBarValue :: proc(p: ^ProgressBar) -> int ---
	ProgressBarSetValue :: proc(p: ^ProgressBar, n: int) ---
	NewProgressBar :: proc() -> ^ProgressBar ---

	NewHorizontalSeparator :: proc() -> ^Separator ---
	NewVerticalSeparator :: proc() -> ^Separator ---

	ComboboxAppend :: proc(c: ^Combobox, text: cstring) ---
	ComboboxInsertAt :: proc(c: ^Combobox, index: int, text: cstring) ---
	ComboboxDelete :: proc(c: ^Combobox, index: int) ---
	ComboboxClear :: proc(c: ^Combobox) ---
	ComboboxNumItems :: proc(c: ^Combobox) -> int ---
	ComboboxSelected :: proc(c: ^Combobox) -> int ---
	ComboboxSetSelected :: proc(c: ^Combobox, index: int) ---
	ComboboxOnSelected :: proc(c: ^Combobox, f: proc "c" (_: ^Combobox, _: rawptr), data: rawptr) ---
	NewCombobox :: proc() -> ^Combobox ---

	EditableComboboxAppend :: proc(c: ^EditableCombobox, text: cstring) ---
	EditableComboboxText :: proc(c: ^EditableCombobox) -> cstring ---
	EditableComboboxSetText :: proc(c: ^EditableCombobox, text: cstring) ---
	EditableComboboxOnChanged :: proc(c: ^EditableCombobox, f: proc "c" (_: ^EditableCombobox, _: rawptr), data: rawptr) ---
	NewEditableCombobox :: proc() -> ^EditableCombobox ---

	RadioButtonsAppend :: proc(r: ^RadioButtons, text: cstring) ---
	RadioButtonsSelected :: proc(r: ^RadioButtons) -> int ---
	RadioButtonsSetSelected :: proc(r: ^RadioButtons, index: int) ---
	RadioButtonsOnSelected :: proc(r: ^RadioButtons, f: proc "c" (_: ^RadioButtons, _: rawptr), data: rawptr) ---
	NewRadioButtons :: proc() -> ^RadioButtons ---

	DateTimePickerTime :: proc(d: ^DateTimePicker, time: ^libc.tm) ---
	DateTimePickerSetTime :: proc(d: ^DateTimePicker, time: ^libc.tm) ---
	DateTimePickerOnChanged :: proc(d: ^DateTimePicker, f: proc "c" (_: ^DateTimePicker, _: rawptr), data: rawptr) ---
	NewDateTimePicker :: proc() -> ^DateTimePicker ---
	NewDatePicker :: proc() -> ^DateTimePicker ---
	NewTimePicker :: proc() -> ^DateTimePicker ---

	MultilineEntryText :: proc(e: ^MultilineEntry) -> cstring ---
	MultilineEntrySetText :: proc(e: ^MultilineEntry, text: cstring) ---
	MultilineEntryOnChanged :: proc(e: ^MultilineEntry, f: proc "c" (_: ^MultilineEntry, _: rawptr), data: rawptr) ---
	MultilineEntryReadOnly :: proc(e: ^MultilineEntry) -> int ---
	MultilineEntrySetReadOnly :: proc(e: ^MultilineEntry, readonly: int) ---
	NewMultilineEntry :: proc() -> ^MultilineEntry ---
	NewNonWrappingMultilineEntry :: proc() -> ^MultilineEntry ---

	ColorButtonColor :: proc(cb: ^ColorButton, r, g, b, a: ^f64) ---
	ColorButtonSetColor :: proc(cb: ^ColorButton, r, g, b, a: f64) ---
	ColorButtonOnChanged :: proc(cb: ^ColorButton, f: proc "c" (_: ^ColorButton, _: rawptr), data: rawptr) ---
	NewColorButton :: proc() -> ^ColorButton ---

	FormAppend :: proc(f: ^Form, label: cstring, c: AnyControlPtr, stretchy: int) ---
	FormNumChildren :: proc(f: ^Form) -> int ---
	FormDelete :: proc(f: ^Form, index: int) ---
	FormPadded :: proc(f: ^Form) -> bool ---
	FormSetPadded :: proc(f: ^Form, padded: bool) ---
	NewForm :: proc() -> ^Form ---

	GridAppend :: proc(g: ^Grid, c: AnyControlPtr, left, top, xspan, yspan, hexpand: int, halign: Align, vexpand: int, valign: Align) ---
	GridInsertAt :: proc(g: ^Grid, c, existing: AnyControlPtr, at: At, xspan, yspan, hexpand: int, halign: Align, vexpand: int, valign: Align) ---
	GridPadded :: proc(g: ^Grid) -> bool ---
	GridSetPadded :: proc(g: ^Grid, padded: bool) ---
	NewGrid :: proc() -> ^Grid ---

	MenuItemEnable :: proc(m: ^MenuItem) ---
	MenuItemDisable :: proc(m: ^MenuItem) ---
	MenuItemOnClicked :: proc(m: ^MenuItem, f: proc "c" (_: ^MenuItem, _: rawptr), data: rawptr) ---
	MenuItemChecked :: proc(m: ^MenuItem) -> bool ---
	MenuItemSetChecked :: proc(m: ^MenuItem, checked: bool) ---

	MenuAppendItem :: proc(m: ^Menu, name: cstring) -> ^MenuItem ---
	MenuAppendCheckItem :: proc(m: ^Menu, name: cstring) -> ^MenuItem ---
	MenuAppendQuitItem :: proc(m: ^Menu) -> ^MenuItem ---
	MenuAppendPreferencesItem :: proc(m: ^Menu) -> ^MenuItem ---
	MenuAppendAboutItem :: proc(m: ^Menu) -> ^MenuItem ---
	MenuAppendSeparator :: proc(m: ^Menu) ---
	NewMenu :: proc(name: cstring) -> ^Menu ---

	OpenFile :: proc(parent: ^Window) -> cstring ---
	OpenFolder :: proc(parent: ^Window) -> cstring ---
	SaveFile :: proc(parent: ^Window) -> cstring ---
	MsgBox :: proc(parent: ^Window, title, description: cstring) ---
	MsgBoxError :: proc(parent: ^Window, title, description: cstring) ---

	AreaSetSize :: proc(a: ^Area, width, height: int) ---
	AreaQueueRedrawAll :: proc(a: ^Area) ---
	AreaScrollTo :: proc(a: ^Area, x, y, width, height: f64) ---
	AreaBeginUserWindowMove :: proc(a: ^Area) ---
	AreaBeginUserWindowResize :: proc(a: ^Area, edge: WindowResizeEdge) ---
	NewArea :: proc(ah: ^AreaHandler) -> ^Area ---
	NewScrollingArea :: proc(ah: ^AreaHandler, width, height: int) -> ^Area ---

	DrawNewPath :: proc(fillMode: DrawFillMode) -> ^DrawPath ---
	DrawFreePath :: proc(p: ^DrawPath) ---
	DrawPathNewFigure :: proc(p: ^DrawPath, x, y: f64) ---
	DrawPathNewFigureWithArc :: proc(p: ^DrawPath, xCenter, yCenter, radius, startAngle, sweep: f64, negative: int) ---
	DrawPathLineTo :: proc(p: ^DrawPath, x, y: f64) ---
	DrawPathArcTo :: proc(p: ^DrawPath, xCenter, yCenter, radius, startAngle, sweep: f64, negative: int) ---
	DrawPathBezierTo :: proc(p: ^DrawPath, c1x, c1y, c2x, c2y, endX, endY: f64) ---
	DrawPathCloseFigure :: proc(p: ^DrawPath) ---
	DrawPathAddRectangle :: proc(p: ^DrawPath, x, y, width, height: f64) ---
	DrawPathEnded :: proc(p: ^DrawPath, x, y: f64) -> bool ---
	DrawPathEnd :: proc(p: ^DrawPath) ---
	DrawStroke :: proc(c: ^DrawContext, path: ^DrawPath, b: ^DrawBrush, p: ^DrawStrokeParams) ---
	DrawFill :: proc(c: ^DrawContext, path: ^DrawPath, b: ^DrawBrush) ---

	DrawMatrixSetIdentity :: proc(m: ^DrawMatrix) ---
	DrawMatrixTranslate :: proc(m: ^DrawMatrix, x, y: f64) ---
	DrawMatrixScale :: proc(m: ^DrawMatrix, xCenter, yCenter, x, y: f64) ---
	DrawMatrixRotate :: proc(m: ^DrawMatrix, x, y, amount: f64) ---
	DrawMatrixSkew :: proc(m: ^DrawMatrix, x, y, xamount, yamount: f64) ---
	DrawMatrixMultiply :: proc(m: ^DrawMatrix, src: ^DrawMatrix) ---
	DrawMatrixInvertible :: proc(m: ^DrawMatrix) -> int ---
	DrawMatrixInvert :: proc(m: ^DrawMatrix) -> int ---
	DrawMatrixTransformPoint :: proc(m: ^DrawMatrix, x, y: ^f64) ---
	DrawMatrixTransformSize :: proc(m: ^DrawMatrix, x, y: ^f64) ---

	DrawTransform :: proc(c: ^DrawContext, m: ^DrawMatrix) ---
	DrawClip :: proc(c: ^DrawContext, path: ^DrawPath) ---
	DrawSave :: proc(c: ^DrawContext) ---
	DrawRestore :: proc(c: ^DrawContext) ---

	FreeAttribute :: proc(a: ^Attribute) ---
	AttributeGetType :: proc(a: ^Attribute) -> AttributeType ---
	NewFamilyAttribute :: proc(family: cstring) -> ^Attribute ---
	AttributeFamily :: proc(a: ^Attribute) -> cstring ---
	NewSizeAttribute :: proc(size: f64) -> ^Attribute ---
	AttributeSize :: proc(a: ^Attribute) -> f64 ---
	NewWeightAttribute :: proc(weight: TextWeight) -> ^Attribute ---
	AttributeWeight :: proc(a: ^Attribute) -> TextWeight ---
	NewItalicAttribute :: proc(italic: TextItalic) -> ^Attribute ---
	AttributeItalic :: proc(a: ^Attribute) -> TextItalic ---
	NewStretchAttribute :: proc(stretch: TextStretch) -> ^Attribute ---
	AttributeStretch :: proc(a: ^Attribute) -> TextStretch ---
	NewColorAttribute :: proc(r, g, b, a: f64) -> ^Attribute ---
	AttributeColor :: proc(attr: ^Attribute, r, g, b, a: ^f64) ---
	NewBackgroundAttribute :: proc(r, g, b, a: f64) -> ^Attribute ---
	NewUnderlineAttribute :: proc(u: Underline) -> ^Attribute ---
	AttributeUnderline :: proc(a: ^Attribute) -> Underline ---
	NewUnderlineColorAttribute :: proc(u: UnderlineColor, r, g, b, a: f64) -> ^Attribute ---
	AttributeUnderlineColor :: proc(attr: ^Attribute, u: ^UnderlineColor, r, g, b, a: ^f64) ---

	NewOpenTypeFeatures :: proc() -> ^OpenTypeFeatures ---
	FreeOpenTypeFeatures :: proc(otf: ^OpenTypeFeatures) ---
	OpenTypeFeaturesClone :: proc(otf: ^OpenTypeFeatures) -> ^OpenTypeFeatures ---
	OpenTypeFeaturesAdd :: proc(otf: ^OpenTypeFeatures, a, b, c, d: c.char, value: libc.uint32_t) ---
	OpenTypeFeaturesRemove :: proc(otf: ^OpenTypeFeatures, a, b, c, d: c.char) ---
	OpenTypeFeaturesGet :: proc(otf: ^OpenTypeFeatures, a, b, c, d: c.char, value: ^libc.uint32_t) -> int ---
	OpenTypeFeaturesForEach :: proc(otf: ^OpenTypeFeatures, f: OpenTypeFeaturesForEachFunc, data: rawptr) ---
	NewFeaturesAttribute :: proc(otf: ^OpenTypeFeatures) -> ^Attribute ---
	AttributeFeatures :: proc(a: ^Attribute) -> ^OpenTypeFeatures ---

	NewAttributedString :: proc(initialString: cstring) -> ^AttributedString ---
	FreeAttributedString :: proc(s: ^AttributedString) ---
	AttributedStringString :: proc(s: ^AttributedString) -> cstring ---
	AttributedStringLen :: proc(s: ^AttributedString) -> c.size_t ---
	AttributedStringAppendUnattributed :: proc(s: ^AttributedString, str: cstring) ---
	AttributedStringInsertAtUnattributed :: proc(s: ^AttributedString, str: cstring, at: c.size_t) ---
	AttributedStringDelete :: proc(s: ^AttributedString, start, end: c.size_t) ---
	AttributedStringSetAttribute :: proc(s: ^AttributedString, a: ^Attribute, start, end: c.size_t) ---
	AttributedStringForEachAttribute :: proc(s: ^AttributedString, f: AttributedStringForEachAttributeFunc, data: rawptr) ---
	AttributedStringNumGraphemes :: proc(s: ^AttributedString) -> c.size_t ---
	AttributedStringByteIndexToGrapheme :: proc(s: ^AttributedString, pos: c.size_t) -> c.size_t ---
	AttributedStringGraphemeToByteIndex :: proc(s: ^AttributedString, pos: c.size_t) -> c.size_t ---

	LoadControlFont :: proc(f: ^FontDescriptor) ---
	FreeFontDescriptor :: proc(desc: ^FontDescriptor) ---

	DrawNewTextLayout :: proc(params: ^DrawTextLayoutParams) -> ^DrawTextLayout ---
	DrawFreeTextLayout :: proc(tl: ^DrawTextLayout) ---
	DrawText :: proc(c: ^DrawContext, tl: ^DrawTextLayout, x, y: f64) ---
	DrawTextLayoutExtents :: proc(tl: ^DrawTextLayout, width, height: ^f64) ---

	FontButtonFont :: proc(b: ^FontButton, desc: ^FontDescriptor) ---
	FontButtonOnChanged :: proc(b: ^FontButton, f: proc "c" (_: ^MenuItem, _: rawptr), data: rawptr) ---
	NewFontButton :: proc() -> ^FontButton ---
	FreeFontButtonFont :: proc(desc: ^FontDescriptor) ---

	NewImage :: proc(width, height: f64) -> ^Image ---
	FreeImage :: proc(i: ^Image) ---
	ImageAppend :: proc(i: ^Image, pixels: rawptr, pixelWidth, pixelHeight, byteStride: int) ---

	FreeTableValue :: proc(v: ^TableValue) ---
	TableValueGetType :: proc(v: ^TableValue) -> TableValueType ---
	NewTableValueString :: proc(str: cstring) -> ^TableValue ---
	TableValueString :: proc(v: ^TableValue) -> cstring ---
	NewTableValueImage :: proc(img: ^Image) -> ^TableValue ---
	TableValueImage :: proc(v: ^TableValue) -> ^Image ---
	NewTableValueInt :: proc(i: int) -> ^TableValue ---
	TableValueInt :: proc(v: ^TableValue) -> int ---
	NewTableValueColor :: proc(r, g, b, a: f64) -> ^TableValue ---
	TableValueColor :: proc(v: ^TableValue, r, g, b, a: ^f64) ---
	NewTableModel :: proc(mh: ^TableModelHandler) -> ^TableModel ---
	FreeTableModel :: proc(m: ^TableModel) ---
	TableModelRowInserted :: proc(m: ^TableModel, newIndex: int) ---
	TableModelRowChanged :: proc(m: ^TableModel, index: int) ---
	TableModelRowDeleted :: proc(m: ^TableModel, oldIndex: int) ---
	TableAppendTextColumn :: proc(t: ^Table, name: cstring, textModelColumn, textEditableModelColumn: int, textParams: ^TableTextColumnOptionalParams) ---
	TableAppendImageColumn :: proc(t: ^Table, name: cstring, imageModelColumn: int) ---
	TableAppendImageTextColumn :: proc(t: ^Table, name: cstring, imageModelColumn, textModelColumn, textEditableModelColumn: int, textParams: ^TableTextColumnOptionalParams) ---
	TableAppendCheckboxColumn :: proc(t: ^Table, name: cstring, checkboxModelColumn, checkboxEditableModelColumn: int) ---
	TableAppendCheckboxTextColumn :: proc(t: ^Table, name: cstring, checkboxModelColumn, checkboxEditableModelColumn, textModelColumn, textEditableModelColumn: int, textParams: ^TableTextColumnOptionalParams) ---
	TableAppendProgressBarColumn :: proc(t: ^Table, name: cstring, progressModelColumn: int) ---
	TableAppendButtonColumn :: proc(t: ^Table, name: cstring, buttonModelColumn, buttonClickableModelColumn: int) ---
	TableHeaderVisible :: proc(t: ^Table) -> bool ---
	TableHeaderSetVisible :: proc(t: ^Table, visible: bool) ---
	NewTable :: proc(params: ^TableParams) -> ^Table ---
	TableOnRowClicked :: proc(t: ^Table, f: proc "c" (_: ^Table, _: int, _: rawptr), data: rawptr) ---
	TableOnRowDoubleClicked :: proc(t: ^Table, f: proc "c" (_: ^Table, _: int, _: rawptr), data: rawptr) ---
	TableHeaderSetSortIndicator :: proc(t: ^Table, column: int, indicator: SortIndicator) ---
	TableHeaderSortIndicator :: proc(t: ^Table, column: int) -> SortIndicator ---
	TableHeaderOnClicked :: proc(t: ^Table, f: proc "c" (_: ^Table, _: int, _: rawptr), data: rawptr) ---
	TableColumnWidth :: proc(t: ^Table, column: int) -> int ---
	TableColumnSetWidth :: proc(t: ^Table, column, width: int) ---
	TableGetSelectionMode :: proc(t: ^Table, visible: int) -> TableSelectionMode ---
	TableSetSelectionMode :: proc(t: ^Table, mode: TableSelectionMode) ---
	TableOnSelectionChanged :: proc(t: ^Table, f: proc "c" (_: ^Table, _: rawptr), data: rawptr) ---
	TableGetSelection :: proc(t: ^Table) -> ^TableSelection ---
	TableSetSelection :: proc(t: ^Table, sel: ^TableSelection) ---
	FreeTableSelection :: proc(s: ^TableSelection) ---
}
