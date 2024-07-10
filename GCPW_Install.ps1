try{	
New-Item -Path "HKLM:\Software\Google" -Name "GCPW" -Force
		New-ItemProperty -Path "HKLM:\Software\Google\GCPW" -Name "domains_allowed_to_login" -PropertyType String -Value 'domain.com' -Force	
New-Item -Path "HKLM:\Software\Policies\Google" -Name "Chrome" -Force
		New-ItemProperty -Path "HKLM:\Software\Policies\Google\Chrome" -Name 'CloudManagementEnrollmentToken' -PropertyType String -Value '87c2d086-fd76-4cc7-9a6b-f28d237e514c' -Force
}
catch{"Failed at adding Registry Entries: " + $_ }
try{	invoke-webrequest -URI "https://dl.google.com/credentialprovider/gcpwstandaloneenterprise64.msi" -Outfile "C:\Windows\Temp\gcpwstandaloneenterprise64.msi"}
catch{"Failed at downloading GCPW: " + $_ }
try{    msiexec /i C:\Windows\Temp\gcpwstandaloneenterprise64.msi /qn /norestart}
catch{"Failed at Installing GCPW: " + $_ }
