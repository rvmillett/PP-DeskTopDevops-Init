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
