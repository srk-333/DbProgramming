/*---- Use Database ----*/
use sales

-- create A Table
CREATE TABLE productionparts(
    part_id   INT NOT NULL, 
    part_name VARCHAR(100)
);

-- Insert some Records
INSERT INTO 
    productionparts(part_id, part_name)
VALUES
    (1,'Frame'),
    (2,'Head Tube'),
    (3,'Handlebar Grip'),
    (4,'Shock Absorber'),
    (5,'Fork');

-- View Records
select * from productionparts;

/****** Create a clustered Index ********/
CREATE CLUSTERED INDEX ix_parts_id
ON productionparts (part_id);  

-- View a specific Record from Clustered Table
SELECT 
    part_id, 
    part_name
FROM 
    productionparts
WHERE 
    part_id = 5;

/****** NonClustered Index *******/
-- This query will use clustered index bcz Customer Table has a primary Key
SELECT 
    customer_id, 
    city
FROM 
    Customer
WHERE 
    city = 'London';

-- Create A non Clustered Index For City Column In Customer Table
CREATE INDEX ix_customer_city
ON Customer (city);
 -- Now The above Select Query Will USe Non Clustered Index For City Cloumn

 -- Non Clustered Index For Multiple Cloumn
CREATE NONCLUSTERED INDEX ix_customers_name 
ON Customer(Customer_Name, Customer_Mobile);

Select Customer_Name, Customer_Mobile
from Customer 
where Customer_Name = 'Sam' And Customer_Mobile = 665356563;

/***** Rename a Index *******/
--By using System Stored Procedure
EXEC sp_rename 
        @objname = N'Customer.ix_customer_city',
        @newname = N'ix_cust_city' ,
        @objtype = N'INDEX';

/****** Disable A Index ******/
ALTER INDEX ix_cust_city 
ON Customer
DISABLE;

-- Disable All Index on A Table
ALTER INDEX ALL ON Customer
DISABLE;

/****** Enable A Index ******/
ALTER INDEX ALL ON Customer
REBUILD;

--Enable Index using Create Index Clause
CREATE INDEX ix_cust_city 
ON Customer(City)
WITH(DROP_EXISTING=ON)

-- Enable indexes using DBCC DBREINDEX statement
DBCC DBREINDEX (Customer, "ix_cust_city");

/***** Drop A Index ******/
DROP INDEX IF EXISTS ix_cust_city
ON Customer;


/****** Unique Index *******/
CREATE TABLE test1 (
    a INT, 
    b INT
);

-- Unique Index on both Cloumn
-- Unqiue Index Doesn't allow duplicate data for the unique Column
CREATE UNIQUE INDEX ix_uniq_ab 
ON test1(a, b);

-- Insert 
Insert into test1(a, b) values(1,1);
Insert into test1(a, b) values(1,2);
-- Now Insert record that is alredy in table
Insert into test1(a, b) values(1,2); -- Bcz of unique Index this query will be terminated

/****** Filtered Index ********/
--A filtered index is a nonclustered index with a predicate 
--that allows you to specify which rows should be added to the index.
-- Filtered Index
CREATE INDEX ix_cust_phone
ON Customer (Customer_Mobile)
WHERE Customer_Mobile is not null;

-- Look for Specific Phone Number
SELECT    
    Customer_Id,
    Customer_Name, 
    Customer_Mobile
FROM    
   Customer
WHERE Customer_Mobile = '453535345';

-- Filtered Index With Included Columns
CREATE INDEX ix_cust_Productname
ON product(Product_name)
INCLUDE (Price, NetPay)
WHERE Price IS NOT NULL;

-- Look for Specific Product
SELECT    
    Product_id,
    Product_name, 
    Price,NetPay
FROM    
   product
WHERE Product_name = 'dell s10';

/*******  Indexes on Computed Columns ********/
-- Firstly, add a new computed column to the Employees table:
ALTER TABLE Employees
ADD 
    email_local_part AS SUBSTRING(email, 0, CHARINDEX('@', email, 0));

-- create an index on the email_local_part column:
CREATE INDEX ix_cust_email_local_part
ON Employees (email_local_part);

--select * from Employees
SELECT    
    Employee_Name,
    Mobile,
    Email
FROM    
    Employees
WHERE 
    email_local_part = 'sauravsharma';
