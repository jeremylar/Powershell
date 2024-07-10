#last two weeks
$Begin = (Get-Date).AddDays(-14).ToString('MM/dd/yyyy 00:00:00')
#now
$End = Get-Date -Format 'MM/dd/yyyy HH:mm:ss'
$Uri = "<https://url for api call post>"
$headers = @{'apikey' = 'api header key'}
$events = Get-EventLog -LogName Application -Source Impromed -After $Begin -Before $End | Select-Object MachineName, EventID,Message,Source,TimeGenerated,TimeWritten | ConvertTo-Json
$Result = Invoke-RestMethod -Uri $Uri -Method Post -Headers $headers -body $events -ContentType "application/json"
