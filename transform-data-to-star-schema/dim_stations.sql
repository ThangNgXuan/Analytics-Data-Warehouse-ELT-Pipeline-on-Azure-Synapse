IF OBJECT_ID('dbo.dim_stations') IS NOT NULL 
BEGIN 
    DROP EXTERNAL TABLE [dbo].[dim_stations]; 
END

CREATE EXTERNAL TABLE dbo.dim_stations 
WITH (
    LOCATION = 'dim_stations',
	DATA_SOURCE = [thangnx4files_thangnx4project2_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
)
AS
SELECT [station_id], 
       [name],
       [latitude],
       [longitude]
FROM [dbo].[staging_stations];
GO

SELECT TOP 100 * FROM dbo.dim_stations
GO