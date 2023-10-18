#Convert MFA Accounts to Disabled

Connect-MsolService

$Requirements = @()
$Totalenabled = 0
$MsolUsers = Get-MsolUser -EnabledFilter EnabledOnly -MaxResults 10000 | Where-Object {$_.IsLicensed -eq $true} | Sort-Object UserPrincipalName
    foreach ($MsolUser in $MsolUsers) {
        
        If (($MsolUser.StrongAuthenticationRequirements))
        {  $Totalenabled++
            Set-MsolUser -UserPrincipalName $MsolUser.UserPrincipalName -StrongAuthenticationRequirements $Requirements
            Write-Host $MsolUser.UserPrincipalName " Disabled MFA"
        }
    }
Write-Host "Enforced: " $Totalenabled