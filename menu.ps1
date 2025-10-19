do {
    Clear-Host
    Write-Host "=== HERRAMIENTA DE ADMINISTRACION - DATA CENTER ==="
    Write-Host "1. Usuarios del sistema y ultimo login"
    Write-Host "2. Discos y filesystems"
    Write-Host "3. Top 10 archivos mas grandes"
    Write-Host "4. Memoria RAM y Swap"
    Write-Host "5. Backup a USB"
    Write-Host "6. Salir"
    Write-Host ""
    
    $opcion = Read-Host "Seleccione una opcion"
    
    switch ($opcion) {
        "1" { & "$PSScriptRoot\usuarios.ps1" }
        "2" { & "$PSScriptRoot\discos.ps1" }
        "3" { & "$PSScriptRoot\archivos.ps1" }
        "4" { & "$PSScriptRoot\memoria.ps1" }
        "5" { & "$PSScriptRoot\backup.ps1" }
        "6" { Write-Host "Saliendo..."; break }
        default { Write-Host "Opcion invalida" }
    }
    
    if ($opcion -ne "6") {
        Read-Host "`nPresione Enter para continuar"
    }
} while ($opcion -ne "6")