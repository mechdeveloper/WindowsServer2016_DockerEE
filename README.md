# Docker on Windows Server 2016

## Official Microsoft Docs

- [Set up your environment](https://docs.microsoft.com/en-us/virtualization/windowscontainers/quick-start/set-up-environment?tabs=Windows-Server)
- [Docker Engine on Windows](https://docs.microsoft.com/en-us/virtualization/windowscontainers/manage-docker/configure-docker-daemon)
- [Container samples](https://docs.microsoft.com/en-us/virtualization/windowscontainers/samples)

## Use a script to install Docker EE on Windows Server 2016

### On an online machine, download the zip file

```pwsh
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest -OutFile docker-19.03.12.zip https://dockermsft.azureedge.net/dockercontainer/docker-19-03-12.zip
```

### If you need to download a specific Docker EE Engine release, all URLs can be found on this JSON index

<https://dockermsft.blob.core.windows.net/dockercontainer/DockerMsftIndex.json>

### Stop Docker service if eralier version of Docker is already installed

```pwsh
Stop-Service docker
```

### Extract the archive

```pwsh
Expand-Archive docker-19.03.12.zip -DestinationPath $Env:ProgramFiles -Force
```

### Clean up the zip file

```pwsh
Remove-Item -Force docker-19.03.12.zip
```

### Install Docker. This requires rebooting

```pwsh
$null = Install-WindowsFeature containers
Restart-Computer -Force
```

### Add Docker to the path for the current session

```pwsh
$env:path += ";$env:ProgramFiles\docker"
```

### Optionally, modify PATH to persist across sessions

```pwsh
$newPath = "$env:ProgramFiles\docker;" +
[Environment]::GetEnvironmentVariable("PATH",
[EnvironmentVariableTarget]::Machine)
[Environment]::SetEnvironmentVariable("PATH", $newPath,
[EnvironmentVariableTarget]::Machine)
```

### Register the Docker daemon as a service

```pwsh
dockerd --register-service
```

### Start the Docker service

```pwsh
Start-Service docker
```

### Pull base Windows images

```pwsh
docker pull mcr.microsoft.com/windows/servercore:ltsc2016
docker pull mcr.microsoft.com/windows/nanoserver:sac2016
```

### Docker Commands

```pwsh
docker info
docker pull (from hub.docker.com)
docker images
docker run
docker ps
docker ps -a
docker stop
docker rm

docker run <image>
docker run --name=<customname> <image>
docker run --rm <image>
docker run -d <iamge>
docker run -d -it <image>
docker run -d -p <portOut(HOST)>:<portIn(Container)>
```

### Build docker image

```pwsh
docker build -t <imagename> .
```

### Run IIS container

```pwsh
docker run -d -p 9080:80 <imagename>
```

```pwsh
# get container ip
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' <containerID>
```

```pwsh
Invoke-WebRequest http://<containerip>:9080 -usebasicparsing
```
