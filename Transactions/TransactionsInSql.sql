/*---- Use Database ----*/
use sales

--Create Table For Transactions
Create Table EmployeeTrans
(
	Id int primary key,
	Department int,
	Age int,
	Salary int
);

-- Insert Some Data
Insert into EmployeeTrans 
values(101, 2, 23, 30000),(102, 1, 32, 40000),(103, 3, 53, 130000);

-- view Data
Select * from EmployeeTrans

/******* Implicit Transactions *********/
-- Commit Transaction if All query Works fine --
Set Implicit_Transactions On
--Insert
Insert into EmployeeTrans (Id,Department,Age,Salary)
values(103, 2, 23, 30000)
-- Update
Update EmployeeTrans set Salary=45000 where Id= 102
-- Delete 
Delete From EmployeeTrans where Id = 103
Select @@TRANCOUNT as OpenTransactions
commit
Select @@TRANCOUNT as OpenTransactions

/*-- Rollaback Transaction if any one query in Transaction Fails--*/
Set IMPLICIT_TRANSACTIONS On
--Insert
Insert into EmployeeTrans (Id,Department,Age,Salary)
values(104, 2, 23, 30000); --this will fail bcz of primary key Conflicts
-- Update
Update EmployeeTrans set Salary=45000 where Id= 102;
-- Delete 
Delete EmployeeTrans where Id = 106;

Select @@TRANCOUNT as OpenTransactions
Rollback

Select @@TRANCOUNT as OpenTransactions

/*-- Transaction Using Variable --*/
Set IMPLICIT_TRANSACTIONS On
--Insert
Insert into EmployeeTrans (Id,Department,Age,Salary)
values(104, 2, 23, 30000); --this will fail bcz of primary key Conflicts
-- Update
Update EmployeeTrans set Salary=45000 where Id= 102;
-- Delete 
Delete EmployeeTrans where Id = 102;

Declare @choice int
set @choice = 1 -- @choice=1 commit the changes, @choice=0 rollback Changes
if @choice = 1
begin	
	commit
end
else
begin
	rollback
end;

/********* Explicit Transactions *******/
-- For Commit
Begin Transaction
--Insert
Insert into EmployeeTrans (Id,Department,Age,Salary)
values(105, 4, 23, 130000); --this will fail bcz of primary key Conflicts
-- Update
Update EmployeeTrans set Salary=45000 where Id= 104;
-- Delete 
Delete EmployeeTrans where Id = 104;

Declare @ch int
set @ch = 1 -- @choice=1 commit the changes, @choice=0 rollback Changes
if @ch = 1
begin	
	commit
end
else
begin
	rollback
end;

-- For Rollback
Begin Transaction
--Insert
Insert into EmployeeTrans (Id,Department,Age,Salary)
values(106, 5, 43, 10000); --this will fail bcz of primary key Conflicts
-- Update
Update EmployeeTrans set Salary=45000 where Id= 104;
-- Delete 
Delete EmployeeTrans where Id = 104;

Declare @che int
set @che = 0 -- @choice=1 commit the changes, @choice=0 rollback Changes
if @che = 1
begin	
	commit
end
else
begin
	rollback
end;

/****** SavePoint Command in Transactions *****/
Begin Transaction
Insert into EmployeeTrans (Id,Department,Age,Salary)
values(105, 5, 43, 10000),(106, 4, 33, 13000),(107, 6, 46, 100000); 
SAVE TRANSACTION deletepoint
Delete EmployeeTrans where Id = 101;
Delete EmployeeTrans where Id = 104;
Rollback Transaction deletepoint
Commit

/** Transaction using Stored procedure ***/
create or alter proc TransactionsProcedure
as
Begin
	Begin Transaction
	Begin Try
		Insert into EmployeeTrans values(105, 5, 43, 10000);
		Delete EmployeeTrans where Id = 104;
		Commit Transaction
	End Try
	Begin Catch
		rollback Transaction
	End Catch
End;
select * from EmployeeTrans
Exec TransactionsProcedure

