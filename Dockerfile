FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /app

COPY /src .
RUN dotnet restore myhelloworld/myhelloworld.csproj --no-cache
RUN dotnet build myhelloworld/myhelloworld.csproj -c Release /p:TreatWarningsAsErrors=true /warnaserror

FROM build AS publish
RUN dotnet publish myhelloworld/myhelloworld.csproj -c Release --no-build -o /app/out

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
COPY --from=publish /app/out .
ENTRYPOINT ["dotnet", "myhelloworld.dll"]