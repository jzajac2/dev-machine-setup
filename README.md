Steps
1. Launch powershell as admin and install chocolatey:
`Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))`
1. install `git`: 
`choco install git.install --params "/GitAndUnixToolsOnPath /NoGitLfs /SChannel /NoAutoCrlf"` 
Notes:
- Create-NewDevEnv module Module hosted on: https://www.powershellgallery.com/
