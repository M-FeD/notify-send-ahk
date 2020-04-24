#SingleInstance, force
#NoTrayIcon

if A_Args.Length() = 0
{
    ExitApp
}

Message := A_Args[1]

Gui, Font, s10, Noto Sans
Gui, Margin, 5, 5
Gui, Color, 161616
Gui, +Border +AlwaysOnTop +Disabled -ToolWindow -Caption -SysMenu +Owner


Gui, Add, Text, x10 y0 Right, %Message%
Gui_GetAutoSize(width, height, 5, 5)
Offset := (1920 - width + 3)
Gui, Show, AutoSize x%Offset% y100, Notification



SetTimer, ExitAppTimer, 5000

Return

^+c::
ExitApp

;ExitApp

Gui_GetAutoSize(ByRef width, ByRef height, marginX, marginY) {
Gui, +Lastfound
WinGet, ctrls, ControlList
width := 0, height := 0
Loop, Parse, ctrls, `n
  { ctrl := A_LoopField
    ControlGetPos, x, y, w, h, % ctrl
    offsetX := x+w, offsetY := y+h
    width := offsetX > width ? offsetX : width
    height := offsetY > height ? offsetY : height += 5
  } width += marginX, height += marginY -= 3
}

ExitAppTimer:
  ExitApp
Return

