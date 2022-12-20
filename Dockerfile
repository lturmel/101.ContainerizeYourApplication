FROM mcr.microsoft.com/dotnet/sdk:7.0 AS mybuild
WORKDIR /app
COPY /src .

RUN dotnet restore myhelloworld/myhelloworld.csproj --no-cache
RUN dotnet build myhelloworld/myhelloworld.csproj -c Release /p:TreatWarningsAsErrors=true /warnaserror
RUN dotnet publish myhelloworld/myhelloworld.csproj -c Release --no-build -o /app/out

FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
COPY --from=mybuild /app/out .
ENTRYPOINT ["dotnet", "myhelloworld.dll"]