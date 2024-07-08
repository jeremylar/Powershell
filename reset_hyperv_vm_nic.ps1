#Written by Jeremy Larson for Nov 2023
#Set Variables
$Folder = 'C:\scripts'
$pathscript = 'C:\scripts\ResetNic.ps1'

#Define Functions 
Function setschedule {
$taskTrigger = New-ScheduledTaskTrigger -Daily -At 3am
$taskAction = New-ScheduledTaskAction -Execute "PowerShell" -Argument "-NoProfile -ExecutionPolicy Bypass -File 'C:\scripts\ResetNic.ps1' -Output 'HTML'" -WorkingDirectory 'c:\scripts'
Register-ScheduledTask 'ResetNic' -Action $taskAction -Trigger $taskTrigger
$adapter=(get-netadapter | Where-Object -Property InterfaceDescription -eq -Value 'Microsoft Hyper-V Network Adapter').Name
"if ($PSVersionTable.PSVersion.Major -eq 5){$testconnection5=Test-Connection -ComputerName www.google.com;if (-NOT $testconnection5){Restart-NetAdapter -Name $adapter;if (-Not [System.Diagnostics.EventLog]::SourceExists('ResetNic')){New-EventLog -LogName System -Source 'ResetNic'}; Write-EventLog -LogName 'System' -Source 'ResetNic' -EventID 9999 -EntryType Information -Message 'Successfully Reset Hyper-V NIC'}}else{$testconnection7=Test-Connection -TargetName www.google.com;if (-NOT $testconnection7){Restart-NetAdapter -Name $adapter;if (-Not [System.Diagnostics.EventLog]::SourceExists('MSP-ResetNic')){New-EventLog -LogName System -Source 'MSP-ResetNic'}; Write-EventLog -LogName 'System' -Source 'MSP-ResetNic' -EventID 9999 -EntryType Information -Message 'Successfully Reset Hyper-V NIC'}}" | Out-File -FilePath C:\scripts\ResetNic.ps1
if (-Not [System.Diagnostics.EventLog]::SourceExists('ResetNic')){New-EventLog -LogName System -Source 'ResetNic'}; Write-EventLog -LogName 'System' -Source 'ResetNic' -EventID 9999 -EntryType Information -Message 'Successfully Reset Hyper-V NIC'
}
 
 
if (Test-Path -Path $Folder) {
	#Folder exists, check for file
	if(Test-Path -Path $pathscript){
		Remove-Item -Path $pathscript -Force
		
	}
	else{setschedule}
} else {
    #Path doesn't exist
	New-Item -Path "C:\" -Name "scripts" -ItemType "directory"
	setschedule
}

if (-Not [System.Diagnostics.EventLog]::SourceExists("ResetNic")){New-EventLog -LogName System -Source "ResetNic"}

if ($PSVersionTable.PSVersion.Major -eq 5){$testconnection5=Test-Connection -ComputerName www.google.com;if (-NOT $testconnection5){Restart-NetAdapter -Name $adapter}}else{$testconnection7=Test-Connection -TargetName www.google.com;if (-NOT $testconnection7){Restart-NetAdapter -Name $adapter}}
