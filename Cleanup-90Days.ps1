Connect-MgGraph -Scopes "DeviceManagementManagedDevices.ReadWrite.All","Device.ReadWrite.All"
Select-MgProfile v1.0
Invoke-IntuneCleanup -OlderThanDays 90 -OperatingSystem @('Windows','macOS') -AlsoRemoveFromEntraId -WhatIf
