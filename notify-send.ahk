#SingleInstance, force
#NoTrayIcon

; Config

FontName = Arial
BgColor = 161616
FontSize = 15
DefaultTimeout := 5000

; Don't run if no arguments

if A_Args.Length() = 0
{
  ExitApp
}

; Default timeout

timeout := % DefaultTimeout

; Check for timeout argument

for index, value in A_Args
{
  if % value == "-t"
  {
    if A_Args[(index+1)] is Integer
    {
     timeout := % A_Args[(index+1)]
    }
  }
}

; First argument is the message

Message := A_Args[1]

Gui, +Border +AlwaysOnTop -ToolWindow -Caption -SysMenu +Owner
Gui, Font, s%FontSize%, %FontName%
Gui, Color, %BgColor%
Gui, Margin, 5, 5
Gui, Add, Text, x10 y0 Right gExitAppTimer, %Message%
Gui_GetAutoSize(width, height, 5, 5)
Offset := (1920 - width + 3)
Gui, Show, AutoSize x%Offset% y100, Notification
SetTimer, ExitAppTimer, %timeout%
Return

; Copied straight from stack overflow somewhere but it werks so idc

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

; Probably unnecessary but just putting "ExitApp"
; in the SetTimer bit didn't work so here we are

ExitAppTimer:
  ExitApp
Return