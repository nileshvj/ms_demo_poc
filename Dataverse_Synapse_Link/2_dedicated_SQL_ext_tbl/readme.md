# Option #2: Use external tables in dedicated SQL pool 
2.1 Create a table in dedicated SQL pool to hold metadata information 

`create table exta.metadata (`

`Entity nvarchar(50), `

`Name nvarchar(200), `

`datatype NVARCHAR(50), `

`maxLength int, `

`precision int, `

`scale int,`

`datatypeSQL nvarchar(100)`

`);`


2.2 Create external file format and data source

`IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'CSV_StringDelimiterQuotes') `

    `CREATE EXTERNAL FILE FORMAT [CSV_StringDelimiterQuotes] `

    `WITH ( FORMAT_TYPE = DELIMITEDTEXT ,`

           `FORMAT_OPTIONS (`

             `FIELD_TERMINATOR = ',',`

             `STRING_DELIMITER = '"',`

             `USE_TYPE_DEFAULT = FALSE`

            `))`

`GO`



``IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'dataverse-****-unqc6*******8d9b24e48af72819_*****_dfs_core_windows_net') ``

    ``CREATE EXTERNAL DATA SOURCE [dataverse-*****-unqc6********8d9b24e48af72819_*******_dfs_core_windows_net] ``

    ``WITH (``

        ``LOCATION = 'abfss://dataverse-*****-unqc********8d9b24e48af72819@******.dfs.core.windows.net', ``

        ``TYPE = HADOOP ``

    ``)``

``GO``



2.3 Create a synapse pipeline 
![image](https://user-images.githubusercontent.com/12938692/197015195-98563ab1-5a9a-4fd5-9a57-f5ac3d448b06.png)


	This pipeline will
•	Truncate metadata table created in step 2.1 above

•	Read metadata stored in dataverse’s model.json 

•	Iterate through each entity record in model.json

o	Read metadata information from json for specific entity 
o	Map data types to relevant SQL data types..eg: guid to nvarchar(36) etc. 
** test this mapping for different tables to make sure mapping works, Otherwise you may need to add new mapping
o	Insert Entity, column name and data types in metadata table created in 2.1 above
o	Call script activity to execute dynamic script for create table

``declare @entity nvarchar(200) = '@{item().name}';``

``Declare @CreateTableDDL nvarchar(max)``

``SELECT  ``

``@CreateTableDDL  =  'CREATE EXTERNAL TABLE exta.' + @entity +   + '(' + STRING_AGG(CONVERT(NVARCHAR(max), + '[' + Name + '] ' +  datatypeSQL) , ',') + 
')'``

``+ 'WITH (``

    ``LOCATION = ''cr39c_njo_test2/2022-10.csv'', ``

    ``DATA_SOURCE = [dataverse-njotest-unqc6111fa0426b48d9b24e48af72819_njoadlsext1_dfs_core_windows_net],``

    ``FILE_FORMAT = [CSV_StringDelimiterQuotes]``

    ``)'``

``FROM exta.metadata ``

``WHERE [Entity] =   'cr39c_njo_test2'``

``execute sp_executesql  @CreateTableDDL;``

_**Replace highlighted portion with appropriate variables or strings. Since this is POC I have hard coded them for one table/entity only._

_** Also, you will see If condition added in foreach activity in the pipeline I have created. You may remove that. Reason I have added that was to test it only for one table. If you don’t want to filter list of tables and apply logic for all tables, please remove “If activity” and place that logic directly under “for each activity”._

Disclaimer: Sample code provided here is for demo purpose only. This requires modifications as per specific use case and requirements before deploying for production use.
