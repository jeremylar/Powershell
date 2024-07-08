Connect-MgGraph -Scopes "User.Read.All", "Group.ReadWrite.All"
$userlistarray=@()
$userlist = Get-ADUser -Filter * -Property Enabled | Where {$_.Enabled -like "False"}
$i=0
foreach($user in $userlist)
{
if ($user -ne $null)
{
$i+=1
Write-Host($i)
Write-host($user.UserPrincipalName)
#Get-Mailbox -Identity $user.UserPrincipalName | Select-Object UserPrincipalName,RecipientTypeDetails,ForwardingAddress 
$userlistarray += [pscustomobject]@(Get-Mailbox -Identity $user.UserPrincipalName | Select-Object UserPrincipalName,AccountDisabled,RecipientTypeDetails,ForwardingAddress)
}
else {write-host($user.Name+ " No UserPrincipalName")}
}
$userlistarray | Export-CSV C:\scripts\userlistarray2.csv








foreach ($user in $userlist){
Update-MgUser -UserId $user -UsageLocation US
Set-MGUserLicense -UserID $user -AddLicenses $addLicenses -RemoveLicenses @()
}
