get-printer | foreach{
$tempname = $_.DriverName.ToLower()
if($tempname -like "*lexmark*"){write-host($_.Name)
Remove-Printer -name $_.Name}  
}
Get-Printer

Get-ChildItem Registry::\HKEY_Users | Where-Object { $_.PSChildName -NotMatch ".DEFAULT|S-1-5-18|S-1-5-19|S-1-5-20|_Classes" } | Select-Object -ExpandProperty PSChildName | ForEach-Object { Get-ChildItem Registry::\HKEY_Users\$_\Printers\Connections -Recurse | Where-Object {$_.Name -Like "*lexmark*"}| Select-Object Name}


Get-ChildItem Registry::\HKEY_Users | Where-Object { $_.PSChildName -NotMatch ".DEFAULT|S-1-5-18|S-1-5-19|S-1-5-20|_Classes" } | Select-Object -ExpandProperty PSChildName | ForEach-Object { Get-ChildItem Registry::\HKEY_Users\$_\Printers\Connections -Recurse | Where-Object {$_.Name -Like "*lexmark*"}| Remove-Object}
Restart-Service -Name "Print Spooler"

Get-WMIObject Win32_Printer | where{$_.Network -eq 'true'} | foreach{$_.delete()}



 Get-WMIObject Win32_Printer -ComputerName $env:COMPUTERNAME
 
 $printers = pnputil /enum-devices /class "Printer"
 foreach($printer in $printers){Write-Host($printer."Device Description:")}
 
 
 
 pnputil /remove-device "SWD\PRINTENUM\{52019A55-70ED-45C6-A24F-253686AA7132}"
 
 \\VCS-DC-02\Lexmark 3rd 202
 
 
 
 Get-CimInstance -ClassName Win32_ComputerSystem | Select-Object -Property UserName
 
 
 [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Print\Providers\Client Side Rendering Print Provider]
"InactiveGuidPrinterAge"=dword:00000384
"ActiveGuidPrinterAge"=dword:00000384
"InactiveGuidPrinterTrim"=dword:00000384
"RemovePrintersAtLogoff"=dword:00000001



 rundll32 printui.dll,PrintUIEntry /gd /n "\\VCS-DC-02\Lexmark 3rd 202"
 
 
 
 $LoggedOnUser = (qwinsta /SERVER:$ComputerName) -replace '\s{2,22}', ',' | ConvertFrom-Csv | Where-Object {$_ -like "*Acti*"} | Select-Object -ExpandProperty UTILISATEUR
 
 
 "\\VCS-DC-02\Lexmark 3rd 202"
