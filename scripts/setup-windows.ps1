# ---------------------------
# Windows Setup Script
# ---------------------------

function Ask-Apply {
    param(
        [string]$Message,
        [scriptblock]$Action
    )

    $answer = Read-Host "$Message (Y/N)"
    if ($answer -eq 'Y' -or $answer -eq 'y') {
        & $Action
        Write-Host "✓ Applied: $Message" -ForegroundColor Green
    } else {
        Write-Host "✗ Skipped: $Message" -ForegroundColor Yellow
    }
}

$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Host "✖ This script requires administrator privileges. Please run as Administrator." -ForegroundColor Red
    Read-Host "Press ENTER to exit"
    exit
}

Write-Host "▶ Starting Windows setup..." -ForegroundColor Green

# ---------------------------
# 1. WINDOWS SYSTEM CONFIGURATION
# ---------------------------
Write-Host "▶ Configuring Windows system settings..." -ForegroundColor Green

# Dark Mode
Ask-Apply "Enable Dark Mode?" {
    Write-Host "→ Enabling dark mode..." -ForegroundColor Cyan
    Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" "AppsUseLightTheme" 0 -Type DWord -Force
    Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" "SystemUsesLightTheme" 0 -Type DWord -Force
}

# File Explorer Settings
Ask-Apply "Configure File Explorer settings?" {
    Write-Host "→ Configuring File Explorer..." -ForegroundColor Cyan
    Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "Hidden" 1 -Type DWord -Force
    Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "HideFileExt" 0 -Type DWord -Force
    Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CamelCase" "ShellState" 1 -Type DWord -Force -ErrorAction SilentlyContinue
    Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "LaunchTo" 1 -Type DWord -Force
}

# Taskbar Settings
Ask-Apply "Configure Taskbar settings?" {
    Write-Host "→ Configuring Taskbar..." -ForegroundColor Cyan
    Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" "EnableAutoTray" 0 -Type DWord -Force
    Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" "SearchboxTaskbarMode" 0 -Type DWord -Force
    Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "ShowTaskViewButton" 0 -Type DWord -Force
    Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Feeds" "ShellFeedsTaskbarViewMode" 2 -Type DWord -Force -ErrorAction SilentlyContinue
}

# Privacy Settings
Ask-Apply "Apply Privacy settings?" {
    Write-Host "→ Configuring Privacy settings..." -ForegroundColor Cyan
    Set-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" "EnableActivityFeed" 0 -Type DWord -Force
    Set-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" "PublishUserActivities" 0 -Type DWord -Force
    Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" "Value" "Deny" -Type String -Force
    Set-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" "AllowTelemetry" 0 -Type DWord -Force
}

# Performance Settings
Ask-Apply "Apply performance settings?" {
    Write-Host "→ Configuring Performance settings..." -ForegroundColor Cyan
    Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" "EnableTransparency" 0 -Type DWord -Force
}

# Developer Settings
Ask-Apply "Enable Developer settings?" {
    Write-Host "→ Configuring Developer settings..." -ForegroundColor Cyan
    Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" "AllowDevelopmentWithoutDevLicense" 1 -Type DWord -Force
    Set-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" "LongPathsEnabled" 1 -Type DWord -Force
}

# Power Settings
Ask-Apply "Apply power settings?" {
    Write-Host "→ Configuring Power settings..." -ForegroundColor Cyan

    powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c

    powercfg /change monitor-timeout-dc 10
    powercfg /change monitor-timeout-ac 15
    powercfg /change standby-timeout-dc 15
    powercfg /change standby-timeout-ac 30

    powercfg /setacvalueindex SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 7648efa3-dd9c-4e3e-b566-50f929386280 0
    powercfg /setdcvalueindex SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 7648efa3-dd9c-4e3e-b566-50f929386280 0

    powercfg /setacvalueindex SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 96996bc0-ad50-47ec-923b-6f41874dd9eb 0
    powercfg /setdcvalueindex SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 96996bc0-ad50-47ec-923b-6f41874dd9eb 0

    powercfg /setacvalueindex SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 5ca83367-6e45-459f-a27b-476b1d01c936 0
    powercfg /setdcvalueindex SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 5ca83367-6e45-459f-a27b-476b1d01c936 0

    powercfg /setactive SCHEME_CURRENT
    powercfg /hibernate off
}

