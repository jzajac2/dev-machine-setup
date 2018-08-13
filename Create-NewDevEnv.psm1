Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco feature enable -n allowGlobalConfirmation
Set-ExecutionPolicy Bypass -Scope Process -Force

#Boxstarter for reboot resiliency
choco install boxstarter -Y

# First lets rename the computer
[string]$isRenamingComputer = Read-Host "Computer name is currently $Env:COMPUTERNAME. Do you want to rename the computer? (Y/n)"
if ($isRenamingComputer.Contains("Y")) {
    $computerName = Read-Host "What is the new name for this vm? (a reboot will occur after this):" 
    Rename-Computer -NewName $computerName -Restart -Force #TODO: enforce computer naming standards
}

# TODO: Initialize disk above

## vbox and vagrant should be allowed to run on external drive.
## vboxmanage doesn't seem to have any way to set this preference automatically
## After installing virtualbox, go to Preferences and set the default machine folder to D:\
## need to automate this: https://medium.com/@cedricdue/moving-vagrant-boxes-and-related-virtualbox-vms-to-another-drive-f1d7c50d20bchttps://medium.com/@cedricdue/moving-vagrant-boxes-and-related-virtualbox-vms-to-another-drive-f1d7c50d20bc
choco install virtualbox -Y
.\Add-NewVirtualDrive.ps1 -vmName "test2-win10" -fullPathToVdiToCreate G:\vm\test2-win10\secondHardDisk.vdi -initialDiskSize 10000

choco install vagrant -Y
if (Test-Path "D:\") {
    mkdir "D:\vagrant\.vagrant.d"
    [Environment]::SetEnvironmentVariable("VAGRANT_HOME", "D:\vagrant\.vagrant.d", "Machine")
    VBoxManage setproperty machinefolder "D:"
}

# Dev IDEs and editors
choco install vscode -Y
choco install vscode-powershell -Y
choco install vscode-csharp -Y
choco install atom -Y
choco install sublimetext3 -Y

#git
choco install git.install -Y
git config --global user.email "jzajac2@gmail.com"
git config --global user.name "John Zajac"

# CI/CD tools 
choco install terraform -Y

# choco install gotomeeting -Y # busted!
choco install googlechrome -Y

# Media / fun
choco install spotify -Y
choco install sonos-controller -Y

# utilities
choco install greenshot -Y
choco install googledrive -Y

#dirs setup
mkdir C:\code\git\Projects
mkdir C:\code\git\repos

#Clear event logs
Clear-EventLog -LogName (Get-EventLog -List).log
