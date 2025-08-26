function Remove-IntuneDevice {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)][string]$ManagedDeviceId,
        [string]$AzureAdDeviceId,
        [switch]$AlsoRemoveFromEntraId
    )
    Connect-GraphApp -Scopes "DeviceManagementManagedDevices.ReadWrite.All" | Out-Null
    $uri = "https://graph.microsoft.com/v1.0/deviceManagement/managedDevices/$ManagedDeviceId"
    if ($PSCmdlet.ShouldProcess("Intune managedDevice $ManagedDeviceId","DELETE")) {
        Invoke-WithGraphRetry { Invoke-MgGraphRequest -Method DELETE -Uri $uri } | Out-Null
    }
    if ($AlsoRemoveFromEntraId -and $AzureAdDeviceId) {
        Connect-GraphApp -Scopes "Device.ReadWrite.All" | Out-Null
        $uri2 = "https://graph.microsoft.com/v1.0/devices/$AzureAdDeviceId"
        if ($PSCmdlet.ShouldProcess("Entra device $AzureAdDeviceId","DELETE")) {
            Invoke-WithGraphRetry { Invoke-MgGraphRequest -Method DELETE -Uri $uri2 } | Out-Null
        }
    }
}
