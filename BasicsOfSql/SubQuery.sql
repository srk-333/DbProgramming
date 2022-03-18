/*---- Use Database ----*/
use sales 

/*---- Use of SubQuery operator used In , Any , All in where Clause----*/
select Product_name ,Price
from product
where 
 Price in
 (
    select Price
	from product
	where Price > 30000
 )
 group by Product_name , Price
 order by Product_name;

select Product_name ,Price
from product
where 
 Price >= Any
 (
    select Avg(Price)
	from product
 )
 group by Product_name , Price
 order by Product_name;

select Product_name ,NetPay
from product
where 
 NetPay <= All
 (
    select Sum(Price)
	from product
 )
 group by Product_name , NetPay
 order by Product_name;

/*---- Use of SubQuery in Select Clause----*/
select Product_name, 
(
select Customer_Name
from Customer c1
where 
c1.Customer_Id = p2.Product_id
) as Customer_Name
from product p2
order by Product_name;

/*---- Use of SubQuery in From Clause----*/
select Avg(product_Price) avg_Price 
from
( select 
	Product_id,
	Avg(Price) product_Price
  from product
  group by Product_id
) t;

/*---- Nesting SubQuery ----*/
select Product_name ,Price
from product
where 
 Price >=
 (
    select Avg(Price)
	from product
	where
	  Product_id in
	  (
		select Product_id
		from product
		where
		   Product_name = 'dell s10' or  Product_name = 'Iphone 13'
	  )
 )
 group by Product_name , Price
 order by Product_name , Price;

/*---- Use of SubQuery With Update Clause----*/
 Update Customer
 set Customer_Name =
 (
    select Customer_Name
	from Customer
	where Customer_Id = 13
 );

 Update Customer
 set Customer_Name =
 (
    select Customer_Name
	from Customer
	where Customer_Id = 13
 )
 where Customer_Id = 10;

/*---- Use of SubQuery With Delete Clause----*/
 Delete From Customer
 where Customer_Id in(select Customer_Id from Customer where City = 'Patna' )

/*---- Use of Correlated SubQuery ----*/
select Product_name, Price, Product_id
from product p1
where
Price In
(
	select MAX(Price)
	from product p2
	where 
	p2.Product_id = p1.Product_id
	group by p2.Product_id
);

/*---- Use of SubQuery operator Exists , Not Exists, ----*/
select Customer_id, Customer_Name, Customer_Mobile
from Customer
where EXISTS (select NULL)
order by Customer_Name;

select *
from Customer c
where EXISTS 
(
 select Customer_Id
 from product p
 where 
 p.Customer_Id = c.Customer_Id
 and Product_name = 'Iphone 13'
)
order by Customer_Name;

select *
from Customer c
where Not EXISTS 
(
 select Customer_Id
 from product p
 where 
 p.Customer_Id = c.Customer_Id
 and Product_name = 'Iphone 13'
)
order by Customer_Name;