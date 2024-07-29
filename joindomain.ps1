#Created by Jeremy Larson July 2024
$domain = "domain.org" 
$username = "domain\administrator" # User name with privileges to add a device to the $domain 
$password = "password" | ConvertTo-SecureString -AsPlainText -Force # Password for the above user 

$credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList ($username, $password) 
Add-Computer -DomainName $domain -Credential $credential -Restart -Force 
