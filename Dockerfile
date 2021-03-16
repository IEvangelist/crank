FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build-env

# Copy everything and restore
COPY . ./
RUN dotnet publish ./src/Microsoft.Crank.Controler/Microsoft.Crank.Controler.csproj -c Release -o out --no-self-contained

# Label the container
LABEL maintainer="Sebastien Ros <sebastien.ros@microsoft.com>"
LABEL repository="https://github.com/dotnet/crank"
LABEL homepage="https://github.com/dotnet/crank"

LABEL com.github.actions.name="Microsoft Crank"
LABEL com.github.actions.description="From a GitHub pull request, an admin can comment and trigger a benchmark test run for a given scenario."
LABEL com.github.actions.icon="zap"
LABEL com.github.actions.color="purple"

# Build the runtime image
FROM mcr.microsoft.com/dotnet/runtime:5.0
COPY --from=build-env /out .
ENTRYPOINT [ "dotnet", "/Microsoft.Crank.Controler.dll" ]