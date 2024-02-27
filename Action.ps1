$ServiceNames = "BDESVC" , "LSM" (#Servive names)
$Action = "Stop" (#Action can be Stop/Start/Restart)
$Delay = 0 (#Delay can be the time gap between every service)
$logFilePath = "" (#Logfile path)

Invoke-Expression -Command .\Execution.ps1