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

/*----- Get view Information -----*/
SELECT
    definition,
    uses_ansi_nulls,
    uses_quoted_identifier,
    is_schema_bound
FROM
    sys.sql_modules
WHERE
    object_id = object_id('product_list');

-- using object definition
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

--- Drop view
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
    dbo.Customer;

Create view Product_Master
with schemabinding
as
SELECT
    product_name,  
    price
FROM
	dbo.product p
INNER JOIN dbo.Customer c 
        ON c.Customer_Id = p.Product_id;

select * from Product_Master;

/*--- view on DDl query  ---*/
create view productDemo
as
select * from product;

select * from productDemo;
Insert into productDemo(Product_name,Price,Discount,NetPay,Customer_Id,Category)
values('Fan', 5000 , 500, 4500, 12,'Eletronics');
Update productDemo set Product_name = 'Bajaj Fan' where Product_id = 2012;
Delete from productDemo where Product_name ='Fan';

/*--- view With Check option ---*/
create view CustomerDemo
as
select * from Customer where City = 'London'
with check option
-- when we use check option then we can'nt insert or update in view 
-- if we dnt provide City = london 
select * from CustomerDemo
--not fullfill view with check option
Update CustomerDemo set Customer_Name = 'Sam' where City = 'Jehanabad' ;
--fullfills view with check option
Update CustomerDemo set Customer_Name = 'Sam' where City = 'London' and Customer_Id = 12 ;