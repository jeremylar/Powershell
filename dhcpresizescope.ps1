Export-DhcpServer -Computername "serverfqdn" -File "C:\temp\dhcpexport.xml" -ScopeId 10.1.20.0 -Leases
Remove-DhcpServerv4Scope -Computername "serverfqdn" -ScopeId 10.1.20.0 -Force
#Modify the C:\temp\dhcpexport.xml with a text editor with new scope size and save
Import-DhcpServer -Computername "serverfqdn" -File "C:\temp\dhcpimport.xml" -ScopeId 10.1.16.0 -BackupPath "C:\temp\" -Leases
