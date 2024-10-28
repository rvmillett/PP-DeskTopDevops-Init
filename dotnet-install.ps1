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


