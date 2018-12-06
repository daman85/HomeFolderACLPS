param ( [Parameter(Mandatory=$false,ValueFromPipeline=$true)] [String]$Path )


function Get-PathPermissions {
 

 
  
    begin {
    
    $containers = Get-ChildItem $Path | ? {$_.psIscontainer} | Select-Object FullName, Name
    foreach ($container in $containers){
    Write-host $container.fullname
	write-host $container.Name

	$HomeFolderACL=GET-ACL $container.fullname
	$IdentityReference= "<Domain>\" + $container.Name
	write-host $IdentityReference
	$InheritanceFlags=[System.Security.AccessControl.InheritanceFlags]”ContainerInherit, ObjectInherit”
	$FileSystemAccessRights=[System.Security.AccessControl.FileSystemRights]”FullControl”
	$PropagationFlags=[System.Security.AccessControl.PropagationFlags]”None”
	$AccessControl=[System.Security.AccessControl.AccessControlType]”Allow”
	$AccessRule=NEW-OBJECT System.Security.AccessControl.FileSystemAccessRule ($IdentityReference, ”FullControl”, "3", ”None”, ”Allow”)
	$HomeFolderACL.AddAccessRule($AccessRule)
	
        }
    }
}
Get-PathPermissions $args[0]