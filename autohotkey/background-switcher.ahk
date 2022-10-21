#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

+F1::
  run, powershell.exe -windowstyle hidden -ExecutionPolicy Bypass -File ..\win-change-background.ps1 -Color 000000 -Image "Nothing"
  return

+F2::
  run, powershell.exe -windowstyle hidden -ExecutionPolicy Bypass -File ..\win-change-background.ps1 -Color 000000 -Image "P:\Office\Eigene Bilder\wallpapers\Motivierend\Do something great [unsplash][Clark Tibbs].jpg"
  return

+F3::
  run, powershell.exe -windowstyle hidden -ExecutionPolicy Bypass -File ..\win-change-background.ps1 -Color 000000 -Image "P:\Office\Eigene Bilder\wallpapers\IT\think-twice-code-once.jpg"
  return

+F4::
  run, powershell.exe -windowstyle hidden -ExecutionPolicy Bypass -File ..\win-change-background.ps1 -Color 000000 -Image "P:\Office\Eigene Bilder\wallpapers\Motivierend\Go up and never stop [unsplash][Fab Lentz].jpg"
  return

+F5::
  run, powershell.exe -windowstyle hidden -ExecutionPolicy Bypass -File ..\win-change-background.ps1 -Color 000000 -Image "P:\Office\Eigene Bilder\wallpapers\Sport\Basketballkorb [unsplash][Artur Kornakov].jpg"
  return

+F6::
  run, powershell.exe -windowstyle hidden -ExecutionPolicy Bypass -File ..\win-change-background.ps1 -Color 000000 -Image "P:\Office\Eigene Bilder\wallpapers\The IT Crowds\The IT Crowd - Drink Milk and Kick Ass.jpg"
  return

+F7::
  run, powershell.exe -windowstyle hidden -ExecutionPolicy Bypass -File ..\win-change-background.ps1 -Color 000000 -Image "P:\Office\Eigene Bilder\wallpapers\The IT Crowds\The IT Crowd - Hello IT.jpg"
  return

+F8::
  run, powershell.exe -windowstyle hidden -ExecutionPolicy Bypass -File ..\win-change-background.ps1 -Color ffffff -Image "P:\Office\Eigene Bilder\wallpapers\The Hitchhicking Guide to the Galaxy\marvin-dont-panic.jpg"
  return
