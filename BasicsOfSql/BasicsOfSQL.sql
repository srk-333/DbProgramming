/*---- Create Database ----*/
create database Sales

/*---- Use Database ----*/
use Sales

/*---- Create Table in Database ----*/
Create table Customer
(
	Customer_Id int Identity(10,1) Primary key,
	Customer_Name varchar(255),
	Customer_Mobile bigint,
	Address varchar(255),
	City varchar(255),
	Postal_Code bigint,
	Country varchar(255),
);

/*---- Insert some dummy data in Table ----*/
insert into Customer 
values ('vikash', 2323121, 'gaya', 'gaya', 742374,'India', 'M'),
('anikt', 56778899, 'wc', 'wc', 56466,'USA', 'M'),
('neha', 242344, 'London', 'London',677756,'UK', 'F'),
('akhil', 23234345, 'kathmandu', 'kathmandu', 688866, 'Nepal', 'M'),
('sam', 5676577, 'Hougang', 'Hougang', 456577, 'Singapore', 'F');

/*---- Alter existing Table add new Column ----*/
Alter Table Customer
Add Gender Char null Default 'M';

/*---- Querying data from Table using Select keyword and Where Clause----*/
select * from Customer
select Customer_Name From Customer
select distinct Country from Customer;
select * from Customer where Country = 'India';

/*---- Filtering data from Table using Operators----*/
select * from Customer;
select * from Customer where Country Like 'U%';
select * from Customer where Country between 'India' and 'Uk';
select * from product where NetPay between 15000 and 40000 order by NetPay asc;
select * from Customer where City in ('london' , 'patna');
select * from product where Product_Id in (11 , 15);
select * from Customer where Country = 'India' and City = 'patna';
select * from Customer where Country = 'Usa' and City = 'newyork';
select * from Customer where Country = 'Uk' or city = 'Delhi';
select * from Customer where Country = 'Nepal' or city = 'Patna';
select * from Customer where not Country = 'Uk'; 
select COUNT(distinct Country) from Customer;
select COUNT (Customer_Id) as TotalCustomer from Customer;

/*---- Sorting data from Table using Select keyword and order by Clause----*/
select * from Customer order by Country;
select * from Customer order by City Asc;
select * from Customer order by Customer_Mobile Desc;
select * from Customer order by Country Asc , Customer_Name Desc;
select Customer_Name , Country from Customer order by LEN( Customer_Name ) Desc;
select Customer_Name , Country from Customer order by LEN( Customer_Name ) Asc;

/*---- Sorting data from Table Column wise ----*/
select * from Customer order by 2 , 3;

/*---- Update Records in Database Table one or many column at a time ----*/
update Customer set Customer_Name = 'Saurav' , City = 'Jehanabad' where Customer_Id = 10;

/*---- Limiting rows ----*/
select top 3 * from Customer
select top 3 * from Customer order by Country Asc;
select top 3 * from Customer order by Country Desc;
select top 3 * from Customer where Country = 'India';
select Customer_Name, Customer_Mobile , Country from Customer order by Country Asc offset 2 rows;
select Customer_Name, Country from Customer order by Country Asc offset 3 rows Fetch next 4 rows only;
select Customer_Name, Country from Customer order by Country Asc offset 0 row Fetch First 4 row only;

/*---- Math function for doing Math opration----*/
select MIN (City) as City from Customer;
select MIN (Price) as MinPrice from Product;
select MIN (Customer_Mobile) as mobile from Customer;
select Max (City) as City from Customer;
select Max (Customer_Mobile) as mobile from Customer;
select Max (Price) as MaxPrice from Product;
select Avg (Price) as AvgPrice from Product;
select sum (Price) as SumPrice from Product;
select COUNT(Country) from Customer;
select COUNT(Price) as totalCount from Product;
select COUNT (Country) as TotalCustomerbyCountry from Customer where Country = 'India';
select COUNT(Customer_Id) as TotalCustomer, Country from Customer group by Country;
select COUNT(Customer_Name) as CustomerName , Gender from Customer group by Gender;

/*---- Create a backup of Existing Table by Select Into ----*/
select * into CustomerBackup from Customer;

/*---- Check Backup table Records ----*/
select * from CustomerBackup;

/*---- Copy Records from One Table to Another Table ----*/
SET IDENTITY_INSERT CustomerBackup on;
insert into CustomerBackup (Customer_Id,Customer_Name,Customer_Mobile,Address,City,Postal_Code,Country,Gender) 
select * from Customer;
SET IDENTITY_INSERT CustomerBackup off;

/*---- Remove a table or Database using Drop ----*/
drop table CustomerBackup
/*---- Clean a table Completely using truncate ----*/
truncate table CustomerBackup;
