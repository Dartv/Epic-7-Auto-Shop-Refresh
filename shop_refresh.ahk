﻿CoordMode, Mouse, Window
CoordMode, Pixel, Window
SetTitleMatchMode, 2

; Works with google play games only
FocusWindow() {
    tt = Epic Seven ahk_class CROSVM_1
    IfWinNotActive, %tt%,, WinActivate, %tt%
}

Sleep(time := 300) {
    sleep, %time%
}

Refresh() {
    Random, x, 315, 325
    MouseClick, L, %x%, 990
    Sleep()
    Random, x, 1020, 1030
    MouseClick, L, %x%, 660
}

Scroll() {
    Random, x1, 1020, 1030
    Random, x2, 1020, 1030
    Random, y1, 895, 905
    Random, y2, 595, 605
    MouseClickDrag, left, %x1%, %y1%, %x2%, %y2%
}

SearchAndBuy(name) {
    ImageSearch, FoundX, FoundY, 820, 0, 1024, 1080, *128 %A_ScriptDir%\%name%.png
    
    if (ErrorLevel = 2)
        MsgBox Could not conduct the search. Icon not found?
    else if (ErrorLevel = 0)
        MouseClick, L, FoundX + 900, FoundY + 90
        Sleep()
        MouseClick, L, 1024, 760
        Sleep()
}

AutoRefresh() {
    FocusWindow()

    WinGetPos, OutX, OutY, OutWidth, OutHeight, A

    if (OutWidth != 1920 || OutHeight != 1080) {
        MsgBox, The active window is %OutWidth%x%OutHeight%, set to 1920x1080
        return
    }

    loop {
        sleep, % 50

        SearchAndBuy("covenant")
        SearchAndBuy("mystic")

        sleep, % 50

        Scroll()

        sleep, % 50

        SearchAndBuy("covenant")
        SearchAndBuy("mystic")

        Refresh()

        ; wait for transition to finish
        sleep, % 1000
    }
}

LogMousePos() {
    FocusWindow()

    MouseGetPos, X, Y
    MsgBox %X%x%Y%
    return
}

F1::
    AutoRefresh()
return

F2::Pause

Esc::ExitApp
