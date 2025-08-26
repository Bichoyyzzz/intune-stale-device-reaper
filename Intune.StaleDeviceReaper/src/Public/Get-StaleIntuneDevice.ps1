function Get-StaleIntuneDevice {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][int]$OlderThanDays,
        [string[]]$OperatingSystem,
        [switch]$IncludeProperties
    )
    Connect-GraphApp -Scopes "DeviceManagementManagedDevices.Read.All" | Out-Null
    $cutoff = (Get-Date).AddDays(-$OlderThanDays)
    $props = @("id","deviceName","userPrincipalName","operatingSystem","lastSyncDateTime","azureADDeviceId","enrolledDateTime","complianceState")
    if ($IncludeProperties) { $props += @("manufacturer","model","serialNumber") }
    $devices = Invoke-WithGraphRetry { Get-MgDeviceManagementManagedDevice -All -Property $props }
    if ($OperatingSystem) { $devices = $devices | Where-Object { $OperatingSystem -contains $_.operatingSystem } }
    $devices | Where-Object { $_.lastSyncDateTime -lt $cutoff } | Select-Object $props
}
