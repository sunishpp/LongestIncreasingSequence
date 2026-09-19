FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

COPY LongestIncreasingSubsequence.sln ./
COPY src ./src
COPY tests ./tests

RUN dotnet restore LongestIncreasingSubsequence.sln
RUN dotnet build LongestIncreasingSubsequence.sln --configuration Release --no-restore --warnaserror

FROM build AS test
ENTRYPOINT ["dotnet", "test", "LongestIncreasingSubsequence.sln", "--configuration", "Release", "--no-build", "--logger", "console;verbosity=normal"]