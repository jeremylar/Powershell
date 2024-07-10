$profiles = netsh wlan show interfaces
$position = $profiles[19].IndexOf(":")
$string = $profiles[19].Substring($position+2)
$string.Trim()
