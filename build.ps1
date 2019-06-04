[CmdletBinding()]
param (
    # The cookbook to test. If not provided, all will be tested.
    [Parameter(Mandatory = $false)]
    [ValidateSet('development', 'windows_baseline')]
    [String]
    $Cookbook
)

begin {
    $ErrorActionPreference = 'Stop'

    function Invoke-CleanExit ($ExitCode) {
        Pop-Location
        exit $ExitCode
    }

    function Test-ChefCookbook ($Name) {
        $path = "$PSScriptRoot\cookbooks\$Name"
        if (-not (Test-Path -Path $path)) {
            Write-Error -Message "Cookbook not found."
            Invoke-CleanExit -ExitCode 1
        }

        Push-Location -Path $path
        $process = Start-Process -FilePath 'chef' -ArgumentList 'exec', 'rake' -NoNewWindow -Wait -PassThru
        $process.WaitForExit()
        if ($process.ExitCode -ne 0) {
            Pop-Location
            Invoke-CleanExit -ExitCode $process.ExitCode
        }

        Pop-Location
    }

    Push-Location -Path "$PSScriptRoot"
    $cookbooks = Get-ChildItem -Path "$PSScriptRoot\cookbooks" | Where-Object { $_.PSIsContainer } | Select-Object -ExpandProperty Name

    if ($Cookbook) {
        Test-ChefCookbook -Name $Cookbook
    }
    else {
        foreach ($cb in $cookbooks) {
            Test-ChefCookbook -Name $cb
        }
    }

    Invoke-CleanExit -ExitCode 0
}
