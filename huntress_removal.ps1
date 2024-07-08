net stop -Name HuntressAgent
Stop-Service -Name HuntressUpdater
"C:\Program Files\Huntress\HuntressAgent.exe" uninstall
"C:\Program Files\Huntress\HuntressUpdater.exe" uninstall

rmdir "c:\Program Files\Huntress" /q /s
echo "Please wait 10 seconds and press any key"
pause
reg delete "HKLM\SOFTWARE\Huntress Labs" /f
