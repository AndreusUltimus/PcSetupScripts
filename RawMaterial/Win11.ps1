

# New Windows 11 crap

# Disable the new context menu
$key = "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32"
New-Item $key -Force | Out-Null
Set-ItemProperty $key -Name '(Default)' -Value $Null | Out-Null


$key = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\"
# Set taskbar to left-aligned
Set-ItemProperty $key -Name 'TaskbarAl' -Value 0 -Force
# Unpin chat button
Set-ItemProperty $key -Name 'TaskbarMn' -Value 0 -Force
# Unping widgets
Set-ItemProperty $key -Name 'TaskbarDa' -Value 0 -Force
# Unping task view
Set-ItemProperty $key -Name 'ShowTaskViewButton' -Value 0 -Force
# Unpin search button (the windows button is still there!!)
Set-ItemProperty $key -Name "SearchboxTaskbarMode" -Value 0 -Force

$key = "HKCU:\Software\Policies\Microsoft\Windows\Explorer"
New-Item $key -Force | Out-Null
# Unpin the M$ Store
Set-ItemProperty $key -Name 'NoPinningStoreToTaskbar' -Value 1 -Force

# DISABLE FREAKING SEARCH RESULTS
Set-ItemProperty $key -Name 'DisableSearchBoxSuggestions' -Value 1 -Force


