# paths
$GpRoot = "${env:SystemRoot}\System32\GroupPolicy"
$StartupScriptsDir = Join-Path $GpRoot "Machine\Scripts\Startup"
$LogonScriptsDir = Join-Path $GpRoot "User\Scripts\Logon"

# Force the policy directory to exist.
New-Item -ItemType Directory -Path $GpRoot -Force

# Enable scripts
$gpt_ini = "
[General]
gPCUserExtensionNames=[{42B5FAAE-6536-11D2-AE5A-0000F87571E3}{40B66650-4972-11D1-A7CA-0000F87571E3}]
Version=131075
gPCMachineExtensionNames=[{42B5FAAE-6536-11D2-AE5A-0000F87571E3}{40B6664F-4972-11D1-A7CA-0000F87571E3}]
"
$GpIni = Join-Path $GpRoot "gpt.ini"
Set-Content $GpIni -Value $gpt_ini -Encoding ascii -Force

# startup script
New-Item -ItemType Directory -Path $StartupScriptsDir -Force
$src = Join-Path $script_dir "NimbusStartup.ps1"
$tgt = Join-Path $StartupScriptsDir "NimbusStartup.ps1"
Copy-Item $src $tgt
$machine_psscripts_ini="
[Startup]
0CmdLine=NimbusStartup.ps1
0Parameters=
"
$machineScriptsPath = Join-Path $GpRoot "Machine\Scripts\psscripts.ini"
Set-Content $machineScriptsPath -Value $machine_psscripts_ini -Encoding Unicode -Force

# Logon script
New-Item -ItemType Directory -Path $LogonScriptsDir -Force
$src = Join-Path $script_dir "NimbusLogon.ps1"
$tgt = Join-Path $LogonScriptsDir "NimbusLogon.ps1"
Copy-Item $src $tgt
$usr_psscripts_ini="
[Logon]
0CmdLine=NimbusLogon.ps1
0Parameters=
"
$userScriptsPath = Join-Path $GpRoot "User\Scripts\psscripts.ini"
Set-Content $userScriptsPath -Value $usr_psscripts_ini -Encoding Unicode -Force


# generating registry keys
gpupdate


# Configure auto logon
# https://docs.microsoft.com/en-us/troubleshoot/windows-server/user-profiles-and-logon/turn-on-automatic-logon
Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -name DefaultUserName -value $username -force | Out-Null
Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -name DefaultPassword -value $password -force | Out-Null
Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -name AutoAdminLogon -value 1 -force | Out-Null
