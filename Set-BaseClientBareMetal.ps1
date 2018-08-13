

#Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco feature enable -n allowGlobalConfirmation
Set-ExecutionPolicy Bypass -Scope Process -Force

#Boxstarter for reboot resiliency
#choco install boxstarter -Y

# First lets rename the computer
[string]$isRenamingComputer = Read-Host "Computer name is currently $Env:COMPUTERNAME. Do you want to rename the computer? (Y/n)"
if ($isRenamingComputer.Contains("Y")) {
    $computerName = Read-Host "What is the new name for this vm? (a reboot will occur after this):" 
    Rename-Computer -NewName $computerName -Restart -Force #TODO: enforce computer naming standards
}

choco install sonos-controller -Y
choco install googlechrome -Y

## vbox and vagrant should be allowed to run on external drive.
## vboxmanage doesn't seem to have any way to set this preference automatically
## After installing virtualbox, go to Preferences and set the default machine folder to D:\
## need to automate this: https://medium.com/@cedricdue/moving-vagrant-boxes-and-related-virtualbox-vms-to-another-drive-f1d7c50d20bchttps://medium.com/@cedricdue/moving-vagrant-boxes-and-related-virtualbox-vms-to-another-drive-f1d7c50d20bc
choco install virtualbox -Y
VBoxManage setproperty machinefolder "D:"  
choco install vagrant -Y
[Environment]::SetEnvironmentVariable("VAGRANT_HOME", "D:\vagrant\.vagrant.d", "Machine")

choco install vscode -Y
choco install vscode-powershell -Y
choco install vscode-csharp -Y

#git
choco install git.install -Y
git config --global user.email "jzajac2@gmail.com"
git config --global user.name "John Zajac"

choco install atom -Y
choco install sublimetext3 -Y

# 
choco install terraform -Y

# choco install gotomeeting -Y # busted!

# Media / fun
choco install spotify -Y

# utilities
choco install greenshot -Y
choco install googledrive -Y


#dirs setup
mkdir C:\code\git\Projects
mkdir C:\code\git\repos


#Clear event logs
Clear-EventLog -LogName (Get-EventLog -List).log
