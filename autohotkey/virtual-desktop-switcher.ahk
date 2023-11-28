#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

; RegRead, CurrentDesktopName, Computer\HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VirtualDesktops\Desktops\{05D06443-1B5B-49A6-BF61-AFF6B9F2E793}, Name
; source: https://github.com/pmb6tz/windows-desktop-switcher/blob/master/desktop_switcher.ahk