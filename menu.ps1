do {
    Clear-Host
    Write-Host "=== DATA CENTER ADMINISTRATION TOOL ==="
    Write-Host "1. System users and last login"
    Write-Host "2. Disks and volumes"
    Write-Host "3. Top 10 largest files"
    Write-Host "4. RAM and Swap memory"
    Write-Host "5. Backup to USB"
    Write-Host "6. Exit"
    Write-Host ""
    
    $option = Read-Host "Select an option"
    
    switch ($option) {
        "1" { & "$PSScriptRoot\users.ps1" }
        "2" { & "$PSScriptRoot\disks.ps1" }
        "3" { & "$PSScriptRoot\files.ps1" }
        "4" { & "$PSScriptRoot\memory.ps1" }
        "5" { & "$PSScriptRoot\backup.ps1" }
        "6" { Write-Host "Exiting..."; break }
        default { Write-Host "Invalid option" }
    }
    
    if ($option -ne "6") {
        Read-Host "`nPress Enter to continue"
    }
} while ($option -ne "6")