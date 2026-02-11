--- Set up file for Disconnected and Connected Devices project

declare @databaseName nvarchar(268) = N'SOCLab';

-- Create the database for storing the table
exec createDatabase
	@databaseName = @databaseName;

drop table if exists device_connectivity_info

-- Dynamically create a table to store the events
exec createDynamicTable
	@databaseName = 'SOCLab',
	@tableName = 'device_connectivity_info',
	@columnsDefinitions = N'
		reportID int identity(1,1) primary key,
		dateTime datetime2,
		deviceName nvarchar(268),
		deviceID nvarchar(268),
		action nvarchar(13)
	';

