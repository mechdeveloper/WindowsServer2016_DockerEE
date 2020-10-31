FROM microsoft/iis

SHELL ["powershell"]

RUN Install-WindowsFeature NET-Framework-45-ASPNET; \
    Install-WindowsFeature Web-Asp-Net45

COPY mywebsite mywebsite

RUN Remove-Website -Name 'Default Web Site'
RUN New-Website -Name 'guidgenerator' -port 80 \
    -PhysicalPath 'c:\mywebsite' -ApplicationPool '.NET v4.5'

EXPOSE 80

CMD ["ping", "-t", "localhost"]