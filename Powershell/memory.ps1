Write-Host "`n=== MEMORY AND SWAP ==="

$os = Get-WmiObject -Class Win32_OperatingSystem
$freeMemoryBytes = $os.FreePhysicalMemory * 1KB
$totalMemoryBytes = $os.TotalVisibleMemorySize * 1KB
$usedMemoryBytes = $totalMemoryBytes - $freeMemoryBytes
$memoryPercentage = ($usedMemoryBytes / $totalMemoryBytes) * 100

Write-Host "`nRAM MEMORY:"
Write-Host "  Free: $freeMemoryBytes bytes"
Write-Host "  Total: $totalMemoryBytes bytes"
Write-Host "  Usage percentage: $memoryPercentage%"

$pageFile = Get-WmiObject -Class Win32_PageFileUsage

if ($pageFile) {
    $swapUsedBytes = $pageFile.CurrentUsage * 1MB
    $swapTotalBytes = $pageFile.AllocatedBaseSize * 1MB
    $swapPercentage = ($pageFile.CurrentUsage / $pageFile.AllocatedBaseSize) * 100
    
    Write-Host "`nSWAP:"
    Write-Host "  In use: $swapUsedBytes bytes"
    Write-Host "  Total: $swapTotalBytes bytes"
    Write-Host "  Usage percentage: $swapPercentage%"
} else {
    Write-Host "`nNo page file configured"
}