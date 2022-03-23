/*---- Use Database ----*/
use sales

---create EmployeeData table---
CREATE TABLE EmployeeRecords
(
EmpID int,
EmpName varchar(20),
City varchar(20),
salary decimal 
);

--Insert Some records
insert into EmployeeRecords 
values
(1,'Swaram Rajput','Kishanganj',30000),
(4,'Tejas Chatopadhay','Gaya',35000),
(5,'Sunita Kolambi','Patna',50000),
(6,'Suraj Jahagirdar','Delhi',45000);

--View Records
select*from EmployeeRecords

/**** TableValued Functions *****/
CREATE Or ALTER FUNCTION Fun_Employee
(
	@City varchar(50)
)
returns table
as
return
select * from EmployeeRecords
where city = @City;

--View Records using Function
select *from Fun_Employee('Delhi')

-- Remove a function
drop function if exists Fun_EmployeeInformation

/******* Scalar Function *******/
CREATE FUNCTION ScalarFun
(
	@EmpName varchar(20),
	@city varchar(20)
)
returns nvarchar(100)
as
begin 
	return(select @EmpName +' '+@city+ ' ')
end

select dbo.ScalarFun('Rohit','gaya')  Details 

---scalar function---
CREATE FUNCTION Salaryincreament
(
	@EmpName varchar(20),
	@salary decimal(20)
)
returns nvarchar(100)
as
begin 
	return(Select @EmpName+' '+(@salary+3000)+' ')
end

---Alter Scalar Function ---
Alter FUNCTION Salaryincreament
(
	@salary decimal(20)
)
returns nvarchar(100)
as
begin
	return (select @salary+3000)
end

select dbo.Salaryincreament1('5000') deatails

----A NUMERIC SCALR FUNCTION ---
CREATE FUNCTION NumFun
(
		 @NUM1 DECIMAL(20),
		 @NUM2 DECIMAL(20)
)
RETURNS DECIMAL(20)
AS
BEGIN
	DECLARE @Result DECIMAL(20)
	SET @Result=@NUM1+@NUM2
	RETURN @Result
END

SELECT dbo.NumFun(20,23) addition

--SystemFunction--
--avg,min,max,count,Sum--
select 
sum(salary) as 'TotalSalary',
avg(salary) as 'Avg Salary' ,
min(salary) as 'Min Salary', 
max(salary) as 'Max Salary', 
count(EmpID) as 'total workers' 
from EmployeeRecords
