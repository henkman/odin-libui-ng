package main

import libc "core:c/libc"
import ui ".."

main :: proc() {
	opts : ui.InitOptions
    libc.printf("Init\n")
	err := ui.Init(&opts)
    if err != nil {
        libc.printf("Init error: %s\n", err)
        ui.FreeInitError(&err)
        return
    }
    libc.printf("Uninit\n")
    ui.Uninit()
}
