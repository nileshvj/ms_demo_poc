IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'CSV_NoHeader') 
	CREATE EXTERNAL FILE FORMAT [CSV_NoHeader] 
	WITH ( FORMAT_TYPE = DELIMITEDTEXT ,
	       FORMAT_OPTIONS (
			 FIELD_TERMINATOR = ',',
			 USE_TYPE_DEFAULT = FALSE
			))
GO

IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'CSV_StringDelimiterQuotes') 
	CREATE EXTERNAL FILE FORMAT [CSV_StringDelimiterQuotes] 
	WITH ( FORMAT_TYPE = DELIMITEDTEXT ,
	       FORMAT_OPTIONS (
			 FIELD_TERMINATOR = ',',
			 STRING_DELIMITER = '"',
			 USE_TYPE_DEFAULT = FALSE
			))
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'dataverse-njotest-unqc6111fa0426b48d9b24e48af72819_njoadlsext1_dfs_core_windows_net') 
	CREATE EXTERNAL DATA SOURCE [dataverse-njotest-unqc6111fa0426b48d9b24e48af72819_njoadlsext1_dfs_core_windows_net] 
	WITH (
		LOCATION = 'abfss://dataverse-njotest-unqc6111fa0426b48d9b24e48af72819@njoadlsext1.dfs.core.windows.net', 
		TYPE = HADOOP 
	)
GO

-- create schema exta
CREATE EXTERNAL TABLE ext.cr39c_njo_test2 (
	[Id] [varchar](256),
	[SinkCreatedOn] [varchar](256),
	[SinkModifiedOn] [varchar](256),
	[statecode] [bigint],
	[statuscode] [bigint],
	[createdby] [varchar](256),
	[createdby_entitytype] [varchar](256),
	[owningteam] [varchar](256),
	[owningteam_entitytype] [varchar](256),
	[modifiedonbehalfby] [varchar](256),
	[modifiedonbehalfby_entitytype] [varchar](256),
	[modifiedby] [varchar](256),
	[modifiedby_entitytype] [varchar](256),
	[owningbusinessunit] [varchar](256),
	[owningbusinessunit_entitytype] [varchar](256),
	[createdonbehalfby] [varchar](256),
	[createdonbehalfby_entitytype] [varchar](256),
	[owninguser] [varchar](256),
	[owninguser_entitytype] [varchar](256),
	[ownerid] [varchar](256),
	[ownerid_entitytype] [varchar](256),
	[timezoneruleversionnumber] [bigint],
	[owneridtype] [varchar](max),
	[modifiedonbehalfbyname] [varchar](1026),
	[versionnumber] [bigint],
	[modifiedbyyominame] [varchar](1026),
	[cr39c_name] [varchar](400),
	[importsequencenumber] [bigint],
	[createdon] [varchar](50),
	[createdbyyominame] [varchar](1026),
	[overriddencreatedon] [varchar](256),
	[modifiedonbehalfbyyominame] [varchar](1026),
	[owneridyominame] [varchar](640),
	[createdbyname] [varchar](1026),
	[utcconversiontimezonecode] [bigint],
	[modifiedbyname] [varchar](1026),
	[createdonbehalfbyname] [varchar](1026),
	[cr39c_njo_test2id] [varchar](256),
	[modifiedon] [varchar](256),
	[owningbusinessunitname] [varchar](640),
	[createdonbehalfbyyominame] [varchar](1026),
	[owneridname] [varchar](640)
	)
	WITH (
	LOCATION = 'cr39c_njo_test2/2022-10.csv',
	DATA_SOURCE = [dataverse-njotest-unqc6111fa0426b48d9b24e48af72819_njoadlsext1_dfs_core_windows_net],
	FILE_FORMAT = [CSV_StringDelimiterQuotes]
	)
GO


SELECT TOP 100 * FROM ext.cr39c_njo_test2
GO