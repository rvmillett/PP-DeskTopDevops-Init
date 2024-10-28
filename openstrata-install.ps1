
Write-Output "Running openstrata-install.ps1"


Write-Output "dotnet new install OpenStrata.NET.Templates"
dotnet new install OpenStrata.NET.Templates

dotnet new install OpenStrata.Devops.VSCode.New

