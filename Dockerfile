# Use the official .NET 9.0 SDK image for building
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /app

# Copy csproj files and restore dependencies
COPY *.sln ./
COPY RotaryClubManager.API/*.csproj ./RotaryClubManager.API/
COPY RotaryClubManager.Application/*.csproj ./RotaryClubManager.Application/
COPY RotaryClubManager.Domain/*.csproj ./RotaryClubManager.Domain/
COPY RotaryClubManager.Infrastructure/*.csproj ./RotaryClubManager.Infrastructure/

# Restore dependencies
RUN dotnet restore

# Copy the rest of the source code
COPY . ./

# Build the application
RUN dotnet build -c Release --no-restore

# Publish the application
RUN dotnet publish RotaryClubManager.API/RotaryClubManager.API.csproj -c Release -o /app/publish --no-restore

# Use the official .NET 9.0 runtime image for running
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS runtime
WORKDIR /app

# Install curl for health checks (optional)
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Copy the published application
COPY --from=build /app/publish .

# Create a non-root user for security
RUN adduser --disabled-password --gecos '' appuser && chown -R appuser /app
USER appuser

# Expose port 8080 (required by Render)
EXPOSE 8080

# Set environment variables
ENV ASPNETCORE_URLS=http://+:8080
ENV ASPNETCORE_ENVIRONMENT=Production

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:8080/health || exit 1

# Start the application
ENTRYPOINT ["dotnet", "RotaryClubManager.API.dll"]
