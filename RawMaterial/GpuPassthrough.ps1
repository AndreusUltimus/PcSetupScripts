

# Enable MessageSignaledInterrupt
# https://www.labsrc.com/unraid-nvidia-gpu-passthrough-fix-qemu/
# NVIDIA
$devices = ((gwmi Win32_Bus -Filter 'DeviceID like "PCI%"').GetRelated('Win32_PnPEntity') | Where-Object Manufacturer -match ".*NVIDIA.*")
# High Definition Audio Controller
$devices += ((gwmi Win32_Bus -Filter 'DeviceID like "PCI%"').GetRelated('Win32_PnPEntity') | Where-Object Name -eq "High Definition Audio Controller")
$devices = $devices | Where-Object PnPDeviceID -match "^PCI.*"
$devices | ForEach-Object -Process {
    $path = Join-Path "HKLM:\SYSTEM\CurrentControlSet\Enum" $_.PnPDeviceID
    # Check for existence
    Get-Item $path | Out-Null
    $path = Join-Path $path "Device Parameters"
    Get-Item $path | Out-Null
    $path = Join-Path $path "Interrupt Management"
    Get-Item $path | Out-Null
    $path = Join-Path $path "MessageSignaledInterruptProperties"
    # Get-Item $path | Out-Null
    try { 
        Get-Item $path -ErrorAction stop | Out-Null
    } catch { 
        New-Item $path | Out-Null
        }
    Set-ItemProperty -Path $path -Name "MSISupported" -Value 1 -Type "Dword"  
    # -> MessageSignaledInterruptProperties)
    }

