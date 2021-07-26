<hr/>

<img src="powershell.jpg" alt="GenXdev" width="50%"/>

<hr/>

### NAME
    GenXdev.Windows

### SYNOPSIS
    A Windows PowerShell module that provides ui Windows manipulation helpers

[![GenXdev.Windows](https://img.shields.io/powershellgallery/v/GenXdev.Windows.svg?style=flat-square&label=GenXdev.Windows)](https://www.powershellgallery.com/packages/GenXdev.Windows/) [![License](https://img.shields.io/github/license/renevaessen/GenXdev.Windows?style=flat-square)](./LICENSE)

### FEATURES

    * ✅ Allow resizing/repositioning/closing of Windows
    * ✅ Read/write access to Windows special folder locations

### DEPENDENCIES
[![WinOS - Windows-10](https://img.shields.io/badge/WinOS-Windows--10--10.0.19041--SP0-brightgreen)](https://www.microsoft.com/en-us/windows/get-windows-10) [![GenXdev.Helpers](https://img.shields.io/powershellgallery/v/GenXdev.Helpers.svg?style=flat-square&label=GenXdev.Helpers)](https://www.powershellgallery.com/packages/GenXdev.Helpers/)
### INSTALLATION
````PowerShell
Install-Module "GenXdev.Windows" -Force
Import-Module "GenXdev.Windows"
````
### UPDATE
````PowerShell
Update-Module
````

<br/><hr/><hr/><br/>

# Cmdlet Index
| Command&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | aliases&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | Description |
| --- | --- | --- |
| [Copy-SetWindowPositionParameters](#Copy-SetWindowPositionParameters) |  | The dynamic parameter block of a proxy function. This block can be used to copy a proxy function target's parameters . |
| [Get-DesktopScalingFactor](#Get-DesktopScalingFactor) |  | Returns the scaling factor that is configured for a monitor |
| [Get-KnownFolderPath](#Get-KnownFolderPath) |  | Gets a known folder's path using SHGetKnownFolderPath. |
| [Get-PowershellMainWindow](#Get-PowershellMainWindow) |  | Returns a window helper object for the mainwindow of the process responsible for hosting the Powershell terminal |
| [Get-PowershellMainWindowProcess](#Get-PowershellMainWindowProcess) |  | Returns the process of the window responsible for hosting the Powershell terminal |
| [Get-Window](#Get-Window) |  | Returns a window helper for the main window of the specified process |
| [Set-KnownFolderPath](#Set-KnownFolderPath) |  | Sets a known folder's path using SHSetKnownFolderPath. |
| [Set-TaskbarAlignment](#Set-TaskbarAlignment) |  | Sets the alignment for the Windows 11+ Taskbar |
| [Set-WindowPosition](#Set-WindowPosition) | wp | Positions a window in a configurable manner, using commandline switches |
| [Set-WindowPositionForSecondary](#Set-WindowPositionForSecondary) | wps | Positions a window like Set-WindowPosition -> wp but defaults to the configured secondairy monitor |

<br/><hr/><hr/><br/>


# Cmdlets

## Copy-SetWindowPositionParameters
````PowerShell
Copy-SetWindowPositionParameters
````

### SYNOPSIS
    Proxy function dynamic parameter block for the Set-WindowPosition cmdlet

### SYNTAX
````PowerShell
Copy-SetWindowPositionParameters [[-ParametersToSkip] <String[]>] 
[<CommonParameters>]
````

### DESCRIPTION
    The dynamic parameter block of a proxy function. This block can be used to 
    copy a proxy function target's parameters .

### PARAMETERS
    -ParametersToSkip <String[]>
        Required?                    false
        Position?                    1
        Default value                @()
        Accept pipeline input?       false
        Accept wildcard characters?  false
    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters 
        (https://go.microsoft.com/fwlink/?LinkID=113216). 

<br/><hr/><hr/><br/>

## Get-DesktopScalingFactor
````PowerShell
Get-DesktopScalingFactor
````

### SYNOPSIS
    Returns the scaling factor that is configured for a monitor

### SYNTAX
````PowerShell
Get-DesktopScalingFactor [[-monitor] <Int32>] [<CommonParameters>]
````

### DESCRIPTION
    Returns the scaling factor that is configured for a monitor

### PARAMETERS
    -monitor <Int32>
        The monitor to return the scaling factor for, or if not supplied the 
        primary monitor is used
        Required?                    false
        Position?                    1
        Default value                0
        Accept pipeline input?       false
        Accept wildcard characters?  false
    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters 
        (https://go.microsoft.com/fwlink/?LinkID=113216). 

<br/><hr/><hr/><br/>

## Get-KnownFolderPath
````PowerShell
Get-KnownFolderPath
````

### SYNOPSIS
    Gets a known folder's path using SHGetKnownFolderPath.

### SYNTAX
````PowerShell
Get-KnownFolderPath [-KnownFolder] <String> [<CommonParameters>]
````

### DESCRIPTION
    Gets a known folder's path using SHGetKnownFolderPath.

### PARAMETERS
    -KnownFolder <String>
        The known folder whose path to get.
        Required?                    true
        Position?                    1
        Default value                
        Accept pipeline input?       false
        Accept wildcard characters?  false
    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters 
        (https://go.microsoft.com/fwlink/?LinkID=113216). 

<br/><hr/><hr/><br/>

## Get-PowershellMainWindow
````PowerShell
Get-PowershellMainWindow
````

### SYNOPSIS
    Returns a window helper object for the mainwindow of the process 
    responsible for hosting the Powershell terminal

### SYNTAX
````PowerShell
Get-PowershellMainWindow [<CommonParameters>]
````

### DESCRIPTION
    Returns a window helper object for the mainwindow of the process 
    responsible for hosting the Powershell terminal

### PARAMETERS
    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters 
        (https://go.microsoft.com/fwlink/?LinkID=113216). 

<br/><hr/><hr/><br/>

## Get-PowershellMainWindowProcess
````PowerShell
Get-PowershellMainWindowProcess
````

### SYNOPSIS
    Returns the process of the window responsible for hosting the Powershell 
    terminal

### SYNTAX
````PowerShell
Get-PowershellMainWindowProcess [<CommonParameters>]
````

### DESCRIPTION
    Returns the process of the window responsible for hosting the Powershell 
    terminal

### PARAMETERS
    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters 
        (https://go.microsoft.com/fwlink/?LinkID=113216). 

<br/><hr/><hr/><br/>

## Get-Window
````PowerShell
Get-Window
````

### SYNOPSIS
    Returns a window helper for the main window of the specified process

### SYNTAX
````PowerShell
Get-Window [-ProcessName] <String> [<CommonParameters>]
````

### DESCRIPTION
    Returns a window helper for the main window of the specified process

### PARAMETERS
    -ProcessName <String>
        The process to get the window helper for
        Required?                    true
        Position?                    1
        Default value                
        Accept pipeline input?       false
        Accept wildcard characters?  false
    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters 
        (https://go.microsoft.com/fwlink/?LinkID=113216). 

<br/><hr/><hr/><br/>

## Set-KnownFolderPath
````PowerShell
Set-KnownFolderPath
````

### SYNOPSIS
    Sets a known folder's path using SHSetKnownFolderPath.

### SYNTAX
````PowerShell
Set-KnownFolderPath [-KnownFolder] <String> [-Path] <String> 
[<CommonParameters>]
````

### DESCRIPTION
    Sets a known folder's path using SHSetKnownFolderPath.

### PARAMETERS
    -KnownFolder <String>
        The known folder whose path to set.
        Required?                    true
        Position?                    1
        Default value                
        Accept pipeline input?       false
        Accept wildcard characters?  false
    -Path <String>
        The path.
        Required?                    true
        Position?                    2
        Default value                
        Accept pipeline input?       false
        Accept wildcard characters?  false
    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters 
        (https://go.microsoft.com/fwlink/?LinkID=113216). 

<br/><hr/><hr/><br/>

## Set-TaskbarAlignment
````PowerShell
Set-TaskbarAlignment
````

### SYNOPSIS
    Sets the alignment for the Windows 11+ Taskbar

### SYNTAX
````PowerShell
Set-TaskbarAlignment [-Justify] <Object> [<CommonParameters>]
````

### DESCRIPTION
    Sets the alignment for the Windows 11+ Taskbar

### PARAMETERS
    -Justify <Object>
        The new alignment
        Required?                    true
        Position?                    1
        Default value                
        Accept pipeline input?       false
        Accept wildcard characters?  false
    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters 
        (https://go.microsoft.com/fwlink/?LinkID=113216). 

<br/><hr/><hr/><br/>

## Set-WindowPosition
````PowerShell
Set-WindowPosition                   --> wp
````

### SYNOPSIS
    Positions a window

### SYNTAX
````PowerShell
Set-WindowPosition [[-Process] <Process[]>] [-Monitor <Int32>] 
[-NoBorders] [-Width <Int32>] [-Height <Int32>] [-X <Int32>] [-Y <Int32>] 
[-Left] [-Right] [-Top] [-Bottom] [-Centered] [-RestoreFocus] 
[-PassThrough] [<CommonParameters>]
````

### DESCRIPTION
    Positions a window in a configurable manner, using commandline switches

### PARAMETERS
    -Process <Process[]>
        The process of the window to position
        Required?                    false
        Position?                    1
        Default value                
        Accept pipeline input?       true (ByValue, ByPropertyName)
        Accept wildcard characters?  false
    -Monitor <Int32>
        The monitor to use, 0 = default, 1 = secondary, -1 is discard
        Required?                    false
        Position?                    named
        Default value                -1
        Accept pipeline input?       false
        Accept wildcard characters?  false
    -NoBorders [<SwitchParameter>]
        Open in NoBorders mode --> -nb
        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       false
        Accept wildcard characters?  false
    -Width <Int32>
        The initial width of the window
        Required?                    false
        Position?                    named
        Default value                -1
        Accept pipeline input?       false
        Accept wildcard characters?  false
    -Height <Int32>
        The initial height of the window
        Required?                    false
        Position?                    named
        Default value                -1
        Accept pipeline input?       false
        Accept wildcard characters?  false
    -X <Int32>
        The initial X position of the window
        Required?                    false
        Position?                    named
        Default value                -1
        Accept pipeline input?       false
        Accept wildcard characters?  false
    -Y <Int32>
        The initial Y position of the window
        Required?                    false
        Position?                    named
        Default value                -1
        Accept pipeline input?       false
        Accept wildcard characters?  false
    -Left [<SwitchParameter>]
        Place window on the left side of the screen
        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       false
        Accept wildcard characters?  false
    -Right [<SwitchParameter>]
        Place window on the right side of the screen
        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       false
        Accept wildcard characters?  false
    -Top [<SwitchParameter>]
        Place window on the top side of the screen
        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       false
        Accept wildcard characters?  false
    -Bottom [<SwitchParameter>]
        Place window on the bottom side of the screen
        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       false
        Accept wildcard characters?  false
    -Centered [<SwitchParameter>]
        Place window in the center of the screen
        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       false
        Accept wildcard characters?  false
    -RestoreFocus [<SwitchParameter>]
        Restore PowerShell window focus --> -bg
        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       false
        Accept wildcard characters?  false
    -PassThrough [<SwitchParameter>]
        Returns a [System.Diagnostics.Process] object of the browserprocess
        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       false
        Accept wildcard characters?  false
    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters 
        (https://go.microsoft.com/fwlink/?LinkID=113216). 

<br/><hr/><hr/><br/>

## Set-WindowPositionForSecondary
````PowerShell
Set-WindowPositionForSecondary       --> wps
````

### SYNOPSIS
    Positions a window and positions it by default on the secondairy monitor

### SYNTAX
````PowerShell
Set-WindowPositionForSecondary [[-Monitor] <Int32>] [<CommonParameters>]
````

### DESCRIPTION
    Positions a window like Set-WindowPosition -> wp but defaults to the 
    configured secondairy monitor

### PARAMETERS
    -Monitor <Int32>
        The monitor to use, 0 = default, 1 = secondary, -1 is discard
        Required?                    false
        Position?                    1
        Default value                -2
        Accept pipeline input?       false
        Accept wildcard characters?  false
    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters 
        (https://go.microsoft.com/fwlink/?LinkID=113216). 

<br/><hr/><hr/><br/>
