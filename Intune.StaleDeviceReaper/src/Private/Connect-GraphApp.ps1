function Connect-GraphApp {
    [CmdletBinding()]
    param(
        [string[]]$Scopes = @("DeviceManagementManagedDevices.Read.All")
    )
    if (-not (Get-MgContext)) {
        Connect-MgGraph -Scopes $Scopes | Out-Null
        Select-MgProfile -Name "v1.0"
    }
}
