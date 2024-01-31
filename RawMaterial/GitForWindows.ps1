
$working_dir = "C:\PcSetupScripts"
$installer = "Git-2.43.0-64-bit.exe"
$url = "https://github.com/git-for-windows/git/releases/download/v2.43.0.windows.1/$installer"
$installer = "$working_dir\$installer"
(New-Object System.Net.WebClient).DownloadFile($url,$installer)
$config = @"
[Setup]
Lang=default
Dir=C:\Program Files\Git
Group=Git
NoIcons=0
SetupType=default
Components=gitlfs,scalar
Tasks=
EditorOption=VisualStudioCode
CustomEditorPath=
DefaultBranchOption= 
PathOption=Cmd
SSHOption=ExternalOpenSSH
TortoiseOption=false
CURLOption=WinSSL
CRLFOption=CRLFAlways
BashTerminalOption=ConHost
GitPullBehaviorOption=Merge
UseCredentialManager=Disabled
PerformanceTweaksFSCache=Enabled
EnableSymlinks=Disabled
EnablePseudoConsoleSupport=Disabled
EnableFSMonitor=Enabled
"@
$cfg_file = "$working_dir\git_options.ini"
Set-Content -Path $cfg_file $config

&$installer /VERYSILENT /NORESTART /NOCANCEL /LOADINF=git_options.ini

