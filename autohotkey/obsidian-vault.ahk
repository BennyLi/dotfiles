class ObsidianVaultHandler
{
  LastActiveWindowId := ""
  ShellClass := "ahk_class Shell_TrayWnd"

  WindowWidth := 1200
  WindowHeight := 1000
  WindowTitle := "Obsidian"

  AppFolder := "C:\SPU\tools\PortableApps\PortableApps\ObsidianPortable\"
  AppExe := "Obsidian.exe"
  AppContentUrl := "obsidian://open?vault=TK-Vault&file=README"
  
  HandleHotkey()
  {
    ;TrayTip, "Obsidian", "HandleHotkey"
    If WinExist("ahk_exe " . this.AppExe) {
      this.ToggleObsidian()
    } else {
      this.InitObsidian()
    }
  }

  ShowObsidian() {
    windowId := ""
    WinGet, windowId, ID, % "ahk_exe " . this.AppExe

    WinMove, % "ahk_id " . windowId,, (A_ScreenWidth/2)-(this.WindowWidth/2), (A_ScreenHeight/2)-(this.WindowHeight/2), this.WindowWidth, this.WindowHeight
    WinActivate % "ahk_id " . windowId
    WinShow % "ahk_id " . windowId
  }

  HideObsidian()
  {
    windowId := ""
    WinGet, windowId, ID, % "ahk_exe " . this.AppExe

    If (windowId = this.LastActiveWindowId) {
      newLastActiveWindowId := ""
      WinGet, newLastActiveWindowId, ID, % this.ShellClass
      this.LastActiveWindowId := newLastActiveWindowId
    }

    WinActivate % "ahk_id " . this.LastActiveWindowId
    WinHide % "ahk_id " . windowId
  }

  ToggleObsidian() {
    If WinActive("ahk_exe " . this.AppExe) {
      this.HideObsidian()
    } else {
      lastActiveWindowId := ""
      WinGet, lastActiveWindowId, ID, A
      this.LastActiveWindowId := lastActiveWindowId

      this.ShowObsidian()
    }
  }

  InitObsidian() {

    lastActiveWindowId := ""
    windowId := ""

    WinGet, lastActiveWindowId, ID, A
    this.LastActiveWindowId := lastActiveWindowId

    Run, % this.AppFolder . this.AppExe . " " . this.AppContentUrl
    WinWait, % "ahk_exe " . this.AppExe
    ;Sleep, 5000
    WinGet, windowId, ID, % "ahk_exe " . this.AppExe

    TrayTip, "Obsidian", % "ahk_exe = " . this.AppExe . " / windowId = " . windowId

    WinHide ahk_id windowId

    ;WinSet, Style, -0x00C00000, ahk_id windowId ; WS_CAPTION - no border and title
    ;WinSet, Style, -0x00040000, ahk_id windowId ; WS_SIZEBOX - no resize

    ;WinSet, ExStyle, +0x00000080, ahk_id windowId ; WS_EX_TOOLWINDOW
    ;WinSet, ExStyle, +0x00000100, ahk_id windowId ; WS_EX_OVERLAPPEDWINDOW

    this.ShowObsidian()
  }
}
