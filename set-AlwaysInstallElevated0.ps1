New-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\Installer' -Name AlwaysInstallElevated -Value 0 -PropertyType DWORD -Force
