

Install-WindowsFeature Direct-Play | Out-Null


# Install VB AUDIO cable as a virtual audio device
#  https://github.com/parsec-cloud/Parsec-Cloud-Preparation-Tool/blob/master/PostInstall/PostInstall.ps1#L693
choco install -y vb-cable
Set-Service -Name audiosrv -StartupType Automatic
Start-Service -Name audiosrv



# Install parsec for all users
choco install -y parsec /Shared
# TODO: Login!?
# TODO: Edit config files!?!
$parsec_host_name
$parsec_host_port

# Disable Microsoft Basic Display Adapter and friends
Start-Process -FilePath "C:\Program Files\Parsec\vigem\10\x64\devcon.exe" -ArgumentList '/r disable "HDAUDIO\FUNC_01&VEN_10DE&DEV_0083&SUBSYS_10DE11A3*"'
Get-PnpDevice | where {$_.friendlyname -like "Generic Non-PNP Monitor" -and $_.status -eq "OK"} | Disable-PnpDevice -confirm:$false
Get-PnpDevice | where {$_.friendlyname -like "Microsoft Basic Display Adapter" -and $_.status -eq "OK"} | Disable-PnpDevice -confirm:$false
Get-PnpDevice | where {$_.friendlyname -like "Google Graphics Array (GGA)" -and $_.status -eq "OK"} | Disable-PnpDevice -confirm:$false
Get-PnpDevice | where {$_.friendlyname -like "Microsoft Hyper-V Video" -and $_.status -eq "OK"} | Disable-PnpDevice -confirm:$false
Start-Process -FilePath "C:\Program Files\Parsec\vigem\10\x64\devcon.exe" -ArgumentList '/r disable "PCI\VEN_1013&DEV_00B8*"'
Start-Process -FilePath "C:\Program Files\Parsec\vigem\10\x64\devcon.exe" -ArgumentList '/r disable "PCI\VEN_1D0F&DEV_1111*"'
Start-Process -FilePath "C:\Program Files\Parsec\vigem\10\x64\devcon.exe" -ArgumentList '/r disable "PCI\VEN_1AE0&DEV_A002*"'

# SteamVR requires DirectX
choco install -y directx

# Attempt to kill second display
Start-Process -FilePath "displayswitch.exe" -ArgumentList "/internal" -Wait
