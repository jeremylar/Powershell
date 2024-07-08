$users = @("<userlist>")




foreach($user in $users)
{
	$CurHomeDirectory = (Get-Aduser -Identity $user -Properties HomeDirectory | Select HomeDirectory).HomeDirectory
	$newHomeDirectory = "\\newhomedrivedirectory\"+$user
	
	robocopy $CurHomeDirectory $newHomeDirectory /E /COPYALL /DCOPY:DAT /R:100 /W:3 /LOG:C:\temp\robocopy\$user.txt
	
	$curhomesize = Get-ChildItem -Path $CurHomeDirectory | Measure-Object -Property Length -Sum
	$newhomesize = Get-ChildItem -Path $newHomeDirectory | Measure-Object -Property Length -Sum

	
	if(test-path -path $newHomeDirectory)
	{
   #remove old directory and items
		Remove-Item -Path $CurHomeDirectory -Recurse
		set-aduser -identity $user -HomeDirectory $newHomeDirectory
	}

	Write-Host("Changed: "+$user)

}
