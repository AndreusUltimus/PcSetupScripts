# Set up page files.
$pagefile = Get-WmiObject Win32_ComputerSystem -EnableAllPrivileges
$pagefile.AutomaticManagedPagefile = $false
$pagefile.put() | Out-Null

$pagefileset = Get-WmiObject Win32_pagefilesetting
$pagefileset.InitialSize = 512
$pagefileset.MaximumSize = 512
$pagefileset.Put() | Out-Null


Set-WmiInstance -Class Win32_PageFileSetting -Arguments @{ name="A:\pagefile.sys"; InitialSize = 1024; MaximumSize = 32768} -EnableAllPrivileges | Out-Null

