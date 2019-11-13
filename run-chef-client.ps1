[CmdletBinding()]
param (
    [Parameter(Mandatory = $false)]
    [String]
    $RunList = 'windows_baseline::default',
    [Parameter(Mandatory = $false)]
    [String]
    $ChefInstallDirectory = 'C:\opscode\chef-workstation'
)

begin {
    $ErrorActionPreference = 'Stop'

    function Invoke-CleanExit ($ExitCode) {
        Pop-Location
        exit $ExitCode
    }

    Push-Location -Path $PSScriptRoot
    if (Test-Path -Path "$PSScriptRoot\vendor\cookbooks") {
        Remove-Item -Path "$PSScriptRoot\vendor\cookbooks" -Recurse -Force
    }

    $process = Start-Process -FilePath "$ChefInstallDirectory\bin\berks.bat" -ArgumentList 'vendor', "$PSScriptRoot\vendor\cookbooks", '-b', "$PSScriptRoot\Berksfile", '--delete' -NoNewWindow -Wait -PassThru
    $process.WaitForExit()
    if ($process.ExitCode -ne 0) {
        Invoke-CleanExit -ExitCode $process.ExitCode
    }

    $process = Start-Process -FilePath "$ChefInstallDirectory\bin\chef-client.bat" -ArgumentList '-z', '-o', "'$RunList'" -NoNewWindow -Wait -PassThru
    $process.WaitForExit()
    if ($process.ExitCode -ne 0) {
        Invoke-CleanExit -ExitCode $process.ExitCode
    }

    Invoke-CleanExit -ExitCode 0
}
