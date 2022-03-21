/*---- Use Database ----*/
use sales

/******* DDL Trigger *******/

-- For create Table
create Trigger Trg_SalesDB
on Database
for CREATE_TABLE
as
Begin
	rollback
	print 'you are not allowed to create a Table';
End;

create table T2(Id int);

-- For Delete Table
create Trigger Trg_SalesDBForDelete
on Database
for DROP_TABLE
as
Begin
	rollback
	print 'you are not allowed to Delete a Table';
End;

Drop table t1;

-- For Alter Table
create Trigger Trg_SalesDBForAlter
on Database
for ALTER_TABLE
as
Begin
	rollback
	print 'you are not allowed to Make Changes in a Table';
End;

Alter table t1 add Customername varchar(max);

-- DDl Trigger for All Server
create Trigger Trg_ServerScoped
on All server
for CREATE_TABLE, ALTER_TABLE, DROP_TABLE
as
Begin
	rollback
	print 'you are not allowed to do Changes on this server';
End;

create table test (id int)