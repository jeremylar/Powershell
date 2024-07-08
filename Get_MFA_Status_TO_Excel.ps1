#Create Excel Object
$excel = New-Object -ComObject Excel.Application 

# make excel visible 
    $excel.visible = $true 

# add a new blank worksheet 
    $workbook = $excel.Workbooks.add() 


#Set Enforced Sheet
$s1 = $workbook.sheets | where {$_.name -eq "Sheet1"}
$s1.name = 'Enforced'
$enforcednames = Get-MsolUser -All | Where-Object {$_.StrongAuthenticationRequirements.State -eq "Enforced" -and $_.BlockCredential -eq $False -and $_.isLicensed -eq $True } | Select -ExpandProperty "UserPrincipalName"
for($i=1;$i -lt $enforcednames.length;$i++)
{
    $s1.Range("A$i").Value=$enforcednames[$i-1]
}

#Set Enabled Sheet
$s2 = $workbook.Sheets.add() 
$s2.name = 'Enabled'
$enablednames = Get-MsolUser -All | Where-Object {$_.StrongAuthenticationRequirements.State -eq "Enabled" -and $_.BlockCredential -eq $False-and $_.isLicensed -eq $True } | Select -ExpandProperty "UserPrincipalName"
for($j=1;$j -lt $enablednames.length;$j++)
{
    $s2.Range("A$j").Value=$enablednames[$j-1]
}
#Set Disabled Sheet
$s3 = $workbook.Sheets.add() 
$s3.name = 'Disabled'
$disablednames = Get-MsolUser -All | Where-Object {$_.StrongAuthenticationRequirements.State -eq $null -and $_.BlockCredential -eq $False -and $_.isLicensed -eq $True } | Select -ExpandProperty "UserPrincipalName"
for($k=1;$k -lt $disablednames.length;$k++)
{
    $s3.Range("A$k").Value=$disablednames[$k-1]
}
$companyname = Get-Msoldomain | Where-Object { $_.IsDefault -eq "true"} | Select -ExpandProperty "Name"
$Today = Get-Date -Format "MMddyyyy"
#Saving File 
    "`n" 
    write-Host -for Yellow "Saved file in $env:userprofile\desktop" 
    $workbook.SaveAs("$env:userprofile\desktop\$companyname-$Today.xlsx")

#End Session
Get-PSSession | Remove-PSSession
