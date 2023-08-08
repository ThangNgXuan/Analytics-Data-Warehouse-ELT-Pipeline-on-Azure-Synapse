IF OBJECT_ID('dbo.dim_date') IS NOT NULL 
BEGIN 
    DROP EXTERNAL TABLE [dbo].[dim_date]; 
END

CREATE EXTERNAL TABLE dbo.dim_date 
WITH (
    LOCATION = 'dim_date',
	DATA_SOURCE = [thangnx4files_thangnx4project2_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
)
AS
SELECT [DateKey] = YEAR(started_at) * 10000 + MONTH(started_at) * 100 + DAY(started_at), 
       [Date] = TRY_CONVERT(DATE, started_at),
       [DayOfWeek] = DATEPART(dw, started_at),
       [DayOfMonth] = DATEPART(dd, started_at),
       [WeekOfYear] = DATEPART(wk, started_at),
       [Quarter] = DATEPART(q, started_at),
       [Month] = MONTH(started_at),
       [Year] = YEAR(started_at)
FROM [dbo].[staging_trip];
GO

SELECT TOP 100 * FROM dbo.dim_date
GO