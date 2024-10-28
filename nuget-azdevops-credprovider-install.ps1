
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

