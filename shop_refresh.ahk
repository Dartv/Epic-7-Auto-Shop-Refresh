CoordMode, Mouse, Window
CoordMode, Pixel, Window
SetTitleMatchMode, 2

FocusWindow() {
    tt = Epic Seven ahk_class CROSVM_1
    WinWait, %tt%
    IfWinNotActive, %tt%,, WinActivate, %tt%
}

Sleep() {
    Random, rand, 200, 300
    sleep, %rand%
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
        MouseClick, L, FoundX + 840, FoundY + 80
        Sleep()
        MouseClick, L, 1024, 760
}

AutoRefresh() {
    FocusWindow()

    WinGetPos, OutX, OutY, OutWidth, OutHeight, A

    if (OutWidth != 1920 || OutHeight != 1080) {
        MsgBox, The active window is %OutWidth%x%OutHeight%, set to 1920x1080
        return
    }

    SearchAndBuy("covenant")
    Sleep()
    SearchAndBuy("mystic")

    Scroll()

    SearchAndBuy("covenant")
    Sleep()
    SearchAndBuy("mystic")

    Refresh()

    AutoRefresh()

    return
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
