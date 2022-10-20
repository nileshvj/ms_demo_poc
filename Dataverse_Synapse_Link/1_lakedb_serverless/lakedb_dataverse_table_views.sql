---- create schema
-- create schema test

select * from INFORMATION_SCHEMA.VIEWS 

--v_account
CREATE OR ALTER VIEW test.v_account
AS
SELECT  TOP 100 *
 FROM [dataverse_njotest_unqc6111fa0426b48d9b24e48af72819].[dbo].[account]

 select * from test.v_account

--v_customer
 CREATE OR ALTER VIEW test.v_customer
AS
 SELECT * 
 FROM (
 SELECT TOP 100 *, ROW_NUMBER()OVER(PARTITION BY Id ORDER BY SinkModifiedOn DESC)  AS RNO
 FROM [dataverse_njotest_unqc6111fa0426b48d9b24e48af72819].dbo.cr39c_njo_customer
 ) AS C
 WHERE C.RNO = 1 --Get latest row version
 AND ISNULL(C.IsDelete,'False') = 'False' -- filter deleted records

--custom view
 select * from test.v_customer

 SELECT TOP 100 *, ROW_NUMBER()OVER(PARTITION BY Id ORDER BY SinkModifiedOn DESC)  AS RNO FROM [dataverse_njotest_unqc6111fa0426b48d9b24e48af72819].dbo.cr39c_njo_customer

--partitioned table
  SELECT * FROM [dataverse_njotest_unqc6111fa0426b48d9b24e48af72819].[dbo].[cr39c_njo_customer_partitioned]


--Curated view on customer view
   CREATE OR ALTER VIEW test.v_customer_curated
AS
SELECT Id, SinkModifiedOn, cr39c_customerid as CustomerId, cr39c_customername AS CustomerName
FROM test.v_customer


SELECT * FROM test.v_customer_curated ORDER BY CustomerId