
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
