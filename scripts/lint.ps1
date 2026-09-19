$ErrorActionPreference = 'Stop'

$dotnet = Get-Command dotnet -ErrorAction Stop
& $dotnet.Source build .\LongestIncreasingSubsequence.sln --configuration Release --warnaserror
if ($LASTEXITCODE -ne 0) {
    exit $LASTEXITCODE
}

& $dotnet.Source format .\LongestIncreasingSubsequence.sln analyzers --verify-no-changes --severity warn --no-restore
exit $LASTEXITCODE
