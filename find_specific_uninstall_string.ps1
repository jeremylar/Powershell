#Description: Checks for software and installs if not existing.
#Written by Jeremy Larson 1-2023
#Software Name
$software = "@SoftwareName@"
#Check if Installed
$installed32 = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* 
$installed64 = (Get-ItemProperty HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Where { $_.DisplayName -Like $software }) -ne $null
#Check if installed
If((-Not $installed32) -and (-Not $installed64)) {
	#Install Software
	Write-Host "'$software' is not Installed";
}
Else{
	
	Write-Host "Software is Installed";
	
	
foreach ($line32 in $installed32)
{
Write-Host("App Name : "+$line32.DisplayName)
Write-Host("UninstallString : "+$line32.UninstallString)
Write-Host("QUninstallString : "+$line32.QuietUninstallString)
Write-Host("-------------------------------")
}
foreach ($line64 in $installed64)
{
Write-Host("App Name : "+$line64.DisplayName)
Write-Host("UninstallString : "+$line64.UninstallString)
Write-Host("QUninstallString : "+$line64.QuietUninstallString)
Write-Host("-------------------------------")
}
