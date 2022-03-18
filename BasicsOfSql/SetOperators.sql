/*---- Use Database ----*/
use sales 

/*---- Set Operators Union and union all----*/
select COUNT(*) from Customer
select COUNT(*) from product

select Customer_Name from Customer
Union
Select Product_name from product

select Customer_Name from Customer
Union all
Select Product_name from product

select Customer_Name from Customer
Union all
Select Product_name from product
order by Customer_Name;

/*---- Set Operators INTERSECT ----*/
select Customer_Id from Customer
intersect
Select Product_Id from product

/*---- Set Operators Except ----*/
select Customer_Id from Customer
Except
Select Product_Id from product

select Customer_Id from Customer
Except
Select Product_Id from product
order by Customer_Id
