$data = @('list of AD Usernames')
foreach ($user in $data)
{
set-aduser $user -HomeDirectory $null -HomeDrive $null
Get-ADUser $user -Properties  HomeDirectory, HomeDrive | Select SamAccountName, HomeDirectory, HomeDrive
}
