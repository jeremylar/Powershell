#Convert MFA Disabled accounts to Enabled

Connect-MsolService

$Requirements = @()
$Requirement = [Microsoft.Online.Administration.StrongAuthenticationRequirement]::new()
$Requirement.RelyingParty = "*"
$Requirement.State = "Enabled"
$Requirements += $Requirement
$Totalenabled = 0
$MsolUsers = Get-MsolUser -EnabledFilter EnabledOnly -MaxResults 10000 | Where-Object {$_.IsLicensed -eq $true} | Sort-Object UserPrincipalName
    foreach ($MsolUser in $MsolUsers) {
        
        If (!($MsolUser.StrongAuthenticationRequirements))
        {  $Totalenabled++
            Set-MsolUser -UserPrincipalName $MsolUser.UserPrincipalName -StrongAuthenticationRequirements $Requirements
            Write-Host $MsolUser.UserPrincipalName " Enabled MFA"
        }
    }
Write-Host "Enforced: " $Totalenabled