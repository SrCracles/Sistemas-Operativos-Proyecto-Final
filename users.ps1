Write-Host "`n=== SYSTEM USERS ==="

$users = Get-WmiObject -Class Win32_UserAccount

$results = @()
foreach ($user in $users) {
    $loginEvent = Get-EventLog -LogName Security -InstanceId 4624|
                  Where-Object { $_.Message -like "*$($user.Name)*" } |
                  Select-Object -First 1
    
    $lastLogin = if ($loginEvent) { 
        $loginEvent.TimeGenerated 
    } else { 
        "Never or not available" 
    }
    
    $results += [PSCustomObject]@{
        User = $user.Name
        LastLogin = $lastLogin
    }
}

$results | Format-Table -AutoSize