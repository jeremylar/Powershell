powershell -command "Invoke-WebRequest -Uri https://<url>/WiFi-Staff.xml -Outfile C:\Windows\TEMP\WiFi-Staff.xml"
netsh wlan add profile filename="C:\Windows\TEMP\WiFi-Staff.xml"
#netsh wlan show profile
netsh wlan delete profile name=OldSSID
del C:\Windows\TEMP\WiFi-Staff.xml
