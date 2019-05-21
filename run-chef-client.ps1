[CmdletBinding()]
param (
    [Parameter(Mandatory = $false)]
    [String]
    $RunList = 'windows_baseline::default'
)

begin {
    $ErrorActionPreference = 'Stop'

    function Invoke-CleanExit ($ExitCode) {
        Pop-Location
        exit $ExitCode
    }

    Push-Location -Path $PSScriptRoot
    $process = Start-Process -FilePath 'berks' -ArgumentList 'vendor', "$PSScriptRoot\vendor\cookbooks", '-b', "$PSScriptRoot\Berksfile", '--delete' -NoNewWindow -Wait -PassThru
    $process.WaitForExit()
    if ($process.ExitCode -ne 0) {
        Invoke-CleanExit -ExitCode $process.ExitCode
    }

    $process = Start-Process -FilePath 'chef-client' -ArgumentList '-z', '-o', "'$RunList'" -NoNewWindow -Wait -PassThru
    $process.WaitForExit()
    if ($process.ExitCode -ne 0) {
        Invoke-CleanExit -ExitCode $process.ExitCode
    }

    Invoke-CleanExit -ExitCode 0
}
