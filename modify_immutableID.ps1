$upn = "scott@domain.com"
$fqdnupn = "scott@domain.onmicrosoft.com"
# Changing it to a "onmicrosoft" UPN
set-MsolUserPrincipalName -UserPrincipalName $upn -NewUserPrincipalName $fqdnupn
# Setting a new Immutable ID from on-prem AD
set-MsolUser -UserPrincipalName $fqdnupn -ImmutableId "fF/TaQsiu0e7bTwHL3ZTRg=="
# Check that the change was applied
get-msoluser -UserPrincipalName $fqdnupn | select *immutableid*
# Changing it back to the original UPN
set-MsolUserPrincipalName -UserPrincipalName $fqdnupn -NewUserPrincipalName $upn
# Checking that the UPN is now correct and the correct ImmutableID is applied
get-msoluser -UserPrincipalName $upn | select *immutableid*
