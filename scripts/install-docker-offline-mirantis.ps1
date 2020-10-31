# Docker EE for Windows Server 2019 or later
# https://docs.mirantis.com/docker-enterprise/v3.1/dockeree-products/docker-engine-enterprise/dee-windows.html

# Install Docker EE
Invoke-WebRequest -Uri https://get.mirantis.com/install.ps1 -o install.ps1
.\install.ps1 -DownloadOnly
.\install.ps1 -Offline