# Windows Update
Ask-Apply "Apply Windows Update settings?" {
    Write-Host "→ Configuring Windows Update..." -ForegroundColor Cyan
    Set-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" "NoAutoRebootWithLoggedOnUsers" 1 -Type DWord -Force
    Set-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" "AUOptions" 3 -Type DWord -Force
}

# Keyboard
Ask-Apply "Apply Keyboard settings?" {
    Write-Host "→ Configuring Keyboard..." -ForegroundColor Cyan
    Set-ItemProperty "HKCU:\Control Panel\Keyboard" "KeyboardDelay" 0 -Type String -Force
    Set-ItemProperty "HKCU:\Control Panel\Keyboard" "KeyboardSpeed" 31 -Type String -Force
}

# Startup Settings
Ask-Apply "Apply Startup settings?" {
    Write-Host "→ Configuring Startup..." -ForegroundColor Cyan
    Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" "StartupDelayInMSec" 0 -Type DWord -Force
}

# Bloatware & Suggestions
Ask-Apply "Disable bloatware & suggestions?" {
    Write-Host "→ Disabling Windows bloatware..." -ForegroundColor Cyan
    Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SystemPaneSuggestionsEnabled" 0 -Type DWord -Force
    Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-338393Enabled" 0 -Type DWord -Force
    Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-353694Enabled" 0 -Type DWord -Force
    Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-353696Enabled" 0 -Type DWord -Force
    Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SoftLandingEnabled" 0 -Type DWord -Force
}

# Cortana
Ask-Apply "Disable Cortana?" {
    Write-Host "→ Disabling Cortana..." -ForegroundColor Cyan
    Set-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" "AllowCortana" 0 -Type DWord -Force
}

# Windows Error Reporting
Ask-Apply "Disable Windows Error Reporting?" {
    Write-Host "→ Disabling Windows Error Reporting..." -ForegroundColor Cyan
    Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" "Disabled" 1 -Type DWord -Force
}

# Windows Defender Settings (Optional - only if you use third-party antivirus)
# Ask-Apply "Disable Windows Error Reporting?" {
#     Write-Host "→ Configuring Windows Defender..." -ForegroundColor Cyan
#     Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisableAntiSpyware" -Value 1 -Type DWord -Force -ErrorAction SilentlyContinue
# }

# Hack Nerd Font
$fontsFolder = "$env:WINDIR\Fonts"
$hackFontInstalled = Get-ChildItem -Path $fontsFolder -Filter "*Hack*Nerd*Font*.ttf" -ErrorAction SilentlyContinue

if ($hackFontInstalled) {
    Write-Host "✓ Hack Nerd Font is already installed. Skipping installation." -ForegroundColor Green
} else {
    Write-Host "→ Installing Hack Nerd Font..." -ForegroundColor Cyan
    
    $fontUrl = "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip"
    $zipPath = "$env:TEMP\HackNerdFont.zip"
    $extractPath = "$env:TEMP\HackNerdFont"
    
    try {
        Invoke-WebRequest -Uri $fontUrl -OutFile $zipPath -UseBasicParsing
        Expand-Archive -Path $zipPath -DestinationPath $extractPath -Force
    
        # Install all TTF font files inside the zip
        $shellApp = New-Object -ComObject Shell.Application
        $fontsFolder = $shellApp.Namespace("$env:WINDIR\Fonts")
    
        Get-ChildItem -Path $extractPath -Filter *.ttf | ForEach-Object {
            $fontsFolder.CopyHere($_.FullName, 16)
        }
    
        Write-Host "✓ Hack Nerd Font installed successfully." -ForegroundColor Green
    }
    catch {
        Write-Host "✗ Failed to install Hack Nerd Font: $_" -ForegroundColor Red
    }
    
    # Cleanup
    Remove-Item $zipPath -Force -ErrorAction SilentlyContinue
    Remove-Item $extractPath -Recurse -Force -ErrorAction SilentlyContinue
}

