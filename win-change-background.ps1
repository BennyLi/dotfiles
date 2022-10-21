
param (
    [parameter(Mandatory=$True)]
    [string]$Color,

    [parameter(Mandatory=$True)]
    # Provide path to image
    [string]$Image
)


Function Set-WallPaperBackgroundColor {
    
    <#
 
        .SYNOPSIS
        Applies a specified color to the current user's desktop.
 
        .PARAMETER Color
        Provide wallpaper color in HEX notation.
        You can use a tool like https://colorpicker.me/ to pick a color of your choice.
  
        .EXAMPLE
        Set-WallPaperBackgroundColor -Color 000000
    #>

    param (
        [parameter(Mandatory=$True)]
        [string]$Color
    )

    Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;
    
    public class PInvoke 
    {
        [DllImport(`"user32.dll`")]
        public static extern bool SetSysColors(int cElements,
                                               int[] lpaElements,
                                               int[] lpaRgbValues);
    }
"@

    $BackgroundColor = "0x$Color"

    [PInvoke]::SetSysColors(1, @(1), @($BackgroundColor))
}


Function Set-WallPaper {
 
    <#
 
        .SYNOPSIS
        Applies a specified wallpaper to the current user's desktop.
    
        .PARAMETER Image
        Provide the exact path to the image.
 
        .PARAMETER Style
        Provide wallpaper style (Example: Fill, Fit, Stretch, Tile, Center, or Span).
  
        .EXAMPLE
        Set-WallPaper -Image "C:\Wallpaper\Default.jpg"
        Set-WallPaper -Image "C:\Wallpaper\Background.jpg" -Style Fit

        .SOURCE
        https://www.joseespitia.com/2017/09/15/set-wallpaper-powershell-function/  
    #>
 
    param (
        [parameter(Mandatory=$True)]
        # Provide path to image
        [string]$Image,
        # Provide wallpaper style that you would like applied
        [parameter(Mandatory=$False)]
        [ValidateSet('Fill', 'Fit', 'Stretch', 'Tile', 'Center', 'Span')]
        [string]$Style
    )
 
    $WallpaperStyle = Switch ($Style) {
  
        "Fill" {"10"}
        "Fit" {"6"}
        "Stretch" {"2"}
        "Tile" {"0"}
        "Center" {"0"}
        "Span" {"22"}
  
    }
 
    If($Style -eq "Tile") {
 
        New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name WallpaperStyle -PropertyType String -Value $WallpaperStyle -Force
        New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name TileWallpaper -PropertyType String -Value 1 -Force
 
    }
    Else {
 
        New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name WallpaperStyle -PropertyType String -Value $WallpaperStyle -Force
        New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name TileWallpaper -PropertyType String -Value 0 -Force
 
    }
 
    Add-Type -TypeDefinition @" 
    using System; 
    using System.Runtime.InteropServices;
  
    public class Params
    { 
        [DllImport("User32.dll",CharSet=CharSet.Unicode)] 
        public static extern int SystemParametersInfo (Int32 uAction, 
                                                       Int32 uParam, 
                                                       String lpvParam, 
                                                       Int32 fuWinIni);
    }
"@
  
    $SPI_SETDESKWALLPAPER = 0x0014
    $UpdateIniFile = 0x01
    $SendChangeEvent = 0x02
  
    $fWinIni = $UpdateIniFile -bor $SendChangeEvent
  
    $ret = [Params]::SystemParametersInfo($SPI_SETDESKWALLPAPER, 0, $Image, $fWinIni)
}



Set-WallPaperBackgroundColor -Color $Color
Set-WallPaper -Image "$Image" -Style Fit