; source: https://gist.github.com/ovcharik/397e02e1bcfe4d4473ae2cbdde09a7aa
#NoEnv
#SingleInstance force

SetWinDelay, -1
DetectHiddenWindows, on

Menu, Tray, NoStandard
; Menu, Tray, Icon, wt-tilda.ico
Menu, Tray, Add, Exit, Exit


last_active_id := ""

shell_class := "ahk_class Shell_TrayWnd"

terminal_width := 1200
terminal_height := 600
terminal_title := "Hyper"
terminal_app_folder := "C:\SPU\tools\PortableApps\PortableApps\HyperPortable\"
terminal_exe := "Hyper.exe"
terminal_id := ""

; hide/show on F1
F1::
  If WinExist(terminal_title) {
    WinGet, terminal_id, ID, %terminal_title%
    toggle()
  } else {
    init()
  }
  return

Exit:
  ExitApp

; methods
showConsole() {
  global
  WinMove, ahk_id %terminal_id%,, (A_ScreenWidth/2)-(terminal_width/2), (A_ScreenHeight/2)-(terminal_height/2), terminal_width, terminal_height
  WinActivate ahk_id %terminal_id%
    WinShow ahk_id %terminal_id%
}

toggle() {
  global

  If WinActive("ahk_id " . terminal_id) {
    ; last active window is console
    If (terminal_id = last_active_id) {
      WinGet, last_active_id, ID, %shell_class%
    }
    WinActivate ahk_id %last_active_id%
    WinHide ahk_id %terminal_id%
  } else {
    ; update last active window
    WinGet, last_active_id, ID, A
    showConsole()
  }
}

init() {
  global

  WinGet, last_active_id, ID, A

  Run, %terminal_app_folder%%terminal_exe%
  WinWait, %terminal_title%
  WinGet, terminal_id, ID, %terminal_title%
  WinHide ahk_id %terminal_id%

  WinSet, Style, -0x00C00000, ahk_id %terminal_id% ; WS_CAPTION - no border and title
  WinSet, Style, -0x00040000, ahk_id %terminal_id% ; WS_SIZEBOX - no resize

  WinSet, ExStyle, +0x00000080, ahk_id %terminal_id% ; WS_EX_TOOLWINDOW
  WinSet, ExStyle, +0x00000100, ahk_id %terminal_id% ; WS_EX_OVERLAPPEDWINDOW

  showConsole()
}