## Prerequisites

- .NET 8 SDK
- PowerShell 7 or Windows PowerShell
- Docker Desktop, only for container verification
- A GitHub repository, only for GitHub Actions verification

The solution contains the implementation in `src/LongestIncreasingSubsequence` and xUnit tests in `tests/LongestIncreasingSubsequence.Tests`.

## Verify Locally

Open PowerShell in the program folder and run:

```powershell
$env:Path = "C:\Program Files\dotnet;$env:Path"
dotnet --version
```

The version should be `8.x`.

Restore, build, and run all tests:

```powershell
dotnet restore .\LongestIncreasingSubsequence.sln
dotnet test .\LongestIncreasingSubsequence.sln --configuration Release --no-restore
```

A successful run reports all tests passed. The current suite contains 11 tests.

## Lint

Run compiler warnings-as-errors and analyzer formatting checks:

```powershell
.\scripts\lint.ps1
```

The command should finish with `Build succeeded`, `0 Warning(s)`, and `0 Error(s)`. The analyzer check fails if formatting or configured diagnostics need attention.

## Code Coverage

Generate a Cobertura coverage report:

```powershell
.\scripts\test-coverage.ps1
```

The script runs all tests and prints the report path. The report is written under `coverage` as `coverage.cobertura.xml`. The `coverage` directory is generated output and is ignored by Git.

## Docker

Build the test image:

```powershell
docker build --target test -t longest-increasing-subsequence:test .
```

Run the tests inside the container:

```powershell
docker run --rm longest-increasing-subsequence:test
```

The container test run should report all tests passed.

## GitHub Actions

The workflow is [`.github/workflows/ci.yml`](.github/workflows/ci.yml). It runs on pull requests and pushes to `main` and performs restore, build, lint, tests, and coverage collection.

To verify CI:

1. Push the repository to GitHub.
2. Open the repository's **Actions** tab.
3. Open the **CI** workflow run for the push or pull request.
4. Confirm the `build-test-lint` job succeeds.
5. Download the `coverage-report` artifact to inspect the Cobertura XML report.

A failed job identifies the step that needs attention, such as build, lint, or tests.
