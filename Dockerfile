FROM 172.18.4.68:5000/mcr.microsoft.com/dotnet/core/sdk AS build
WORKDIR /app
COPY . .
RUN dotnet publish src/DShop.Services.Discounts -c Release -o out

FROM 172.18.4.68:5000/mcr.microsoft.com/dotnet/core/aspnet:2.2
WORKDIR /app
COPY --from=build /app/src/DShop.Services.Discounts/out .
ENV ASPNETCORE_URLS http://*:5555
ENV ASPNETCORE_ENVIRONMENT docker
ENTRYPOINT dotnet DShop.Services.Discounts.dll