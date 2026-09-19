$ErrorActionPreference = 'Stop'

$coverageDirectory = Join-Path $PSScriptRoot '..\.coverage'
if (Test-Path $coverageDirectory) {
    Remove-Item $coverageDirectory -Recurse -Force
}
New-Item $coverageDirectory -ItemType Directory | Out-Null

dotnet test .\tests\LongestIncreasingSubsequence.Tests\LongestIncreasingSubsequence.Tests.csproj `
    --configuration Release `
    --collect:"XPlat Code Coverage" `
    --results-directory $coverageDirectory

if ($LASTEXITCODE -ne 0) {
    exit $LASTEXITCODE
}

$coverageFile = Get-ChildItem $coverageDirectory -Filter coverage.cobertura.xml -Recurse | Select-Object -First 1
if ($null -eq $coverageFile) {
    throw 'Coverage collection did not produce coverage.cobertura.xml.'
}

Write-Host "Coverage report: $($coverageFile.FullName)"
