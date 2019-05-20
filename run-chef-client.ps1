[CmdletBinding()]
param (
    [Parameter(Mandatory = $false)]
    [String]
    $RunList = 'windows_baseline::default'
)

begin {
    $ErrorActionPreference = 'Stop'

    $process = Start-Process -FilePath 'berks' -ArgumentList 'vendor', "$PSScriptRoot\vendor\cookbooks", '--delete' -NoNewWindow -Wait -PassThru
    $process.WaitForExit()
    if ($process.ExitCode -ne 0) {
        exit $process.ExitCode
    }

    $process = Start-Process -FilePath 'chef-client' -ArgumentList '-z', '-o', "'$RunList'" -NoNewWindow -Wait -PassThru
    $process.WaitForExit()
    if ($process.ExitCode -ne 0) {
        exit $process.ExitCode
    }

    exit 0
}
