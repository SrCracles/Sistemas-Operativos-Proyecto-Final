Write-Host "`n=== BACKUP TO USB ==="

$sourceDirectory = Read-Host "Enter source directory path"

if (-not (Test-Path $sourceDirectory)) {
    Write-Host "Directory does not exist"
    return
}

Write-Host "`nAvailable USB drives:"
$usbDrives = Get-WmiObject -Class Win32_LogicalDisk -Filter "DriveType=2"

if ($usbDrives.Count -eq 0) {
    Write-Host "No USB drives connected"
    return
}

$usbDrives | Format-Table DeviceID, VolumeName, @{n='SizeGB';e={$_.Size/1GB}}

$destinationDrive = Read-Host "Enter destination USB drive (example: E:)"

if (-not (Test-Path $destinationDrive)) {
    Write-Host "Drive does not exist"
    return
}

$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$folderName = "Backup_$timestamp"
$backupPath = Join-Path $destinationDrive $folderName

Write-Host "Creating backup..."
New-Item -Path $backupPath -ItemType Directory -Force | Out-Null

Copy-Item -Path "$sourceDirectory\*" -Destination $backupPath -Recurse -Force

Write-Host "Generating catalog..."
$files = Get-ChildItem -Path $backupPath -Recurse -File

$catalog = @()
foreach ($file in $files) {
    $catalog += [PSCustomObject]@{
        Name = $file.Name
        FullPath = $file.FullName
        SizeBytes = $file.Length
        LastModification = $file.LastWriteTime
    }
}

$catalogPath = Join-Path $backupPath "catalog.csv"
$catalog | Export-Csv -Path $catalogPath -NoTypeInformation

Write-Host "`nBackup completed"
Write-Host "Location: $backupPath"
Write-Host "Files: $($files.Count)"
Write-Host "Catalog: $catalogPath"