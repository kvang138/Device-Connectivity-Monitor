# Monitor for disconnected and connected devices

param(
    # Parameter help description
    [Parameter(Mandatory=$true)]
    [string] $ConnectionString
)

$decodedConnectionString = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($connectionString))
$connection = New-Object System.Data.SqlClient.SqlConnection($decodedConnectionString)


try 
{
    Clear-Host
    
    $connection.open()
    
    Write-Host("[i][$(Get-Date -Format "dddd, MMM dd, yyyy hh:mm:ss tt")] Connnection established with the database server.")
}
catch 
{
    Write-Error("[!][$(Get-Date -Format "dddd, MMM dd, yyyy hh:mm:ss tt")] Unable to connect to the database server with the provided connection string.")

    Write-Error("`n[!][$(Get-Date -Format "dddd, MMM dd, yyyy hh:mm:ss tt")] $($_.Exception.Message)")

    Exit(1)
}

Write-Host "`n[i][$(Get-Date -Format "dddd, MMM dd, yyyy hh:mm:ss tt")]--- Monitoring Device Connections/Disconnections (Press CTRL+C to stop) ---" -ForegroundColor Cyan

# Define the WMI Query to watch for Win32_PnPEntity events
#   __InstanceCreationEvent handles connections
#   __InstanceDeletionEvent handles disconnections
$queryConnect    = "SELECT * FROM __InstanceCreationEvent WITHIN 2 WHERE TargetInstance ISA 'Win32_PnPEntity'"
$queryDisconnect = "SELECT * FROM __InstanceDeletionEvent WITHIN 2 WHERE TargetInstance ISA 'Win32_PnPEntity'"

# Define the Action Script Block
$actionEventHandler = {
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss tt"
    $device = $EventArgs.NewEvent.TargetInstance
    $eventType = $EventArgs.NewEvent.CimClass.CimClassName

    # Determine if it was a disconnection or connection
    $actionVerb = if ($eventType -eq "__InstanceCreationEvent") { "CONNECTED" } else { "DISCONNECTED" }
    $Color = if ($actionVerb -eq "CONNECTED") { "Green" } else { "Red" }

    # Log the event into the data base
    $query = "insert into device_connectivity_info (dateTime, deviceName, deviceID, action)
                values 
                ('$(Get-Date -Format "yyyy-MM-dd HH:mm:ss.fffffff")', N`'$($device.Name)`', N`'$($device.deviceID)`', N`'$actionVerb`')"
    
    $command = $connection.CreateCommand()
    $command.CommandText = $query

    $rowAffected = ""
    try
    {
        $rowAffected = $command.ExecuteNonQuery()
    } 
    catch 
    {
         Write-Error("`n[i][$(Get-Date -Format "dddd, MMM dd, yyyy hh:mm:ss tt")] Error logging event to database.")
         Write-Error("`n[!][[$(Get-Date -Format "dddd, MMM dd, yyyy hh:mm:ss tt")] $($_.Exception.Message)")
    }
        
    # Output the details
    Write-Host "[$timestamp]" -NoNewline
    Write-Host " [$actionVerb]" -ForegroundColor $Color -NoNewline
    Write-Host " Name: $($device.Name) | ID: $($device.DeviceID)"
}

# Register the Events
Register-CimIndicationEvent -Query $queryConnect -SourceIdentifier "DeviceConnected" -Action $actionEventHandler > $null
Register-CimIndicationEvent -Query $queryDisconnect -SourceIdentifier "DeviceDisconnected" -Action $actionEventHandler > $null

# Listen for events
try {
    while ($true) { Start-Sleep -Seconds 1 }
}
finally {
    # 5. Cleanup: Unregister watchers when the script is stopped
    Unregister-Event -SourceIdentifier "DeviceConnected"
    Unregister-Event -SourceIdentifier "DeviceDisconnected"

    Remove-Event -SourceIdentifier "DeviceConnected"
    Remove-Event -SourceIdentifier "DeviceDisconnected"

    $connection.Close()

    Write-Host "`nMonitoring stopped and events unregistered." -ForegroundColor Yellow
}





