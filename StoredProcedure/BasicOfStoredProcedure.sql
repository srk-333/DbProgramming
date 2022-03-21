/*---- Use Database ----*/
use sales 

/*----Create Stored Procedures ----*/
create procedure spCustomersList
as
select * from Customer
go;
exec spCustomersList

/*----Modify Existing Stored Procedures ----*/
ALTER procedure spCustomersList
as
Begin
select Customer_Name from Customer 
where Customer_Id = 29
End;
exec spCustomersList

CREATE OR ALTER procedure uspProductList
AS
BEGIN
select * from product;
END;

exec uspProductList;

/*---- Delete Existing Stored Procedures ----*/
Drop procedure uspProductList;

/*---- Stored Procedure With One Parameter ----*/
CREATE PROCEDURE FindProducts(@min_list_price AS DECIMAL)
AS
BEGIN
    SELECT
        Product_Name,
        Price
    FROM 
       product
    WHERE
        Price >= @min_list_price
    ORDER BY
        Price;
END;

exec FindProducts 40000;

/*---- Stored Procedure With Multiple Parameter ----*/
Create PROCEDURE FindProductsbyMultipleParameter
(
     @min_list_price AS DECIMAL,
     @max_list_price AS DECIMAL
)
AS
BEGIN
    SELECT
        Product_name,
        Price
    FROM 
        product
    WHERE
        Price >= @min_list_price AND
        Price <= @max_list_price
    ORDER BY
        Price;
END;

Exec FindProductsbyMultipleParameter 20000, 80000;

/*---- Stored Procedure with text parameters ----*/
CREATE PROCEDURE FindProductsbyname(@name as varchar(max))
AS
BEGIN
    SELECT
        *
    FROM 
       product
    WHERE
        Product_name Like '%' + @name + '%'
    ORDER BY
        Price;
END;

Exec FindProductsbyname @name = 'd';

/*---- Stored Procedure with Variables ----*/
/*--- Using variables in a query ---*/
Declare @product_price decimal
set @product_price = 35000
select * from product
where Price = @product_price
order by Price;

/*--- Storing query result in a variable ---*/
DECLARE @product_count INT;
set @product_count = (
  select COUNT(*)
  from product
)
print @product_count;

/*--- Selecting a record into variables ---*/
DECLARE 
    @product_name VARCHAR(MAX),
    @list_price DECIMAL;
SELECT 
    @product_name = product_name,
    @list_price = price
FROM
   product
WHERE
    product_id = 12;
SELECT 
    @product_name AS product_name, 
    @list_price AS list_price;

/* --- Accumulating values into a variable ----*/
Create or Alter procedure useOfVariables (@min_price as Decimal)
as
begin
    DECLARE @product_list VARCHAR(MAX);
    SET @product_list = '';
	SELECT @product_list = @product_list + product_name + CHAR(10)
    FROM 
        product
    WHERE
        Price >= @min_price
   ORDER BY 
        Price;
    PRINT @product_list;
END;

Exec useOfVariables @min_price = 45000;

/* --- Creating Output Parameter ----*/
create procedure outputParameter
(
	@min_price decimal,
	@product_count int output
)
as
begin
   select Product_name, Price
   from product
   where Price>= @min_price
   select @product_count = @@ROWCOUNT
end;    
declare @count int;
Exec outputParameter
  @min_price = 10000,
  @product_count = @count output
select @count as 'Number of Product';


