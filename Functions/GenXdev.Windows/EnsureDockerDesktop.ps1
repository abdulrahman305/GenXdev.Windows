<##############################################################################
Part of PowerShell module : GenXdev.Windows
Original cmdlet filename  : EnsureDockerDesktop.ps1
Original author           : René Vaessen / GenXdev
Version                   : 1.268.2025
################################################################################
MIT License

Copyright 2021-2025 GenXdev

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
################################################################################>
###############################################################################
<#
.SYNOPSIS
Ensures Docker Desktop is installed and available for containerization
operations.

.DESCRIPTION
Verifies if Docker Desktop is installed and properly configured on the system.
If not found, installs Docker Desktop using WinGet and handles the complete
installation process automatically. This function also manages Docker Desktop
service startup, daemon readiness verification, and handles authentication
requirements when necessary. The function includes comprehensive path
management for both system and user-level Docker installations.

.PARAMETER ShowWindow
Shows the Docker Desktop window during initialization when specified. When
this switch is enabled, Docker Desktop will start with its window visible
instead of minimized to the system tray.

.PARAMETER Monitor
Specifies the monitor to move the Docker Desktop window to:
  0 = Primary monitor (default)
  1..n = Specific monitor (1-based index)
  -1 = Discard monitor positioning
  -2 = Secondary monitor (uses $Global:DefaultSecondaryMonitor if defined)

.PARAMETER NoBorders
Removes the window borders and title bar from the Docker Desktop window for
a cleaner appearance.

.PARAMETER Width
Sets the width of the Docker Desktop window in pixels. Use -1 for automatic
sizing based on window content.

.PARAMETER Height
Sets the height of the Docker Desktop window in pixels. Use -1 for automatic
sizing based on window content.

.PARAMETER X
Sets the horizontal position of the Docker Desktop window in pixels. Use -1
for automatic positioning by the system.

.PARAMETER Y
Sets the vertical position of the Docker Desktop window in pixels. Use -1
for automatic positioning by the system.

.PARAMETER Left
Places the Docker Desktop window on the left half of the screen.

.PARAMETER Right
Places the Docker Desktop window on the right half of the screen.

.PARAMETER Top
Places the Docker Desktop window on the top half of the screen.

.PARAMETER Bottom
Places the Docker Desktop window on the bottom half of the screen.

.PARAMETER Centered
Centers the Docker Desktop window on the screen.

.PARAMETER Fullscreen
Maximizes the Docker Desktop window to fill the entire screen.

.PARAMETER RestoreFocus
Returns focus to the PowerShell window after positioning Docker Desktop.

.PARAMETER SideBySide
Positions Docker Desktop side by side with PowerShell on the same monitor
or fullscreen on a different monitor.

.PARAMETER FocusWindow
Focuses the Docker Desktop window after positioning and initialization.

.PARAMETER SetForeground
Sets the Docker Desktop window to foreground after positioning and
initialization.

.PARAMETER Maximize
Maximizes the Docker Desktop window after positioning.

.PARAMETER KeysToSend
Keystrokes to send to the Docker Desktop window after positioning and
initialization. See documentation for cmdlet GenXdev.Windows\Send-Key.

.PARAMETER SendKeyEscape
Escape control characters and modifiers when sending keys

.PARAMETER SendKeyHoldKeyboardFocus
Hold keyboard focus on target window when sending keys

.PARAMETER SendKeyUseShiftEnter
Use Shift+Enter instead of Enter when sending keys

.PARAMETER SendKeyDelayMilliSeconds
Delay between different input strings in milliseconds when sending keys

.PARAMETER SessionOnly
Uses alternative settings stored in session for AI preferences instead of
persistent preferences.

.PARAMETER ClearSession
Clears alternative settings stored in session for AI preferences.

.PARAMETER SkipSession
Stores settings only in persistent preferences without affecting session
variables.

.EXAMPLE
EnsureDockerDesktop

