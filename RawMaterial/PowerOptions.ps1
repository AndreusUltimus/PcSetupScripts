# Enable hibernation
$key = "HKLM:\System\CurrentControlSet\Control\Power\"
$name = "HibernateEnabledDefault"
$value = 1
Set-ItemProperty -path $key -name $name -value $value

# Show hibernate button in Start Menu
$path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings\"
try { 
    Get-Item $path -ErrorAction stop | Out-Null
} catch { 
    New-Item $path | Out-Null
    }
$name = "ShowHibernateOption"
$value = 1
Set-ItemProperty -path $path -name $name -value $value

