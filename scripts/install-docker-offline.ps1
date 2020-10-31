# Use a script to install Docker EE on Windows Server 2016
# https://mpolinowski.github.io/windows-server-2019-docker-daemon

# On an online machine, download the zip file.
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest -OutFile docker-19.03.12.zip https://dockermsft.azureedge.net/dockercontainer/docker-19-03-12.zip

# If you need to download a specific Docker EE Engine release, all URLs can be found on this JSON index.
# https://dockermsft.blob.core.windows.net/dockercontainer/DockerMsftIndex.json

# Stop Docker service if eralier version of Docker is already installed
Stop-Service docker
    
# Extract the archive.
Expand-Archive docker-19.03.12.zip -DestinationPath $Env:ProgramFiles -Force

# Clean up the zip file.
Remove-Item -Force docker-19.03.12.zip

# Install Docker. This requires rebooting.
$null = Install-WindowsFeature containers
Restart-Computer -Force

# Add Docker to the path for the current session.
$env:path += ";$env:ProgramFiles\docker"

# Optionally, modify PATH to persist across sessions.
$newPath = "$env:ProgramFiles\docker;" +
[Environment]::GetEnvironmentVariable("PATH",
[EnvironmentVariableTarget]::Machine)
[Environment]::SetEnvironmentVariable("PATH", $newPath,
[EnvironmentVariableTarget]::Machine)

# Register the Docker daemon as a service.
dockerd --register-service

# Start the Docker service.
Start-Service docker

# Pull base Windows images 
docker pull mcr.microsoft.com/windows/servercore:ltsc2016
docker pull mcr.microsoft.com/windows/nanoserver:sac2016