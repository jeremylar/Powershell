Add-Computer -Domain "domain" -newname "newpcname"

Test-ComputerSecureChannel -verbose
Reset-ComputerMachinePassword -Server <name> -Credential <domain>\administrator
#Get Computer Installed Software name and uninstall string
Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName,UninstallString | Format-Table
Get-ItemProperty HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName,UninstallString | Format-Table

$url = "https"
$outputfilename = "outputfilename"
invoke-webrequest -uri $url -outfile "C:\Windows\Temp\"$outputfilename

Invoke-WebRequest -URI https://<url>/GoogleChromeStandaloneEnterprise64.msi -Outfile C:\Windows\Temp\GoogleChromeStandaloneEnterprise64.msi; msiexec.exe /i C:\Windows\Temp\GoogleChromeStandaloneEnterprise64.msi /q
Invoke-WebRequest -URI https://<url>/MicrosoftEdgeEnterpriseX64.msi -Outfile C:\Windows\Temp\MicrosoftEdgeEnterpriseX64.msi; msiexec.exe /i C:\Windows\Temp\MicrosoftEdgeEnterpriseX64.msi /q

powershell -Command "Invoke-WebRequest -Uri https://mspdb.mspnetworks.com/downloads/bglig/PrinterInstallerClient.msi -Outfile C:\Windows\Temp\PrinterInstallerClient.msi"
msiexec /i C:\Windows\Temp\PrinterInstallerClient.msi /qn HOMEURL=http://ndchs.printercloud.com AUTHORIZATION_CODE=b7x0bnrg

#https://stackoverflow.com/questions/12392928/sending-multiple-commands-with-psexec
psexec.exe \\computer -c C:\temp\runmultiplecmds.cmd

