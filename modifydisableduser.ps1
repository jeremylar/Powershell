#$userlistarray=@()
$userlist = Get-ADUser -Filter * -Property Enabled | Where {$_.Enabled -like "False"}
$i=0
foreach($user in $userlist)
{

$ADUser = Get-ADUser -Identity $user
$UPN = $ADUser.UserPrincipalName
$GUID = $ADUser.objectGUID

write-host($UPN)

#Remove AD User Group Memberships
Get-AdPrincipalGroupMembership -Identity $GUID | Where-Object -Property Name -Ne -Value 'Domain Users' | Remove-AdGroupMember -Members $GUID -Confirm:$False

#AD Hide from gal
Set-ADUser -identity $GUID -Replace @{msExchHideFromAddressLists=$true}

}
