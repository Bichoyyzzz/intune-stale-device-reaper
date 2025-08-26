. $PSScriptRoot/Private/Invoke-WithGraphRetry.ps1
. $PSScriptRoot/Private/Connect-GraphApp.ps1
Get-ChildItem -Path $PSScriptRoot/Public/*.ps1 | ForEach-Object {. $_.FullName }
Export-ModuleMember -Function Get-StaleIntuneDevice,Remove-IntuneDevice,Invoke-IntuneCleanup
