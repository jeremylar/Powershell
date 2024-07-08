Add-Type -AssemblyName System.Speech
$Chuck = Invoke-WebRequest -Uri 'https://api.chucknorris.io/jokes/random' -UseBasicParsing |
    Select-Object -ExpandProperty 'Content' |
    ConvertFrom-Json
$Speaker = New-Object System.Speech.Synthesis.SpeechSynthesizer
$Speaker.Speak($Chuck.value)
