Import-Module "$PSScriptRoot/../src/Intune.StaleDeviceReaper.psd1" -Force
Describe 'Get-StaleIntuneDevice' {
    It 'Filtre bien sur OlderThanDays' {
        Mock -CommandName Get-MgDeviceManagementManagedDevice -ModuleName Microsoft.Graph.DeviceManagement -MockWith {
            @(
              [pscustomobject]@{ id='1'; deviceName='PC-1'; operatingSystem='Windows'; lastSyncDateTime=(Get-Date).AddDays(-120); azureADDeviceId=[guid]::NewGuid() }
              [pscustomobject]@{ id='2'; deviceName='PC-2'; operatingSystem='Windows'; lastSyncDateTime=(Get-Date).AddDays(-5);  azureADDeviceId=[guid]::NewGuid() }
            )
        }
        $res = Get-StaleIntuneDevice -OlderThanDays 90
        $res | Should -Not -BeNullOrEmpty
        ($res | Measure-Object).Count | Should -Be 1
        $res[0].deviceName | Should -Be 'PC-1'
    }
}
