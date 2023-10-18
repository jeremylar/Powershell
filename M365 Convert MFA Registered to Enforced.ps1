#Convert MFA Enabled and Registered to Enforced

Connect-MsolService

$Requirements = @()
$Requirement = [Microsoft.Online.Administration.StrongAuthenticationRequirement]::new()
$Requirement.RelyingParty = "*"
$Requirement.State = "Enforced"
$Requirements += $Requirement
$Totalenabled = 0
$MsolUsers = Get-MsolUser -EnabledFilter EnabledOnly -MaxResults 10000 | Where-Object {$_.IsLicensed -eq $true} | Sort-Object UserPrincipalName
    foreach ($MsolUser in $MsolUsers) {
        if ($MsolUser.StrongAuthenticationMethods -and !($MsolUser.StrongAuthenticationRequirements))
        { 
            $Totalenabled++
            Set-MsolUser -UserPrincipalName $MsolUser.UserPrincipalName -StrongAuthenticationRequirements $Requirements
            Write-Host $MsolUser.UserPrincipalName " Enforced MFA"
        }
        If ($MsolUser.StrongAuthenticationMethods -and ($MsolUser.StrongAuthenticationRequirements.State -eq "Enabled" ))
        {  $Totalenabled++
            Set-MsolUser -UserPrincipalName $MsolUser.UserPrincipalName -StrongAuthenticationRequirements $Requirements
            Write-Host $MsolUser.UserPrincipalName " Enforced MFA"
        }
    }
Write-Host "Enforced: " $Totalenabled