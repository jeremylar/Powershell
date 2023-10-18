Import-module ActiveDirectory
#add AD User
#CSV Format DisplayName, FirstName, LastName, UPN, Description, Title
$employee_list = Import-Csv -Path C:\Temp\userlist1.csv

foreach ($employee in $employee_list) {

    if (Get-ADUser -Identity $employee.UPN)
    {
        Write-Host($employee.UPN +" Exists in AD, skipping account creation")
    }
    else{
        
        try {
            $Password = "Password1234!"
            $OU = "OU=Faculty,OU=Users,OU=USERS,DC=DOMAIN,DC=com"
            #Convert the password to secure string.
            $NewPwd = ConvertTo-SecureString $Password -AsPlainText -Force
            New-ADUser -Name $employee.DisplayName -GivenName $employee.FirstName -SurName $employee.LastName -SamAccountName $employee.UPN -Description $employee.Description -Enabled $True -ADAccountPassword $Password -UserPrincipalName $employee.UPN -Title $employee.Title
            $Account = Get-ADUser -Identity $employee.UPN;
            $objectguid = $Account.objectguid
            # 2b. Dynamically declare their home directory path in a String
            Move-ADObject -Identity $objectguid -TargetPath $OU
            Set-ADUser -Identity $employee.UPN -PasswordNeverExpires:$FALSE
            Set-ADAccountPassword $employee.UPN -NewPassword $NewPwd -Reset
            Write-Host("Created user with name: "+ $employee.UPN)
        }
        catch {
            Write-Host("Failed to Update user" + $employee.UPN)
        }
    }
}    