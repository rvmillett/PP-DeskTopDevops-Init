

$origScript = "$PSScriptRoot\build-desktop-init.ps1"
$finalScript = "$PSScriptRoot\desktop-init.ps1"

$origScript

$scriptCallRegEx = '^\. \$PSScriptRoot\\([\w-]+\.ps1)'

$selectResult = Select-String -Path $origScript -Pattern $scriptCallRegEx

$newScript = Get-Content -Path $origScript  -Encoding utf8 -Raw

foreach ($match in $selectResult.Matches)
{
    $replaceStr = $match.Value.Trim()

    $replaceContentPath = "$PSScriptRoot\$($match.Groups[1].Value)"
    $replaceContent = Get-Content -Path $replaceContentPath  -Encoding utf8  -Raw

    $newScript = $newScript.Replace($replaceStr,$replaceContent)


}

$newScript | Out-File -FilePath $finalScript -Encoding utf8