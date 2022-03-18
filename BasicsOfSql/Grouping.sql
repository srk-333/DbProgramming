/*---- Use Database ----*/
use sales 

/*---- Use of Group by Clause----*/
select COUNT(Customer_Name) as Customer , Gender 
from Customer group by Gender;

select Sum (NetPay) as Totalpay, Product_name 
from product 
group by Product_name 
order by Product_name Desc;

select Avg (NetPay) as Avgpay, Product_name 
from product 
group by Product_name 
order by Product_name Desc;

/*---- Use of Having Clause----*/
select Product_name ,Price
from product 
group by Product_name ,Price
having Price > 20000 ;

select Product_name , Price
from product 
group by Product_name, Price
having MAX(Price) > 40000;

/*---- Use of Grouping Sets , Cube , Rollup  Clause ----*/
select Product_name, SUM(Price) TotalPrice
from product group by GROUPING Sets((Product_name),() )
order by Product_name;

select GROUPING(Product_name) grouping_product,
Product_name, SUM(Price) TotalPrice
from product group by GROUPING Sets((Product_name),() )
order by Product_name Desc;

select GROUPING(Product_name) grouping_product, GROUPING(Price) grouping_price,
Product_name, Price, SUM(NetPay) Totalpay
from product group by GROUPING Sets((Product_name, Price),(Product_name),(Price),())
order by Product_name , Price;

select Product_name, Price, SUM(NetPay) Totalpay
from product
group by cube (Product_name , Price)
order by Product_name , Price;

select Product_name, Price, SUM(NetPay) Totalpay
from product
group by Price,
cube (Product_name)
order by Product_name , Price;

select Product_name, Price, SUM(NetPay) Totalpay
from product
group by
rollup (Product_name, Price)
order by Product_name , Price;

select Price, Product_name, SUM(NetPay) Totalpay
from product
group by
rollup (Price, Product_name)
order by Product_name , Price;