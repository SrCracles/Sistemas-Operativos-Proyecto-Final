Write-Host "`n=== TOP 10 LARGEST FILES ==="

$drive = Read-Host "Enter drive (example: C:)"

if (-not (Test-Path $drive)) {
    Write-Host "Drive does not exist"
    return
}

$files = Get-ChildItem -Path $drive -Recurse -File | Sort-Object Length -Descending | Select-Object -First 10

$results = @()
foreach ($file in $files) {
    $results += [PSCustomObject]@{
        FullPath = $file.FullName
        SizeBytes = $file.Length
    }
}

$results | Format-Table -AutoSize