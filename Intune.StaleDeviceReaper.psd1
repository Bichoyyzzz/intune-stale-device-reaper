@{
    RootModule        = 'Intune.StaleDeviceReaper.psm1'
    ModuleVersion     = '1.0.0'
    GUID              = 'e7b4d6e1-9c4c-4b7f-8a5b-2f3fbb0a0001'
    Author            = 'GHATAS Bichoy'
    CompanyName       = 'Portfolio'
    Copyright         = '(c) GHATAS'
    PowerShellVersion = '7.0'
    FunctionsToExport = @(
        'Get-StaleIntuneDevice',
        'Remove-IntuneDevice',
        'Invoke-IntuneCleanup'
    )
    PrivateData = @{
        PSData = @{
            Tags = @('Intune','Graph','Automation','Cleanup')
            ProjectUri = 'https://github.com/<toncompte>/intune-stale-device-reaper'
        }
    }
}
