# Credentials to the samba server
$User = "samba_user"
$PWord = ConvertTo-SecureString -String "YourPassword" -AsPlainText -Force
$cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord

# Mapped network drives
New-PSDrive -Persist -Name "X" -PSProvider "FileSystem" -Root "\\YourSambaPath" -Credential $cred

