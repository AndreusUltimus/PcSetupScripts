$working_dir = "C:\PcSetupScripts"
if (-not (Test-Path $working_dir)) {
    New-Item -ItemType Directory $working_dir
}

# Install most recent version of winget
#  1.6.3482, as of 2023-01-30
(New-Object System.Net.WebClient).DownloadFile("https://github.com/microsoft/winget-cli/releases/download/v1.6.3482/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle", "$working_dir\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle")
Add-AppxPackage -Path "$working_dir\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"

winget install -e -i 9N0DX20HK701 --source=msstore --accept-package-agreements --accept-source-agreements
