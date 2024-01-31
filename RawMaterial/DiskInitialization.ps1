# TODO: This needs some guards and checks to see if there actually are unitialized disks that SHOULD be initialized

# Iinitialize scratch space
$disk = Get-Disk | where-object PartitionStyle -eq "RAW"  
Initialize-Disk -Number $disk.Number -PartitionStyle MBR -confirm:$false  
New-Partition -DiskNumber $disk.Number -UseMaximumSize -IsActive | 
  Format-Volume -FileSystem NTFS -NewFileSystemLabel "scratch" -confirm:$False  
Set-Partition -DiskNumber $disk.Number -PartitionNumber 1 -NewDriveLetter "A"

Start-Sleep -Seconds 5