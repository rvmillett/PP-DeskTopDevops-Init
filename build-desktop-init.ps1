
Write-Output "Running ado-desktop-init.ps1"

#  Install winget for Windows

. $PSScriptRoot\winget-install.ps1

# Core Installs

#  Install Git for Windows

. $PSScriptRoot\git-install.ps1

# Install Dotnet
. $PSScriptRoot\dotnet-install.ps1

# Install .Net Framework
. $PSScriptRoot\dotnet-framework-install.ps1

# Install AZDevops Nuget Credential Provider
. $PSScriptRoot\nuget-azdevops-credprovider-install.ps1

# Install VSCode
. $PSScriptRoot\vscode-install.ps1

# Install Power Platform Command Line
. $PSScriptRoot\powerplatfrom-cli-install.ps1

# Install Openstrata
. $PSScriptRoot\openstrata-install.ps1

# Install NPM
. $PSScriptRoot\npm-install.ps1

# Recommend a short file path for storing repos.

$reposRoot = "c:\repos"

# Check if the Repos Root folder does not exist, and create it if it doesn't
if (-not (Test-Path -Path $reposRoot -PathType Container)) {
    New-Item -Path $reposRoot -ItemType Directory
}









