#tested on FSLogix Version 2.9.8612.60056
#Created by Jeremy Larson 5/9/2024
#tested Run on RDS server while logged in as domain admin
$username="msptest1"
$domainname="domain.local"
$tenantid = "azuretenantid"
$vhdsize=300000
$profileshare="\\domain\FSLogix"
#$SID=(get-aduser -identity $username).sid.value
$SID=(Get-WmiObject -query "select SID from win32_useraccount where Name='$username'").SID
$foldername=$profileshare+"\"+$SID+"_"+$username
$vhdname="Profile_"+$username+".vhdx"
$fullpath=$foldername+"\"+$vhdname
$frxpath="C:\Program Files\FSLogix\Apps\frx.exe"
$domainusername=$domainname+"\"+$username



#Create Folder    \\domain\share\USERSID_username
mkdir $foldername -erroraction silentlycontinue |out-null

#Assign user as owner of folder and subitems

# Set Folder Owner
$usracct=New-Object -TypeName System.Security.Principal.NTAccount -ArgumentList $domainusername
$fldacl=get-acl $foldername
$fldacl.setowner($usracct)
set-acl -path $foldername -aclobject $fldacl

#Check Task Manager and disconnect user account if moving profile on RDS Server Get-RDUserSession
#Copy local profile to VHDX in folder as Profile_username.vhdx
$Arguments  = "copy-profile -filename $fullpath -sid $SID -dynamic 1 -verbose -size-mbs=$vhdsize 2>&1 | out-null"
Start-Process $frxpath -Argument $Arguments


#give domain user full permissions on vhdx
$vhdacl=get-acl $fullpath
$vhdacl.setowner($usracct)
$aclrights="FullControl"
$acltype="Allow"
$aclarglist=$usracct, $aclrights, $acltype
$aclrule = New-Object -TypeName System.Security.AccessControl.FileSystemAccessRule -ArgumentList $aclarglist
$vhdacl.SetAccessRule($aclrule)
set-acl -path $fullpath -aclobject $vhdacl

#Add User to FSLogix AD Group as long as FSLogix AD group is a member of FSLogix Profile Include List
#have user login and verify that fslogixapps are working.
#Also verify that folder/file redirection is working for desktop/documents.  If possible use onedrive https://learn.microsoft.com/en-us/sharepoint/use-group-policy#prompt-users-to-move-windows-known-folders-to-onedrive


#Prompt users to move Windows known folders to OneDrive
#[HKLM\SOFTWARE\Policies\Microsoft\OneDrive]"KFMOptInWithWizard"="azuretenantid"
#Silently move Windows known folders to OneDrive
#[HKLM\SOFTWARE\Policies\Microsoft\OneDrive]"KFMSilentOptIn"="1111-2222-3333-4444"
#where "1111-2222-3333-4444" is a string value representing the tenant ID.
#[HKLM\SOFTWARE\Policies\Microsoft\OneDrive]"KFMSilentOptInWithNotification"=dword:00000001

#[HKLM\SOFTWARE\Policies\Microsoft\OneDrive]"FilesOnDemandEnabled"=dword:00000001

#Meet Windows and OneDrive sync app requirements and still can't see OneDrive Files On-Demand option available at "Settings"? Ensure the service "Windows Cloud Files Filter Driver" start type is set to 2 (AUTO_START). Enabling this feature sets the following registry key value to 2:

#[HKLM\SYSTEM\CurrentControlSet\Services\CldFlt]"Start"=dword:00000002
#New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\OneDrive'
#New-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\OneDrive' -Name KFMOptInWithWizard -Value $tenantid -PropertyType DWORD -Force
#New-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\OneDrive' -Name KFMSilentOptIn -Value $tenantid -PropertyType DWORD -Force
#New-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\OneDrive' -Name FilesOnDemandEnabled -Value "00000001" -PropertyType DWORD -Force
#New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\CldFlt' -Name Start -Value "00000002" -PropertyType DWORD -Force
