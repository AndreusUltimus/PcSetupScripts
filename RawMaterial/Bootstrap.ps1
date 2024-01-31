
# TODO: Double check these find-replaces:

# Modified from https://github.com/parsec-cloud/Parsec-Cloud-Preparation-Tool/blob/master/Loader.ps1
Unblock-File -Path .\*
Get-ChildItem -Path $path\NimbusTemp -Recurse | Unblock-File
start-process powershell.exe -verb RunAS -argument "-file $path\InstancePrep.ps1"
