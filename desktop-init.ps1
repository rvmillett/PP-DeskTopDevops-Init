
Write-Output "Running ado-desktop-init.ps1"

function refresh-env-path {
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") +
                ";" +
                [System.Environment]::GetEnvironmentVariable("Path","User")
}

#  Install winget for Windows

$progressPreference = 'silentlyContinue'
Write-Information "Downloading WinGet and its dependencies..."
Invoke-WebRequest -Uri https://aka.ms/getwinget -OutFile Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle
Invoke-WebRequest -Uri https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx -OutFile Microsoft.VCLibs.x64.14.00.Desktop.appx
Invoke-WebRequest -Uri https://github.com/microsoft/microsoft-ui-xaml/releases/download/v2.8.6/Microsoft.UI.Xaml.2.8.x64.appx -OutFile Microsoft.UI.Xaml.2.8.x64.appx
Add-AppxPackage Microsoft.VCLibs.x64.14.00.Desktop.appx
Add-AppxPackage Microsoft.UI.Xaml.2.8.x64.appx
Add-AppxPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle
refresh-env-path

# Core Installs

#  Install Git for Windows


Write-Output "Running git-install.ps1"

winget install --id Git.Git -e  --accept-package-agreements --accept-source-agreements
refresh-env-path

# Install Dotnet
Write-Output "Running dotnet-install.ps1"

if ($useWinget -eq $null -or $useWinget)
{
      Write-Output "Installing dotnet using Winget"

       winget install Microsoft.DotNet.SDK.8

}
else
{
Write-Output "Installing dotnet using Powershell Script"

    #using Powershell Script

    iex "& { $(irm  https://dot.net/v1/dotnet-install.ps1) } -Version 8.0.403  "

}



refresh-env-path

# Install .Net Framework

Write-Output "Running dotnet-framework-install.ps1"

$fwDownloadDir = "$ENV:TEMP\desktopDevopsInstallers\"

$dnfw481DownloadUrl = "https://download.microsoft.com/download/8/1/8/81877d8b-a9b2-4153-9ad2-63a6441d11dd/NDP481-DevPack-ENU.exe"
$dnfw481DownloadPath =  "$fwDownloadDir\NDP481-DevPack-ENU.exe"

$dnfw472DownloadUrl = "https://download.microsoft.com/download/7/1/7/71795fde-1cca-41b0-b495-00b1ab656994/NDP472-DevPack-ENU.exe"
$dnfw472DownloadPath = "$fwDownloadDir\NDP472-DevPack-ENU.exe"

# Check if the FW download path does not exist, and create it if it doesn't
if (-not (Test-Path -Path $fwDownloadDir -PathType Container)) {
    New-Item -Path $fwDownloadDir -ItemType Directory
}

function DownloadAndInstallFW ([string] $downloadUrl, [string] $downloadPath, [string] $fwVersion)
{

    Write-Output "Downloading $fwVersion"
    Invoke-WebRequest -Uri $downloadUrl -OutFile $downloadPath


    Write-Output "Installing $fwVersion"

    $args = @("/install","/quiet","/norestart")
    Start-Process -Filepath "$downloadPath" -ArgumentList $args -Wait
    #Start-Process -Filepath "$downloadPath" -Wait

    Write-Output "Finished Installing $fwVersion"

}


DownloadAndInstallFW -downloadUrl $dnfw472DownloadUrl -downloadPath $dnfw472DownloadPath -fwVersion ".Net Framework 4.7.2"
DownloadAndInstallFW -downloadUrl $dnfw481DownloadUrl -downloadPath $dnfw481DownloadPath -fwVersion ".Net Framework 4.8.1"

refresh-env-path

# Install AZDevops Nuget Credential Provider

Write-Output "Running nuget-azdevops-credprovider-install.ps1"

#  Install Azure Devops Credential Provider

Write-Output "Installing Net6 Credential Provider"

iex "& { $(irm https://aka.ms/install-artifacts-credprovider.ps1) } -InstallNet6 "

Write-Output "Installing Net8 Credential Provider"
iex "& { $(irm https://aka.ms/install-artifacts-credprovider.ps1) } -InstallNet8 "

Write-Output "Installing NetFX Credential Provider"
iex "& { $(irm https://aka.ms/install-artifacts-credprovider.ps1) } -AddNetfx "

Write-Output "Installing NetFX48 Credential Provider"
iex "& { $(irm https://aka.ms/install-artifacts-credprovider.ps1) } -AddNetFx48 "


refresh-env-path

# Install VSCode

Write-Output "Running vscode-install.ps1"

winget install -e --id Microsoft.VisualStudioCode  --accept-package-agreements --accept-source-agreements
refresh-env-path

# Install Power Platform Command Line
Write-Output "powerplatfrom-cli-install.ps1"

$ppcliDownloadDir = "$ENV:TEMP\desktopDevopsInstallers\"

$ppcliDownloadUrl = "https://download.microsoft.com/download/D/B/E/DBE69906-B4DA-471C-8960-092AB955C681/powerapps-cli-1.0.msi"
$ppcliDownloadPath = "$ppcliDownloadDir\powerapps-cli-1.0.msi"

# Check if the desktop devops download path does not exist, and create it if it doesn't
if (-not (Test-Path -Path $ppcliDownloadDir -PathType Container)) {
    New-Item -Path $ppcliDownloadDir -ItemType Directory
}

function DownloadAndInstallPPCLI ([string] $downloadUrl, [string] $downloadPath, [string] $swVersion, [string[]] $arguments)
{

    Write-Output "Downloading $swVersion"
    Invoke-WebRequest -Uri $downloadUrl -OutFile $downloadPath

    Write-Output "Installing $swVersion"
    Start-Process -Filepath "$downloadPath" -ArgumentList $arguments -Wait
    #Start-Process -Filepath "$downloadPath" -Wait

    Write-Output "Finished Installing $swVersion"

}

$args =  @("/quiet","/norestart")

DownloadAndInstallPPCLI -downloadUrl $ppcliDownloadUrl -downloadPath $ppcliDownloadPath -swVersion "Power Platform CLI" -arguments $args

# Installing multiple options to ensure all features are available.


Write-Output "dotnet tool install --global Microsoft.PowerApps.CLI.Tool"
dotnet tool install --global Microsoft.PowerApps.CLI.Tool

refresh-env-path

# Install Openstrata

Write-Output "Running openstrata-install.ps1"


Write-Output "dotnet new install OpenStrata.NET.Templates"
dotnet new install OpenStrata.NET.Templates

dotnet new install OpenStrata.Devops.VSCode.New


refresh-env-path

# Install NPM
Write-Output "Running npm-install.ps1"


#winget install -e --id OpenJS.NodeJS  --accept-package-agreements --accept-source-agreements
winget install -e --id OpenJS.NodeJS.LTS  --accept-package-agreements --accept-source-agreements
refresh-env-path

# Recommend a short file path for storing repos.

$reposRoot = "c:\repos"

# Check if the Repos Root folder does not exist, and create it if it doesn't
if (-not (Test-Path -Path $reposRoot -PathType Container)) {
    New-Item -Path $reposRoot -ItemType Directory
}










