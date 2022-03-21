/*---- Use Database ----*/
use sales

-- create a Table
create Table Employees
(
	Employee_Id int identity(10,1) primary key,
	Employee_Name varchar(Max),
	Mobile bigint,
	Email varchar(200),
	Address varchar(Max),
	Gender char,
	Department varchar(Max)
);

-- create a Audit Table
create table EmployeeAudit
(
	Id int,
	Inserted_By varchar(Max),
	Audit_Data varchar(Max)
);

/*--- Create Trigger for Insert ---*/
Create Trigger Trg_Insert_Employees
on Employees
For Insert
As
Begin
	Declare @Id int
	select @Id = Employee_Id from inserted
	Insert into EmployeeAudit (Id,Inserted_By,Audit_Data)
	values(@Id, ORIGINAL_LOGIN(), 
	'New Employee with Employee Id ='+ CAST(@Id as nvarchar(5))+ ' is added at '+ CAST(GETDATE() as nvarchar(20)))
End;

Insert Into Employees values('Saurav sharma',7856342378,'sauravsharma@gmail.com','Makhdumpur,Jehanabad', 'M','Software Developer');
select * from EmployeeAudit;
select * from Employees;

/**** Disable Trigger ******/
--Disable A specific Trigger
Disable Trigger Trg_Delete_Employees on Employees;

--Disable All Trigger on a Table
Disable Trigger All on Employees;

--Disable All Trigger on a Database
Disable Trigger All on Sales;

/**** Enable Trigger ******/
-- Enable A specific Trigger---
Enable Trigger Trg_Delete_Employees on Employees;

--Enable All Trigger on a Table
Enable Trigger All on Employees;

--Disable All Trigger on a Database
Enable Trigger All on Sales

/***** View Definition Of a Trigger *******/
-- Getting trigger definition by querying from a system view
SELECT 
    definition   
FROM 
    sys.sql_modules  
WHERE 
    object_id = OBJECT_ID('Trg_Insert_Employee'); 

-- Getting trigger definition using OBJECT_DEFINITION function
SELECT 
    OBJECT_DEFINITION ( OBJECT_ID('Trg_Insert_Employee')) AS trigger_definition;

-- Getting trigger definition using sp_helptext stored procedure
EXEC sp_helptext 'Trg_Insert_Employee' ;

/******** List All Triggers *********/
SELECT  
    name,
    is_instead_of_trigger
FROM 
    sys.triggers  
WHERE 
    type = 'TR';

/****** Drop a Trigger *********/
DROP TRIGGER IF EXISTS Trg_Insert_Employee;

/****** Trigger For Delete ******/
Create or Alter Trigger Trg_Delete_Employees
on Employees
For Delete
As
Begin
	Declare @Id int
	select @Id = Employee_Id from deleted
	Insert into EmployeeAudit (Id,Inserted_By,Audit_Data)
	values(@Id, ORIGINAL_LOGIN(), 
	'Employee with Employee Id ='+ CAST(@Id as nvarchar(5))+ ' is Deleted at '+ CAST(GETDATE() as nvarchar(20)))
End;

Delete from Employees where Employee_Id = 11;
select * from EmployeeAudit;
select * from Employees;

/****** Trigger No Delete Permission ******/
Create or Alter Trigger Trg_NoDelete_Employees
on Employees
For Delete
As
Begin
	rollback
	print '==================================';
	print 'You do not have permission to delete';
	print '==================================';
End;

/****** Trigger For Update ******/
-- Basic Update Trigger
Create or Alter Trigger Trg_Update_Employees
on Employees
For Update
As
Begin
	select * from deleted;
	select * from inserted;
End;

select * from EmployeeAudit;
select * from Employees
update Employees set Employee_Name = 'Saurav Kumar' where Employee_Id = 11;

-- Update Trigger audit
Create or Alter Trigger Trg_Update_Employees
on Employees
For Update
As
Begin
	Declare @Id int
	Declare @oldname nvarchar(20), @newname nvarchar(20)
	Declare @oldmobile bigint, @newmobile bigint
	Declare @oldemail nvarchar(20), @newemail nvarchar(20)
	Declare @oldaddress nvarchar(20), @newaddress nvarchar(20)
	Declare @oldgender char, @newgender char
	Declare @olddepartment nvarchar(20), @newdepartment nvarchar(20)
    Declare @auditstring nvarchar(1500)

	select * Into #TempTable From inserted
	while( Exists (select Employee_Id from #TempTable))
	begin
		set @auditstring =''
		select Top 1 @Id= Employee_Id,@newname=Employee_Name,@newmobile=Mobile,@newemail=Email,
		@newaddress=Address,@newgender=Gender,@newdepartment=Department
		from #TempTable
		select @oldname=Employee_Name,@oldmobile=Mobile,@oldemail=Email,
		@oldaddress=Address,@oldgender=Gender,@olddepartment=Department
		from deleted where Employee_id = @Id

		set @auditstring= 'Employee with Id ='+Cast(@Id as nvarchar(5))+ ' changed '
		if(@oldname <> @newname)
			set @auditstring = @auditstring + ' Name From ' +@oldname + ' to ' + @newname
		if(@oldmobile <> @newmobile)
			set @auditstring = @auditstring + ' Mobile From ' +@oldmobile + ' to ' + @newmobile
		if(@oldemail <> @newemail)
			set @auditstring = @auditstring + ' Email From ' +@oldemail + ' to ' + @newemail
		if(@oldaddress <> @newaddress)
			set @auditstring = @auditstring + ' Address From ' +@oldaddress + ' to ' + @newaddress
		if(@oldgender <> @newgender)
			set @auditstring = @auditstring + ' Gender From ' +@oldgender + ' to ' + @newgender
		if(@olddepartment <> @newdepartment)
			set @auditstring = @auditstring + ' Department From ' +@olddepartment + ' to ' + @newdepartment

		Insert into EmployeeAudit (Id,Inserted_By,Audit_Data)
	    values(@Id, ORIGINAL_LOGIN(),@auditstring)

		Delete from #TempTable where Employee_Id = @Id
	End
End

update Employees set Employee_Name = 'Saurav Sharma' where Employee_Id = 11;

/****** Instead of Insert Trigger *******/
create Table EmployeeSalary
(
	Id int identity(10,1) primary key,
	Salary Int,
	Employee_Id int FOREIGN KEY REFERENCES Employees(Employee_Id) on delete no action
);

insert into EmployeeSalary values( 10000,11)

create or alter view vwEmployeeDetail
as
select 
Employee_Name, Department, Salary 
from Employees e
join EmployeeSalary s
on
   e.Employee_Id = s.Employee_Id;

select * from EmployeeSalary
select * from Employees
select * from vwEmployeeDetail

-- Trigger 
create or alter trigger trg_InsteadInsert_EmployeeDetail
on vwEmployeeDetail
Instead of Insert
As
Begin
	Declare @Id int
	select Id=@Id from EmployeeSalary
	join inserted
	inserted.Department = EmployeeSalary

End