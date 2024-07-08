get-printer | foreach{
$tempname = $_.DriverName.ToLower()
if($tempname -like "*lexmark*"){write-host($_.Name)
Remove-Printer -name $_.Name}  
}

Get-Printer
Get-Printer | Select-Object Name,Type,ShareName,PortName,DriverName,Location,PrinterStatus | ConvertTo-Json | ConvertFrom-Json
Get-ChildItem Registry::\HKEY_Users | Where-Object { $_.PSChildName -NotMatch ".DEFAULT|S-1-5-18|S-1-5-19|S-1-5-20|_Classes" } | Select-Object -ExpandProperty PSChildName | ForEach-Object { Get-ChildItem Registry::\HKEY_Users\$_\Printers\Connections -Recurse | Where-Object {$_.Name -Like "*lexmark*"}| Select-Object Name}

$printers = Get-Printer
foreach ($printer in $printers)
{if($printer.Name -notcontains "Microsoft"){
Write-Host("Name : "+$printer.Name)
Write-Host("Type : "+$printer.Type)
Write-Host("ShareName : "+$printer.ShareName)
Write-Host("PortName : "+$printer.PortName)
Write-Host("DriverName : "+$printer.DriverName)
Write-Host("Location : "+$printer.Location)
Write-Host("PrinterStatus : "+$printer.PrinterStatus)
}
}



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
 
# Define the printers to Remove in an array
$printersToRemove = @("FL-RicohMPC6003-StaffDev","FL-RicohMPC6004-MainOffice","FL-RicohMPC4504-Fiscal","FL-RicohMPC4504-2ndFloor","FL-RicohMPC3504-StaffDev","FL-RicohMPC3004-Speech","FL-RicohMPC3004-Exec","FL-RicohMP3555-Intake","FL-RicohMP3555-Fiscal02","FL-RicohMP3555-Fiscal","FL-RicohMP3555-Clinic","BY-RicohMPC6004ex-MainOffice","BY-RicohMPC4504ex-CompLab","BY-RicohMP3555-RM234","BY-RicohMP3555-Clinic")

# Get all installed printers
$printers = Get-Printer | Select-Object -ExpandProperty Name

# Loop through each printer and remove if not in the list of printers to keep
foreach ($printer in $printers) {
    if ($printersToRemove -eq $printer) {
        Write-Host "Removing printer: $printer"
        Remove-Printer -Name $printer -ErrorAction SilentlyContinue
    }
}






# Delete printers by port
$printerports = @("192.168.50.13","192.168.50.11","192.168.50.9","192.168.50.4","192.168.50.10","192.168.50.2","192.168.50.3","192.168.50.17","192.168.50.8","192.168.50.6","192.168.52.2","192.168.2.22","192.168.2.28","192.168.2.20")

# Loop through each printer and remove if not in the list of printers to keep
foreach ($port in $printerports) {
		$printername = Get-Printer | Where {$_.PortName -eq $port } | Select-Object -ExpandProperty Name
        if($printername -ne $null){
			Write-Host "Removing printer: $printername"
			Remove-Printer -Name $printername -ErrorAction SilentlyContinue
		}
}


$printerports = @("192.168.2.22","192.168.2.28","192.168.2.20")

# Loop through each printer and remove if not in the list of printers to keep
foreach ($port in $printerports) {
		$printername = Get-Printer | Where {$_.PortName -eq $port } | Select-Object -ExpandProperty Name
        if($printername -ne $null){
			Write-Host "Removing printer: $printername"
			Remove-Printer -Name $printername -ErrorAction SilentlyContinue
		}
}

cmd /C "C:\Program Files\Ricoh\PMC Client\hcpclient.exe"

"HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Print\Providers\Client Side Rendering Print Provider\"S-1-5-21-796845957-1604221776-839522115-5836\Printers\Connections\,,by-app-prnsrv,BY-RicohMPC6004ex-MainOffice

Get-ChildItem "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Print\Providers\Client Side Rendering Print Provider\" |
foreach{
	(Get-ItemProperty $_.PSPath)

}
