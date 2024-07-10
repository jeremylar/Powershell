$programname = 'Brave'
Get-Process -Name $programname -ErrorAction SilentlyContinue | Stop-Process -Force
$profiles = Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\*' | Select -ExpandProperty PSChildName
foreach($Item in $profiles)
{
$32x = Get-ItemProperty registry::HKEY_USERS\$($Item)\Software\Microsoft\Windows\CurrentVersion\Uninstall\$($programname)* | Select -ExpandProperty UninstallString
if($32x){
    foreach($subItem in $32x)
    {
    Get-Process -Name $programname -ErrorAction SilentlyContinue | Stop-Process -Force
    #$Arguments = "--uninstall", "--runimmediately", "--deleteuserprofile=1"
    #$filepath  = $32x+'\Launcher.exe'
    Start-Process -FilePath $subItem
    write-host("32bit "+$subItem)
    }
    
}
$64x = Get-ItemProperty registry::HKEY_USERS\$($Item)\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\$($programname)* | Select -ExpandProperty UninstallString
if($64x){
    foreach($subItem in $64x)
    {
    Get-Process -Name $programname -ErrorAction SilentlyContinue | Stop-Process -Force
    #$Arguments = "--uninstall", "--runimmediately", "--deleteuserprofile=1"
    #$filepath  = $64x+'\Launcher.exe'
    Start-Process -FilePath $subItem
    write-host("64bit "+$subItem)
    }
    
}

}