Write-Host "✓ System configuration complete!" -ForegroundColor Green

# ---------------------------
# 2. WSL SETUP
# ---------------------------
Write-Host "▶ Checking WSL installation..." -ForegroundColor Green
$wslInstalled = Get-Command wsl -ErrorAction SilentlyContinue

if (-not $wslInstalled) {
    $shouldInstallWSL = Read-Host "WSL is not installed. Do you want to install it? (Y/N)"
    if ($shouldInstallWSL -eq 'Y' -or $shouldInstallWSL -eq 'y') {
        Write-Host "→ Enabling WSL and Virtual Machine Platform features..." -ForegroundColor Cyan

        dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
        dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

        Write-Host "→ Installing WSL..." -ForegroundColor Cyan
        wsl --install -d Ubuntu

        Write-Host "✓ WSL has been installed." -ForegroundColor Green
    }
} else {
    Write-Host "✓ WSL is already installed." -ForegroundColor Green

    $installUbuntu = Read-Host "Do you want to install/update the latest Ubuntu distribution? (Y/N)"
    if ($installUbuntu -eq 'Y' -or $installUbuntu -eq 'y') {
        Write-Host "→ Installing latest Ubuntu..." -ForegroundColor Cyan
        wsl --install -d Ubuntu
        Write-Host "✓ Latest Ubuntu has been installed." -ForegroundColor Green
    }
}


# ---------------------------
# 3. INSTALL APPS
# ---------------------------
$apps = @(
    "7zip.7zip",
    "Discord.Discord",
    "Google.Antigravity",
    "Google.Chrome",
    "Mozilla.Firefox",
    "Microsoft.Teams",
    "Microsoft.VisualStudioCode",
    "Mirantis.Lens",
    "MuhammedKalkan.OpenLens",
    "SlackTechnologies.Slack",
    "TablePlus.TablePlus",
    "VideoLAN.VLC",
    "Warp.Warp"
)

Write-Host "Select apps to install:" -ForegroundColor Yellow
for ($i = 0; $i -lt $apps.Count; $i++) {
    Write-Host " [$($i+1)] $($apps[$i])" -ForegroundColor Gray
}

$selection = Read-Host "Enter numbers separated by commas (e.g., 1,3,5) or 'A' for all, leave empty to skip"
Write-Host ""

$selectedApps = @()

if ($selection -match "^[Aa]") {
    $selectedApps = $apps
} else {
    $selectedNumbers = $selection -split "," | ForEach-Object { $_.Trim() } | Where-Object { $_ -match '^\d+$' }
    foreach ($num in $selectedNumbers) {
        $index = [int]$num - 1
        if ($index -ge 0 -and $index -lt $apps.Count) {
            $selectedApps += $apps[$index]
        }
    }
}

if (-not $selectedApps) {
    Write-Host "… No apps selected. Skipping app installation." -ForegroundColor Yellow
} else {
    foreach ($app in $selectedApps) {
        Write-Host "⭳ Installing $app..." -ForegroundColor Cyan
        winget install --id $app -e --source winget --accept-package-agreements --accept-source-agreements
    }
}

# ---------------------------
# 4. RESTART
# ---------------------------
Write-Host "✔ Windows setup complete!" -ForegroundColor Green
Write-Host "Some changes may require a system restart to take full effect." -ForegroundColor Yellow

$restart = Read-Host "Do you want to restart now? (Y/N)"
if ($restart -eq 'Y' -or $restart -eq 'y') {
    Restart-Computer
}
