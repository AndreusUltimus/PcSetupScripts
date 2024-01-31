# Install choocolatey.
#   from https://chocolatey.org/install
#   2023-01-30
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))


$choco_installs = @(
#choose a browser
    # "googlechrome",
    "brave",

    "7zip",
    "vcredist-all",
    "googledrive"

    "vscode",
    "git",

    "steam",

    # just keeps the commas nice
    ""
)


foreach ($prog in $choco_installs) {
    if ($prog) {
        choco install $prog -y
    }
}