.EXAMPLE
EnsureDockerDesktop -ShowWindow -Centered -NoBorders

.EXAMPLE
EnsureDockerDesktop -ShowWindow -Monitor 1 -Left -Width 800 -Height 600
#>
#>
function EnsureDockerDesktop {

    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]

    param(
        #######################################################################
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Show Docker Desktop window during initialization'
        )]
        [switch]$ShowWindow,
        #######################################################################
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'The monitor to use, 0 = default, -1 is discard'
        )]
        [Alias('m', 'mon')]
        [int] $Monitor,
        #######################################################################
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Removes the borders of the window'
        )]
        [Alias('nb')]
        [switch] $NoBorders,
        #######################################################################
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Forces a docker desktop restart'
        )]
        [switch] $Force,
        #######################################################################
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'The initial width of the window'
        )]
        [int]$Width,
        #######################################################################
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'The initial height of the window'
        )]
        [int]$Height,
        #######################################################################
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'The initial X position of the window'
        )]
        [int]$X,
        #######################################################################
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'The initial Y position of the window'
        )]
        [int]$Y,
        #######################################################################
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Place window on the left side of the screen'
        )]
        [switch]$Left,
        #######################################################################
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Place window on the right side of the screen'
        )]
        [switch]$Right,
        #######################################################################
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Place window on the top side of the screen'
        )]
        [switch]$Top,
        #######################################################################
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Place window on the bottom side of the screen'
        )]
        [switch]$Bottom,
        #######################################################################
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Place window in the center of the screen'
        )]
        [switch]$Centered,
        #######################################################################
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Maximize the window'
        )]
        [Alias('fs')]
        [switch]$Fullscreen,
        #######################################################################
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Restore PowerShell window focus'
        )]
        [Alias('rf', 'bg')]
        [switch]$RestoreFocus,
        #######################################################################
        [Parameter(
            Mandatory = $false,
            HelpMessage = ('Will either set the window fullscreen on a ' +
                'different monitor than Powershell, or side by side with ' +
                'Powershell on the same monitor')
        )]
        [Alias('sbs')]
        [switch]$SideBySide,
        #######################################################################
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Focus the window after opening'
        )]
        [Alias('fw','focus')]
        [switch]$FocusWindow,
        #######################################################################
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Set the window to foreground after opening'
        )]
        [Alias('fg')]
        [switch]$SetForeground,
        #######################################################################
        [Parameter(
            Mandatory = $false,
            HelpMessage = ('Keystrokes to send to the Window, ' +
                'see documentation for cmdlet GenXdev.Windows\Send-Key')
        )]
        [ValidateNotNullOrEmpty()]
        [string[]]$KeysToSend,
        ########################################################################
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Escape control characters and modifiers when sending keys'
        )]
        [Alias('Escape')]
        [switch] $SendKeyEscape,
        ########################################################################
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Hold keyboard focus on target window when sending keys'
        )]
        [Alias('HoldKeyboardFocus')]
        [switch] $SendKeyHoldKeyboardFocus,
        ########################################################################
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Use Shift+Enter instead of Enter when sending keys'
        )]
        [Alias('UseShiftEnter')]
        [switch] $SendKeyUseShiftEnter,
        ########################################################################
        [Parameter(
            Mandatory = $false,
            HelpMessage = ('Delay between different input strings in ' +
                'milliseconds when sending keys')
        )]
        [Alias('DelayMilliSeconds')]
        [int] $SendKeyDelayMilliSeconds,
        #######################################################################
        [Parameter(
            Mandatory = $false,
            HelpMessage = ('Use alternative settings stored in session for AI ' +
                'preferences')
        )]
        [switch]$SessionOnly,
        #######################################################################
        [Parameter(
            Mandatory = $false,
            HelpMessage = ('Clear alternative settings stored in session for ' +
                'AI preferences')
        )]
        [switch]$ClearSession,
        ###################################################################
        [Parameter(
            Mandatory = $false,
            HelpMessage = ('Store settings only in persistent preferences ' +
                          'without affecting session')
        )]
        [Alias('FromPreferences')]
        [switch]$SkipSession,
        ###################################################################
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Skip Docker initialization and return immediately'
        )]
        [switch]$NoDockerInitialization
        ###################################################################
    )


    begin {

        # skip docker initialization if requested by user
        if ($NoDockerInitialization) {

            Microsoft.PowerShell.Utility\Write-Verbose ('Skipping Docker ' +
                'initialization...')

            return
        }

        # force stop docker processes if requested and confirmed
        if ($Force -and $PSCmdlet.ShouldProcess('Docker processes',
                'Force stop Docker processes')) {

            # stop all docker-related processes forcefully
            $null = Microsoft.PowerShell.Management\Get-Process *docker* `
                -ErrorAction SilentlyContinue |
                Microsoft.PowerShell.Management\Stop-Process -Force
        }

        ###################################################################
        <#
        .SYNOPSIS
        Checks if the WinGet PowerShell module is installed.

        .DESCRIPTION
        Attempts to import the Microsoft.WinGet.Client module and verifies its
        presence by checking if the module is available after import attempt.
        This function is used to determine if WinGet capabilities are
        available before attempting package installations.

        .EXAMPLE
        IsWinGetInstalled
        #>
        ###################################################################
        function IsWinGetInstalled {

            # attempt to load the winget module silently without error output
            Microsoft.PowerShell.Core\Import-Module 'Microsoft.WinGet.Client' `
                -ErrorAction SilentlyContinue

            # verify if module was loaded successfully by checking module list
            $moduleObj = Microsoft.PowerShell.Core\Get-Module `
                'Microsoft.WinGet.Client' `
                -ErrorAction SilentlyContinue

            # return true if module object exists, false otherwise
            return $null -ne $moduleObj
        }

        ###################################################################
        <#
        .SYNOPSIS
        Installs the WinGet PowerShell module.

        .DESCRIPTION
        Installs and imports the Microsoft.WinGet.Client module for package
        management operations. Forces installation to override any conflicts
        and ensures the module is available for Docker Desktop installation.

        .EXAMPLE
        InstallWinGet
        #>
        ###################################################################
        function InstallWinGet {

            # output status message about winget installation
            Microsoft.PowerShell.Utility\Write-Verbose ('Installing WinGet ' +
                'PowerShell client...')

            # install winget module with force to ensure success and allow
            # clobber
            $null = PowerShellGet\Install-Module 'Microsoft.WinGet.Client' `
                -Force `
                -AllowClobber

            # load the newly installed module into current session
            Microsoft.PowerShell.Core\Import-Module 'Microsoft.WinGet.Client'
        }
    }

    process {

        $positioningDone = $false

        # skip docker initialization if requested by user
        if ($NoDockerInitialization) {
            return
        }

        # verify if docker desktop executable is available in current session
        if (@(Microsoft.PowerShell.Core\Get-Command 'docker.exe' `
                    -ErrorAction SilentlyContinue).Length -eq 0) {


            # define common docker installation paths for system and user
            # installs
            $dockerPaths = @(
                "${env:ProgramFiles}\Docker\Docker\resources\bin",
                "${env:LOCALAPPDATA}\Programs\Docker\Docker\resources\bin"
            )

            # initialize flag to track if docker was found in known paths
            $dockerFound = $false

            # iterate through each potential docker installation path
            foreach ($path in $dockerPaths) {

                # check if docker executable exists in current path
                if (Microsoft.PowerShell.Management\Test-Path `
                    -LiteralPath (Microsoft.PowerShell.Management\Join-Path $path `
                            'docker.exe')) {

                    # get current user PATH environment variable
                    $currentPath = [Environment]::GetEnvironmentVariable('PATH',
                        'User')

                    # add docker path to user PATH if not already present
                    if ($currentPath -notlike "*$path*") {

                        # inform user about path modification
                        Microsoft.PowerShell.Utility\Write-Verbose ('Adding ' +
                            'Docker to system PATH...')

                        # update user PATH environment variable permanently
                        [Environment]::SetEnvironmentVariable(
                            'PATH',
                            "$currentPath;$path",
                            'User')
                    }

                    # update current session's path for immediate
                    # availability only if not already present
                    if ($env:PATH -notlike "*$path*") {
                        $env:PATH = "$env:PATH;$path"
                    }

                    # mark docker as found and exit loop
                    $dockerFound = $true
                    break
                }
            }

            # install docker if not found in known installation paths
            if (-not $dockerFound) {
                if ($PSCmdlet.ShouldProcess('Docker Desktop',
                        ('Install Docker Desktop and required features, ' +
                         'might need multiple reboots, just repeat your ' +
                         'last command until fully installed.'))) {

                    # install windows updates and handle auto-reboot
                    GenXdev.Windows\Invoke-WindowsUpdate -Install -AutoReboot `
                        -Verbose

                    # inform user about docker installation process
                    Microsoft.PowerShell.Utility\Write-Host ('Docker Desktop not ' +
                        'found. Installing Docker Desktop...')

                    # ensure winget is available before attempting docker
                    # installation
                    if (-not (IsWinGetInstalled)) {
                        InstallWinGet
                    }

                    try {
                        # set execution policy to bypass for process scope
                        Microsoft.PowerShell.Security\Set-ExecutionPolicy Bypass `
                            -Scope Process -Force

                        # enable hyper-v and containers windows features
                        Microsoft.PowerShell.Utility\Write-Host ('Enabling ' +
                            'Hyper-V and Containers features…') `
                            -ForegroundColor Cyan

                        # enable hyper-v feature for virtualization support
                        Dism\Enable-WindowsOptionalFeature -Online `
                            -FeatureName Microsoft-Hyper-V -All

                        # enable containers feature for docker support
                        Dism\Enable-WindowsOptionalFeature -Online `
                            -FeatureName Containers -All

                        # update windows subsystem for linux to latest version
                        Microsoft.PowerShell.Utility\Write-Host ('Updating ' +
                            'Windows Subsystem for Linux (WSL)…') `
                            -ForegroundColor Cyan

                        wsl --update
                    }
                    catch {
                        Microsoft.PowerShell.Utility\Write-Host ('Failed to ' +
                            'enable Windows features or update WSL.') `
                            -ForegroundColor Red
                    }

                    # install docker desktop using winget package manager
                    $null = Microsoft.WinGet.Client\Install-WinGetPackage `
                        -Id 'Docker.DockerDesktop' `
                        -Force

                    # re-check docker paths after installation to update PATH
                    foreach ($path in $dockerPaths) {
                        # verify docker executable exists in path after installation
                        if (Microsoft.PowerShell.Management\Test-Path `
                            -LiteralPath (Microsoft.PowerShell.Management\Join-Path $path `
                                    'docker.exe')) {

                            # get current user PATH environment variable
                            $currentPath = [Environment]::GetEnvironmentVariable(
                                'PATH', 'User')

                            # add docker path to PATH if not already present
                            if ($currentPath -notlike "*$path*") {

                                # inform user about path update after installation
                                Microsoft.PowerShell.Utility\Write-Verbose (
                                    'Adding Docker to system PATH...')

                                # update user PATH environment variable
                                [Environment]::SetEnvironmentVariable(
                                    'PATH',
                                    "$currentPath;$path",
                                    'User')

                                # update current session's path immediately only if
                                # not already present
                                if ($env:PATH -notlike "*$path*") {
                                    $env:PATH = "$env:PATH;$path"
                                }
                            }
                            break
                        }
                    }

                    # verify docker installation was successful by checking command
                    if (-not (Microsoft.PowerShell.Core\Get-Command 'docker.exe' `
                                -ErrorAction SilentlyContinue)) {
                        throw 'Docker Desktop installation failed.'
                    }
                } # ShouldProcess
            }
        }

        # check if docker desktop process is currently running
        $dockerDesktopProcess = Microsoft.PowerShell.Management\Get-Process `
            'Docker Desktop' `
            -ErrorAction SilentlyContinue

        # start docker desktop if process is not running
        if (-not $dockerDesktopProcess) {

            # inform user about docker desktop startup
            Microsoft.PowerShell.Utility\Write-Host 'Starting Docker Desktop...'

            # try to find docker desktop executable via get-command
            $dockerExePath = Microsoft.PowerShell.Core\Get-Command `
                'Docker Desktop.exe' `
                -ErrorAction SilentlyContinue

            # start docker desktop if found via get-command
            if ($dockerExePath) {

                # initialize process variable
                $p = $null

                # start docker desktop process using found executable path
                if ($ShowWindow) {

                    # start with window visible if ShowWindow is specified
                    $p = Microsoft.PowerShell.Management\Start-Process `
                        $dockerExePath.Source `
                        -WindowStyle Normal `
                        -PassThru

                    # copy identical parameters for window positioning
                    $wpParams = GenXdev.Helpers\Copy-IdenticalParamValues `
                                    -BoundParameters $PSBoundParameters `
                                    -FunctionName 'GenXdev.Windows\Set-WindowPosition'

                    # set default monitor if not specified
                    if (-not $PSBoundParameters.ContainsKey('Monitor')) {
                        $wpParams['Monitor'] = -2
                    }

                    # position window with specified parameters
                    $null = GenXdev.Windows\Set-WindowPosition @wpParams `
                        -ProcessId $p.Id -ErrorAction SilentlyContinue

                    $positioningDone = $true
                } else {
                    # start minimized by default (hidden in tray)
                    $p = Microsoft.PowerShell.Management\Start-Process `
                        $dockerExePath.Source `
                        -WindowStyle Minimized `
                        -PassThru

                    # minimize window to tray
                    $null = GenXdev.Windows\Set-WindowPosition -ProcessId $p.Id `
                        -Minimize `
                        -ErrorAction SilentlyContinue

                    $positioningDone = $true
                }

                # wait for docker desktop to initialize (30 seconds)
                Microsoft.PowerShell.Utility\Start-Sleep 30
            }
            else {
                # define common docker desktop executable paths
                $dockerDesktopPaths = @(
                    "${env:ProgramFiles}\Docker\Docker\Docker Desktop.exe",
                    ("${env:LOCALAPPDATA}\Programs\Docker\Docker\" +
                    'Docker Desktop.exe')
                )
                # try each known docker desktop installation path
                foreach ($path in $dockerDesktopPaths) {
                    # check if docker desktop executable exists at current path
                    if (Microsoft.PowerShell.Management\Test-Path -LiteralPath $path) {
                        # start docker desktop from found path with appropriate
                        # window style
                        $p = $null
                        if ($ShowWindow) {
                            # start with window visible if ShowWindow is specified
                            $p = Microsoft.PowerShell.Management\Start-Process $path `
                                -WindowStyle Normal `
                                -PassThru

                            # copy identical parameters for window positioning
                            $params = GenXdev.Helpers\Copy-IdenticalParamValues `
                                            -BoundParameters $PSBoundParameters `
                                            -FunctionName 'GenXdev.Windows\Set-WindowPosition'

                            if (-not $PSBoundParameters.ContainsKey('Monitor')) {
                                $params['Monitor'] = -2
                            }

                            # set window positions and focus using the window helper
                            $null = GenXdev.Windows\Set-WindowPosition @params `
                                -ProcessId $p.Id -ErrorAction SilentlyContinue

                            $positioningDone = $true
                        } else {
                            # start minimized by default (hidden in tray)
                            $p = Microsoft.PowerShell.Management\Start-Process $path `
                                -WindowStyle Minimized `
                                -PassThru

                            # minimize window to tray
                            $null = GenXdev.Windows\Set-WindowPosition -ProcessId $p.Id `
                                -Minimize `
                                -ErrorAction SilentlyContinue

                            $positioningDone = $true
                        }
                        # wait for docker desktop to initialize
                        Microsoft.PowerShell.Utility\Start-Sleep 30
                        break
                    }
                }
            }
        }

        # handle docker desktop window positioning if ShowWindow is specified
        if ($ShowWindow -and -not $positioningDone) {

            # inform user that we're bringing docker desktop window to
            # foreground
            Microsoft.PowerShell.Utility\Write-Verbose ('Bringing Docker ' +
                'Desktop window to the foreground...')

            $params = GenXdev.Helpers\Copy-IdenticalParamValues `
                                -BoundParameters $PSBoundParameters `
                                -FunctionName 'GenXdev.Windows\Set-WindowPosition' `
                                -DefaultValues (Microsoft.PowerShell.Utility\Get-Variable `
                                    -Scope Local -ErrorAction SilentlyContinue)

            $null = GenXdev.Windows\Set-WindowPosition @params -ProcessName "Docker Desktop" -ErrorAction SilentlyContinue
            $positioningDone = $true
        }

        # wait for docker daemon to become ready for commands
        Microsoft.PowerShell.Utility\Write-Host ('Checking Docker Desktop ' +
            'status...') -ForegroundColor Cyan

        # set timeout for waiting for docker daemon (600 seconds)
        $timeout = 600
        $elapsed = 0
        $engineMessageShown = $false
        $loginMessageShown = $false

        # loop until docker daemon is ready or timeout is reached
        while ($elapsed -lt $timeout) {

            # check if docker engine is running by trying a simple docker
            # command
            try {

                # attempt to get docker server version to verify engine status
                $null = docker.exe version --format '{{.Server.Version}}' 2>$null

                # verify command executed successfully
                if ($LASTEXITCODE -eq 0) {

                    # engine is running, check if user needs to log in
                    $dockerInfo = docker.exe info 2>&1

                    # check if login is required based on docker info output
                    if ($dockerInfo -match 'not logged in' -or `
                            $dockerInfo -match 'Please log in') {

                        # show login message only once
                        if (-not $loginMessageShown) {
                            Microsoft.PowerShell.Utility\Write-Host ('Docker ' +
                                'engine is running, but user is not logged ' +
                                'in. Please log in via Docker Desktop.') `
                                -ForegroundColor Yellow
                            $loginMessageShown = $true
                        }

                        # continue waiting or break - for many operations,
                        # login isn't required
                        Microsoft.PowerShell.Utility\Write-Host ('Docker ' +
                            'engine is running and ready for basic ' +
                            'operations.') -ForegroundColor Green
                        break
                    } else {

                        # either logged in or login check failed, assume docker
                        # is ready
                        Microsoft.PowerShell.Utility\Write-Host ('Docker ' +
                            'engine is running and ready.') `
                            -ForegroundColor Green
                        break
                    }
                }
            }
            catch {

                # docker command failed, engine likely not ready
            }

            # show engine startup message only once
            if (-not $engineMessageShown) {
                Microsoft.PowerShell.Utility\Write-Host ('Waiting for ' +
                    'Docker engine to start...') -ForegroundColor Yellow
                $engineMessageShown = $true
            }

            # wait before next check and increment elapsed time
            Microsoft.PowerShell.Utility\Start-Sleep -Seconds 5
            $elapsed += 5
        }

        # throw error if docker daemon failed to start within timeout
        if ($elapsed -ge $timeout) {
            throw ("Docker daemon failed to start within $timeout seconds.")
        }

        # output final success message about docker desktop readiness
        Microsoft.PowerShell.Utility\Write-Verbose ('✅ Docker Desktop is ' +
            'ready.')
    }

    end {
    }
}
###############################################################################