/*---- Use Database ----*/
use sales

--Select query
SELECT
    product_name,  
    price
FROM
	product p
INNER JOIN Customer c 
        ON c.Customer_Id = p.Product_id;

/*---- Create View for Select Query ----*/
CREATE VIEW product_info
AS
SELECT
    product_name,  
    price
FROM
	product p
INNER JOIN Customer c 
        ON c.Customer_Id = p.Product_id;

--Get Records using View
SELECT * FROM product_list;

/*---- Modify View for Select Query ----*/
CREATE or ALTER VIEW product_info
AS
SELECT
	Customer_Name,
    product_name,  
    price
FROM
	product p
INNER JOIN Customer c 
        ON c.Customer_Id = p.Product_id;

/*----- Rename A view -----*/
EXEC sp_rename 
    @objname = 'product_info',
    @newname = 'product_list';
SELECT * FROM product_list;

/*----- Get A view Information -----*/
SELECT
    definition,
    uses_ansi_nulls,
    uses_quoted_identifier,
    is_schema_bound
FROM
    sys.sql_modules
WHERE
    object_id = object_id('product_list');

SELECT 
    OBJECT_DEFINITION( OBJECT_ID('product_list') ) view_info;

/*----- Drop A view Information -----*/
CREATE VIEW product_Detail
AS
SELECT
    product_name,  
    price
FROM
	product p
INNER JOIN Customer c 
        ON c.Customer_Id = p.Product_id;

--- Drop
DROP VIEW IF EXISTS product_Detail;

/*--- List all views from sql server ---*/
-- Query using sys.views
SELECT 
	OBJECT_SCHEMA_NAME(v.object_id) schema_name,
	v.name
FROM 
	sys.views as v; 

--Query using sys.objects
SELECT 
	OBJECT_SCHEMA_NAME(o.object_id) schema_name,
	o.name
FROM
	sys.objects as o
WHERE
	o.type = 'V';

--stroed Procedure to list all the views
CREATE PROC list_views
(
	@schema_name AS VARCHAR(MAX)  = NULL,
	@view_name AS VARCHAR(MAX) = NULL
)
AS
SELECT 
	OBJECT_SCHEMA_NAME(v.object_id) schema_name,
	v.name view_name
FROM 
	sys.views as v
WHERE 
	(@schema_name IS NULL OR 
	OBJECT_SCHEMA_NAME(v.object_id) LIKE '%' + @schema_name + '%') AND
	(@view_name IS NULL OR
	v.name LIKE '%' + @view_name + '%');

/*--- SQL Server indexed view ---*/
CREATE VIEW pDetails
with SCHEMABINDING
AS 
SELECT
    Customer_Name,
	Customer_Mobile
FROM
    dbo.Customer

select * from pDetails