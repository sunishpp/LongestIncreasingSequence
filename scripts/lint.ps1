$ErrorActionPreference = 'Stop'

$dotnet = Get-Command dotnet -ErrorAction Stop
$repositoryRoot = Split-Path -Parent $PSScriptRoot
$solution = Join-Path $repositoryRoot 'LongestIncreasingSubsequence.sln'

& $dotnet.Source build $solution --configuration Release --warnaserror
if ($LASTEXITCODE -ne 0) {
    exit $LASTEXITCODE
}

& $dotnet.Source format $solution analyzers --verify-no-changes --severity warn --no-restore
exit $LASTEXITCODE
