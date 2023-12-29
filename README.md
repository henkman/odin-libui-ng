# odin-libui-ng

Binding for [Odin](https://odin-lang.org/) to [libui-ng](https://github.com/libui-ng/libui-ng)

## Install

Clone this repository into odin/shared/ui (`git clone https://github.com/henkman/odin-libui-ng.git`).  
Static libraries for linux, macos and windows (all amd64) are provided.  
Sample:
```
package main

import ui "shared:ui"

main :: proc() {
    if err := ui.Init(&ui.InitOptions{}); err != nil {
        ui.FreeInitError(&err)
        return
    }
    win := ui.NewWindow("hello world", 200, 30, false)
    ui.WindowOnClosing(win, proc "c" (w: ^ui.Window, data: rawptr) -> bool {
        ui.Quit()
        return true
    }, nil)
    l := ui.NewLabel("Hallöchen 세계")
    ui.WindowSetChild(win, l)
    ui.ControlShow(win)
    ui.Main()
    ui.Uninit()
}
```
Note: On Windows you need to include a manifest.  
Use the following in your build command:    
`-resource=path_to_odin/shared/ui/windows/libui.rc`