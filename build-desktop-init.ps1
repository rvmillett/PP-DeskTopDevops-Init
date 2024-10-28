
Write-Output "Running ado-desktop-init.ps1"

function refresh-env-path {
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") +
                ";" +
                [System.Environment]::GetEnvironmentVariable("Path","User")
}

#  Install winget for Windows

. $PSScriptRoot\winget-install.ps1
refresh-env-path

# Core Installs

#  Install Git for Windows

. $PSScriptRoot\git-install.ps1
refresh-env-path

# Install Dotnet
. $PSScriptRoot\dotnet-install.ps1
refresh-env-path

# Install .Net Framework
. $PSScriptRoot\dotnet-framework-install.ps1
refresh-env-path

# Install AZDevops Nuget Credential Provider
. $PSScriptRoot\nuget-azdevops-credprovider-install.ps1
refresh-env-path

# Install VSCode
. $PSScriptRoot\vscode-install.ps1
refresh-env-path

# Install Power Platform Command Line
. $PSScriptRoot\powerplatfrom-cli-install.ps1
refresh-env-path

# Install Openstrata
. $PSScriptRoot\openstrata-install.ps1
refresh-env-path

# Install NPM
. $PSScriptRoot\npm-install.ps1
refresh-env-path

# Recommend a short file path for storing repos.

$reposRoot = "c:\repos"

# Check if the Repos Root folder does not exist, and create it if it doesn't
if (-not (Test-Path -Path $reposRoot -PathType Container)) {
    New-Item -Path $reposRoot -ItemType Directory
}









