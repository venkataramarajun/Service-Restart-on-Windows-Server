
foreach ($ServiceName in $ServiceNames) {
	Start-Sleep -Seconds $Delay
$SN = Get-Service $ServiceName
$currentTime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

switch ($Action) {
Start {
    if ($SN.StartType -eq "Disabled")
    {
        Write-Output "[$currentTime] - $($SN.displayName) Service is in Disabled State" | Out-File -Append -FilePath $logFilePath
    }
    elseif ($SN.Status -eq "Running")
    {
        Write-Output "[$currentTime] - $($SN.displayName) Service is already in Running State" | Out-File -Append -FilePath $logFilePath
    }
    elseif ($SN.Status -eq "Stopped")
    {
		$currentTime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        Start-Service $ServiceName
        Start-Sleep -Seconds 20
		$SN.Refresh()
        if ($SN.Status -eq "Running")
        {
			Write-Output "[$currentTime] - $($SN.displayName) has been started" | Out-File -Append -FilePath $logFilePath
		}
        else
		{
			Write-Output "[$currentTime] - $($SN.displayName)) has not started" | Out-File -Append -FilePath $logFilePath
		}
    }
}

Stop {
    if ($SN.StartType -eq "Disabled")
		{
			if($SN.Status -eq "Running")
			{
				$currentTime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
				Stop-Service $ServiceName
				Start-Sleep -Seconds 20
				$SN.Refresh()
				Write-Output "[$currentTime] - $($SN.displayName) has been stopped" | Out-File -Append -FilePath $logFilePath
			} else {		
				Write-Output "[$currentTime] - $($SN.displayName) Service is in Disabled State" | Out-File -Append -FilePath $logFilePath
			}
		}
    elseif ($SN.Status -eq "Running")
    {
		$currentTime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        Stop-Service $ServiceName
        Start-Sleep -Seconds 20
		$SN.Refresh()
        if ($SN.Status -eq "Stopped")
        {
			Write-Output "[$currentTime] - $($SN.displayName) has been stopped" | Out-File -Append -FilePath $logFilePath
		}
        else
		{
			Write-Output "[$currentTime] - $($SN.displayName) has not stopped" | Out-File -Append -FilePath $logFilePath
		}
	}
    elseif ($SN.Status -eq "Stopped")
    {
        Write-Output "[$currentTime] - $($SN.displayName) Service is already in stopped State" | Out-File -Append -FilePath $logFilePath
    }
}

Restart {
	if ($SN.StartType -eq "Disabled")
    {
        Write-Output "[$currentTime] - $($SN.displayName) Service is in Disabled State" | Out-File -Append -FilePath $logFilePath
    }
	else
	{
		$currentTime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
		Restart-Service $ServiceName
        Start-Sleep -Seconds 20
		$SN.Refresh()
        if ($SN.Status -eq "Running")
        {
			Write-Output "[$currentTime] - $($SN.displayName) has been restarted" | Out-File -Append -FilePath $logFilePath
		}
        else
		{
			Write-Output "[$currentTime] - $($SN.displayName)) has not restarted" | Out-File -Append -FilePath $logFilePath
		}
	}
}
}
}