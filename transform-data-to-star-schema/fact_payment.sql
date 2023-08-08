IF OBJECT_ID('dbo.fact_payment') IS NOT NULL 
BEGIN 
    DROP EXTERNAL TABLE [dbo].[fact_payment]; 
END

CREATE EXTERNAL TABLE dbo.fact_payment 
WITH (
    LOCATION = 'fact_payment',
	DATA_SOURCE = [thangnx4files_thangnx4project2_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
)
AS
SELECT [payment_id], 
       [date] = TRY_CONVERT(DATE, date),
       [amount],
       [rider_id]
FROM [dbo].[staging_payment];
GO

SELECT TOP 100 * FROM dbo.fact_payment
GO