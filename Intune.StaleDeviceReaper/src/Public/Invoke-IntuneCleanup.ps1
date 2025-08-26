function Invoke-IntuneCleanup {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)][int]$OlderThanDays = 90,
        [string[]]$OperatingSystem,
        [switch]$AlsoRemoveFromEntraId,
        [switch]$WhatIf
    )
    $stale = Get-StaleIntuneDevice -OlderThanDays $OlderThanDays -OperatingSystem $OperatingSystem -IncludeProperties
    foreach ($d in $stale) {
        Remove-IntuneDevice -ManagedDeviceId $d.Id -AzureAdDeviceId $d.azureADDeviceId -AlsoRemoveFromEntraId:$AlsoRemoveFromEntraId -WhatIf:$WhatIf
    }
    return $stale
}
