Write-Host "`n=== USUARIOS DEL SISTEMA ==="

$usuarios = Get-WmiObject -Class Win32_UserAccount

$resultados = @()
foreach ($user in $usuarios) {
    $loginEvent = Get-EventLog -LogName Security -InstanceId 4624 |
                  Where-Object { $_.Message -like "*$($user.Name)*" } |
                  Select-Object -First 1
    
    $ultimoLogin = if ($loginEvent) { 
        $loginEvent.TimeGenerated 
    } else { 
        "Nunca o no disponible" 
    }
    
    $resultados += [PSCustomObject]@{
        Usuario = $user.Name
        UltimoLogin = $ultimoLogin
    }
}

$resultados | Format-Table -AutoSize