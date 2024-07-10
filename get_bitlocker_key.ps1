(Get-BitLockerVolume -MountPoint C).KeyProtector | Where {$_.KeyProtectorType -eq "RecoveryPassword"}| select-object -ExpandProperty "RecoveryPassword"
