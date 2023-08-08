IF OBJECT_ID('dbo.fact_trip') IS NOT NULL 
BEGIN 
    DROP EXTERNAL TABLE [dbo].[fact_trip]; 
END

CREATE EXTERNAL TABLE dbo.fact_trip 
WITH (
    LOCATION = 'fact_trip',
	DATA_SOURCE = [thangnx4files_thangnx4project2_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
)
AS
SELECT [trip_id], 
       [rideable_type],
       [started_at] = CAST(started_at as datetime),
       [ended_at] = CAST(ended_at as datetime),
       [start_station_id],
       [end_station_id],
       st.[rider_id],
       [trip_duration] = DATEDIFF(minute, started_at, ended_at),
       [rider_age_at_trip] = DATEDIFF(year, birthday, started_at)
FROM [dbo].[staging_trip] st
LEFT JOIN [dbo].[staging_rider] sr
ON sr.rider_id = st.rider_id;
GO

SELECT TOP 100 * FROM dbo.fact_trip
GO