Get-Service -Name WinRM -ComputerName "Computer" | Start-Service
Invoke-Command -ComputerName <name> -ScriptBlock {Invoke-WebRequest -Uri https://<url>/agent_Install.MSI -Outfile C:\Windows\Temp\agent_Install.MSI}

Test-Path -Path C:\Windows\Temp\srpblockedge.reg

#Office365-x64 configuration and installation
Invoke-WebRequest -URI "https://<url>/configuration-Office365-x64.xml" -Outfile "C:\Windows\Temp\configuration-Office365-x64.xml"
Invoke-WebRequest -URI "https://<url>/setup.exe" -Outfile "C:\Windows\Temp\setup.exe"
C:\Windows\Temp\setup.exe /download C:\Windows\Temp\configuration-Office365-x64.xml
C:\Windows\Temp\setup.exe /configure C:\Windows\Temp\configuration-Office365-x64.xml

#Registry entry 
New-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\Installer' -Name AlwaysInstallElevated -Value 0 -PropertyType DWORD -Force
New-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Windows\Installer' -Name AlwaysInstallElevated -Value 0 -PropertyType DWORD -Force

powershell -Command "Invoke-WebRequest -URI http://anywhere.webrootcloudav.com/zerol/wsasme.msi -Outfile C:\Windows\Temp\wsasme.msi"
msiexec /uninstall C:\Windows\Temp\wsasme.msi /qn


#Download, extract and run
Invoke-WebRequest -URI  'https://s3.amazonaws.com/assets-cp/assets/Agent_Uninstaller.zip' -Outfile 'C:\Windows\Temp\Agent_Uninstaller.zip'
Expand-Archive -LiteralPath 'C:\Windows\Temp\Agent_Uninstaller.zip' -DestinationPath 'C:\Windows\Temp\Agent_Uninstaller'
C:\Windows\Temp\Agent_Uninstaller\Agent_Uninstall.exe


#Printer Ports
Get-Printer
Add-PrinterPort -Name "10.1.1.10" -PrinterHostAddress "10.1.1.10"
Add-PrinterPort -Name "10.1.1.10_1" -PrinterHostAddress "10.1.1.10"
Set-Printer -Name "Canon Generic Plus UFR II" -PortName "10.1.1.10_1"
Set-Printer -Name "iR-ADV C3525" -PortName "10.1.1.10"
Set-Printer -Name "Canon C3826" -PortName "10.1.1.10_1"
Set-Printer -Name "Canon IR-ADV C3525" -PortName "10.1.1.10"


#Find Files
get-childitem -Path "E:\HomeDrives\JF" -recurse -force | where-object {$_.Name.StartsWith("~$")} | Select-Object FullName | Format-List

#change file names that start with leading empty space
get-childitem -Path "E:\HomeDrives\JF" -recurse -force | where-object {$_.Name.StartsWith(" ")} | rename-item -newname {"RN-"+[string]($_.name).Trim()}

#Remove Files
get-childitem -Path "E:\NYCA_Data\Shares\Shared2\Susan Files" -recurse -force | where-object {$_.Name.StartsWith("~$")} | Remove-Item -Force
get-childitem -Path "C:\Windows\Temp" -recurse -force | Remove-Item -Force
Remove-Item c:\Windows\Temp\* -Recurse -Force
FileName size is greater than 256
get-childitem -Path "E:\HomeDrives\JF" -recurse -force | where-object {$_.FullName.Length -ge 256} | Select-Object FullName | FORMAT-LIST

#Remove File with Size 0 bytes
get-childitem -Path "E:\HomeDrives\JF" -recurse -force | where{$_.Length -eq 0} | Remove-Item -Force

Get-ChildItem | Where-Object Name -Like '*`[*' | ForEach-Object { Remove-Item -LiteralPath $_.Name }


Set-Service -Name "ScreenConnect Client (b89a594aee64dc)" -StartupType Disabled -Status Stopped​
Set-Service -Name "ScreenConnect Client (7fcabefea4a1ac)" -StartupType Disabled -Status Stopped​
Stop-Service -Name "ScreenConnect Client (b89a594aee64dc)"
Stop-Service -Name "ScreenConnect Client (7fcabefea4a1ac)"
Restart-Service -Name "ScreenConnect Client (7fcabefea4a1ac)"

#Services
Set-Service -Name "ScreenConnect Client (b89a594aee64dc84)" -StartupType Disabled -Status Stopped​
Set-Service -Name "ScreenConnect Client (7fcabefea4a1ace5)" -StartupType Disabled -Status Stopped​
Stop-Service -Name "ScreenConnect Client (b89a594aee64dc84)"
Stop-Service -Name "ScreenConnect Client (7fcabefea4a1ace5)"
Restart-Service -Name "ScreenConnect Client (7fcabefea4a1ace5)"
Get-Service -Name "LTSVC" | Remove-Service

#check if file exists, if not and service exists
 If (Test-Path -Path "C:\Windows\LTSvc" -eq $False)
 {
Remove-Service -Name "MSPNetworks Monitoring Service" -Confirm:$false
}


#Return single item from ps command
Get-AzADGroup -DisplayName "developers"  | Select -ExpandProperty Id
(Get-AzADGroup -DisplayName "developers").Id

#TLS issues when invoke-webrequest has ssl issue
[Net.ServicePointManager]::SecurityProtocol = "Tls, Tls11, Tls12"
Invoke-WebRequest -Uri https://agents.static.liongard.com/LiongardAgent-lts.msi -OutFile "C:\Windows\Temp\LiongardAgent-lts.msi"
msiexec /i "C:\Windows\Temp\LiongardAgent-lts.msi" /qn

sc config AppIDSvc start=auto
net start AppIDSvc
powershell -Command "Invoke-WebRequest -Uri https:/<url>/appblockedge.xml -Outfile C:\Windows\Temp\appblockedge.xml"


powershell -Command "Invoke-WebRequest -Uri https://<url>/srpblockedge.reg -Outfile C:\Windows\Temp\srpblockedge.reg"
reg import C:\Windows\Temp\srpblockedge.reg

#time
w32tm /config /update /manualpeerlist:"time.google.com time1.google.com time2.google.com" /syncfromflags:manual /reliable:yes
net stop w32time
net start w32time
w32tm /resync


Set-TimeZone -Id "Eastern Standard Time"

Reset-ComputerMachinePassword -Server SAIL-B-DC01 -Credential saildomain\administrator

Get-ADUser -Filter 'enabled -eq $true' -Properties ProfilePath, HomeDirectory, HomeDrive,LastLogonDate | Select Name, SamAccountName, ProfilePath, HomeDirectory, HomeDrive, LastLogonDate | Export-CSV -path C:\Temp\userlist.csv

IF(Get-ItemProperty HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Where {$_.DisplayName -eq "Smart Mirror App1"}){return $True}else{return $False}
IF(Get-ItemProperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\* | Where {$_.DisplayName -eq "Smart Mirror App1"}){return $True}else{return $False}

#Network/DNS
netsh interface ip show config
netsh interface ipv4 add dnnsservers "Ethernet" 192.168.5.5 index=1
netsh interface ipv4 add dnnsservers "Ethernet" 192.168.40.33 index=2
netsh wlan show interfaces

$adapter="Ethernet"
if ($PSVersionTable.PSVersion.Major -eq 5){$testconnection5=Test-Connection -ComputerName www.google.com;if (-NOT $testconnection5){Restart-NetAdapter -Name $adapter}}else{$testconnection7=Test-Connection -TargetName www.google.com;if (-NOT $testconnection7){Restart-NetAdapter -Name $adapter}}

#Change Immutable for gsuite federation
Set-MsolDirSyncEnabled -EnableDirSync $false
Set-MsolDirSyncEnabled -EnableDirSync $true
Set-MsolUserPrincipalName -UserPrincipalName "mhionas@hccs-nys.org" -NewUserPrincipalName "mhionas@hccsnysorg.onmicrosoft.com"
Set-MsolUser -UserPrincipalName eeleftheriadis@hccsnysorg.onmicrosoft.com -ImmutableId eeleftheriadis@hccs-nys.org
Set-MsolUserPrincipalName -UserPrincipalName "eeleftheriadis@hccsnysorg.onmicrosoft.com" -NewUserPrincipalName "eeleftheriadis@hccs-nys.org"
Get-MsolUser -UserPrincipalName eeleftheriadis@hccs-nys.org | Select ImmutableID


#Cisco Anyconnect
powershell -Command "Invoke-WebRequest -URI https://<url>/cisco-secure-client-win-5.0.01242-core-vpn-predeploy-k9.msi -Outfile C:\Windows\Temp\cisco-secure-client-win-5.0.01242-core-vpn-predeploy-k9.msi"
msiexec /i C:\Windows\Temp\cisco-secure-client-win-5.0.01242-core-vpn-predeploy-k9.msi /norestart /passive
powershell -Command "Invoke-WebRequest -URI https://<url>/Cisco/profile.xml -Outfile 'C:\ProgramData\Cisco\Cisco Secure Client\VPN\Profile\profile.xml'"
Enable-NetAdapter -InterfaceDescription "Cisco AnyConnect Virtual Miniport Adapter for Windows x64"
$interface = Get-NetAdapter | Where-Object {$_.InterfaceDescription -eq "Cisco AnyConnect Virtual Miniport Adapter for Windows x64"} | Select-Object InterfaceIndex
set-DnsClientServerAddress -InterfaceIndex $interface.InterfaceIndex -ServerAddresses ("192.168.20.9","192.168.35.9")
