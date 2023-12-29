package main

import libc "core:c/libc"
import ui ".."

onClosing :: proc "c" (w: ^ui.Window, data: rawptr) -> bool {
    ui.Quit()
    return true
}

main :: proc() {
	opts : ui.InitOptions
    libc.printf("Init\n")
	err := ui.Init(&opts)
    if err != nil {
        libc.printf("Init error: %s\n", err)
        ui.FreeInitError(&err)
        return
    }

    win : ^ui.Window

    m := ui.NewMenu("main")
    mi := ui.MenuAppendItem(m, "click me")
    ui.MenuItemOnClicked(mi, proc "c" (mi: ^ui.MenuItem, data: rawptr) {
        ui.MsgBox(transmute(^ui.Window)data, "yo", "well clicked!")
    }, win)
    ami := ui.MenuAppendAboutItem(m)
    ui.MenuItemOnClicked(ami, proc "c" (mi: ^ui.MenuItem, data: rawptr) {
        ui.MsgBoxError(transmute(^ui.Window)data, "OH NO ERROR", "joke. all is fine :)")
    }, win)

    win = ui.NewWindow("hello world", 300, 30, true)
    ui.WindowOnClosing(win, onClosing, nil)
    vb := ui.NewVerticalBox()
    
    e := ui.NewEntry()
    ui.EntrySetText(e, "thingiemabob")
    ui.BoxAppend(vb, e, false)

    rb := ui.NewRadioButtons()
    ui.RadioButtonsAppend(rb, "yes")
    ui.RadioButtonsAppend(rb, "no")
    ui.RadioButtonsAppend(rb, "maybe")
    ui.RadioButtonsAppend(rb, "I don't know")
    ui.BoxAppend(vb, rb, true)

    l := ui.NewButton("hello 세계")
    ui.ButtonOnClicked(l, proc "c" (b: ^ui.Button, data: rawptr) {
        libc.printf("window handle: %x\n", ui.ControlHandle(transmute(^ui.Window)data))
    }, win)
    ui.BoxAppend(vb, l, false)
    
    ui.WindowSetChild(win, vb)
    ui.ControlShow(win)
    ui.Main()
    
    libc.printf("Uninit\n")
    ui.Uninit()
}