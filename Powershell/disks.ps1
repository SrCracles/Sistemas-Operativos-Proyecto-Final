Write-Host "`n=== DISKS AND VOLUMES ==="

$disks = Get-WmiObject -Class Win32_LogicalDisk

$results = @()
foreach ($disk in $disks) {
    $results += [PSCustomObject]@{
        Drive = $disk.DeviceID
        SizeBytes = $disk.Size
        FreeSpaceBytes = $disk.FreeSpace
    }
}

$results | Format-Table -AutoSize