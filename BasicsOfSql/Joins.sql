/*----- Use Database ------*/
use Sales

/*----- Create Table to implement Join ------*/
create table product
(
 Product_id int identity(10,1) primary key,
 Product_name varchar(255) not null,
 Price decimal not null,
 Discount decimal not null,
 NetPay decimal not null,
 Customer_Id int FOREIGN KEY REFERENCES Product(Product_id) on delete no action
);

/*----- Insert Some dummy data ------*/
Insert into product
values('samsung s10', 35000.00, 5000, 30000.00, 12),
('dell s10', 45000.00, 2000, 43000.00, 13),
('Redmi k20', 20000.00, 1000, 19000.00, 16),
('Iphone 13', 85000.00, 3000, 82000.00, 17);

/*----- Retrieve all data from Table ------*/
select * from product

/*----- Implement Inner Join ------*/
select Customer_Name, Product_Name, NetPay
from Customer c
Inner Join product p
on c.Customer_Id = p.Product_id
order by Customer_Name Asc;

select Customer_Name, Product_Name
from Customer c
Inner Join product p
on c.Customer_Id = p.Product_id
order by Customer_Name Desc;

select Customer_Name, Product_Name
from Customer c
Join product p
on c.Customer_Id = p.Product_id
order by Customer_Name Asc;

select *
from Customer c
Join product p
on c.Customer_Id = p.Product_id
order by Customer_Name Asc;

select *
from Customer c
Join product p
on c.Customer_Id > p.Product_id
order by Customer_Name Asc;

/*----- Implement Left Join ------*/
select *
from Customer c
Left Join product p
on c.Customer_Id = p.Product_id

select Customer_Name, Product_Name
from Customer c
Left Join Product p
on c.Customer_Id = p.Product_Id
order by Customer_Name Desc;

select Customer_Name, Product_Name
from Customer c
Left Join Product p
on c.Customer_Id = p.Product_Id
order by Customer_Name Asc;

/*----- Implement Right Join ------*/
select Customer_Name, Product_Name
from Customer c
Right Join Product p
on c.Customer_Id = p.Product_Id
order by Customer_Name Asc;

select Customer_Name, Product_Name
from Customer c
Right Join Product p
on c.Customer_Id = p.Product_Id
order by Customer_Name Desc;

select *
from Customer c
Right Join Product p
on c.Customer_Id = p.Product_Id
order by Customer_Name Desc;

/*----- Implement Full outer Join ------*/
select *
from Customer c
Full outer Join Product p
on c.Customer_Id = p.Product_Id
order by Customer_Name Desc;

select Customer_Name, Product_Name
from Customer c
Full Join Product p
on c.Customer_Id = p.Product_Id
order by Customer_Name Asc;

select *
from Customer c
Full Join Product p
on c.Customer_Id = p.Product_Id

/*----- Implement Cross Join ------*/
select *
from Customer c
Cross Join Product p;

select Customer_Name, Customer_Mobile, Product_name, Price ,Discount, NetPay
from Customer c
Cross join product p
order by Customer_Name Asc;

/*----- Implement Cross Join ------*/
create table Employee
(
	Employee_Id int Identity(1,1) Primary key,
	Employee_Name varchar(255),
	Employee_Mobile bigint,
	Manager_Id int FOREIGN KEY REFERENCES Employee(Employee_Id) on delete no action
);

insert into Employee (Employee_Name, Employee_Mobile, Manager_Id ) 
Values ('Saurav', 785648965 , 4),('Ritesh', 3454353553 , 2),('Rohit', 345356343456 , 3),
('Akhil', 4645776653 , 1),('Vikash', 3242565446 , 6),('Saurav', 5546456546 , 5);

select * from Employee

select a.Employee_Id as "EmployeeId" , a.Employee_Name as "EmployeeName",
b.Employee_Id as "ManagerId" , b.Employee_Name as "ManagerName"
from Employee a , Employee b
where a.Manager_Id = b.Employee_Id;