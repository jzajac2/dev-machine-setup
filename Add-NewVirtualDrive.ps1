[CmdletBinding()]
Param(
    [string]$vmName,
    [string]$fullPathToVdiToCreate,
    [int]$initialDiskSize = 10000
)

if (Test-Path $fullPathToVdiToCreate) {
    $shouldOverwrite = Read-Host "$fullPathToVdiToCreate already exists. Ovewrite? (Y/n):"
    if ($shouldOverwrite.Contains("Y")) {
        Remove-Item -Path $fullPathToVdiToCreate -Force
        vboxmanage storageattach $vmName --storagectl "SATA" --port 2 --medium none
        vboxmanage closemedium disk $fullPathToVdiToCreate
    }
    else {
        Write-Host "Aborting second disk creation"
        return
    }
}

# Create 10GB Dynamic disk
VBoxManage createhd --filename $fullPathToVdiToCreate --size $initialDiskSize --variant Standard 

# Attach it to existing SATA controller (you can only have one SATA device)
VBoxManage storageattach $vmName --storagectl "SATA" `
--port 2 --device 0 --type hdd `
--medium "$fullPathToVdiToCreate"
