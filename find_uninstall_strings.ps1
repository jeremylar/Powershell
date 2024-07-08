Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName,UninstallString | Format-Table
Get-ItemProperty HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName,UninstallString | Format-Table
$32bit =  Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* 
$64bit = Get-ItemProperty HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* 

foreach ($line32 in $32bit)
{
Write-Host("App Name : "+$line32.DisplayName)
Write-Host("UninstallString : "+$line32.UninstallString)
Write-Host("QUninstallString : "+$line32.QuietUninstallString)
Write-Host("-------------------------------")
}
foreach ($line64 in $64bit)
{
Write-Host("App Name : "+$line64.DisplayName)
Write-Host("UninstallString : "+$line64.UninstallString)
Write-Host("QUninstallString : "+$line64.QuietUninstallString)
Write-Host("-------------------------------")
}
