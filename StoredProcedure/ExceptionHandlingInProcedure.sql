/*---- Use Database ----*/
use sales

/*---- SQL Server TRY CATCH overview ----*/
CREATE PROC sp_divide
(
    @a decimal,
    @b decimal,
    @c decimal output
) 
AS
BEGIN
    BEGIN TRY
        SET @c = @a / @b;
    END TRY
    BEGIN CATCH
        SELECT  
             ERROR_NUMBER() AS ErrorNumber  
            ,ERROR_SEVERITY() AS ErrorSeverity  
            ,ERROR_STATE() AS ErrorState  
            ,ERROR_PROCEDURE() AS ErrorProcedure  
            ,ERROR_LINE() AS ErrorLine  
            ,ERROR_MESSAGE() AS ErrorMessage;  
    END CATCH
END;
GO
--- Divide
DECLARE @r decimal;
EXEC sp_divide 10, 2, @r output;
PRINT @r;

--- Showing Exception in divide
DECLARE @r2 decimal;
EXEC sp_divide 10, 0, @r2 output;
PRINT @r2;

/*---- SQL Serer TRY CATCH with transactions ----*/
--- Create Error Report First
CREATE or Alter PROC usp_report_error
AS
    SELECT   
         ERROR_NUMBER() AS ErrorNumber  
        ,ERROR_SEVERITY() AS ErrorSeverity  
        ,ERROR_STATE() AS ErrorState  
        ,ERROR_LINE () AS ErrorLine  
        ,ERROR_PROCEDURE() AS ErrorProcedure  
        ,ERROR_MESSAGE() AS ErrorMessage;  
GO

----Now Sql Transaction
CREATE or ALTER PROC usp_delete_product
(
    @price decimal
) 
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        -- delete the person
        DELETE FROM product
        WHERE Price = @price;
        -- if DELETE succeeds, commit the transaction
        COMMIT TRANSACTION;  
    END TRY
    BEGIN CATCH
        -- report exception
        EXEC usp_report_error;       
        -- Test if the transaction is uncommittable.  
		-- XACT_STATE() function to check the state of the transaction 
		-- before performing COMMIT TRANSACTION or ROLLBACK TRANSACTION inside the CATCH block.
        IF (XACT_STATE()) = -1  
        BEGIN  
            PRINT 'Rolling back transaction';  
            ROLLBACK TRANSACTION;  
        END;          
        -- Test if the transaction is committable.  
        IF (XACT_STATE()) = 1  
        BEGIN  
            PRINT 'Committing transaction.';					 
            COMMIT TRANSACTION;     
        END;  
    END CATCH
END;

EXEC usp_delete_product @price = 4300000.78 ;

/*---- Using THROW statement to raise an exception ----*/
CREATE TABLE t1(
    id int primary key
);
BEGIN TRY
    INSERT INTO t1(id) VALUES(1);
    --  cause error
    INSERT INTO t1(id) VALUES(1);
END TRY
BEGIN CATCH
    PRINT('Raise the caught error again');
    THROW;
END CATCH

--- Executing System Stored Procedure
EXEC sys.sp_addmessage 
    @msgnum = 50010, 
    @severity = 16, 
    @msgtext =
    N'The order number %s cannot be deleted because it does not exist.', 
    @lang = 'us_english';   
GO
DECLARE @MessageText NVARCHAR(2048);
SET @MessageText =  FORMATMESSAGE(50010, N'1001');   
THROW 50010, @MessageText, 1; 

/*---- SQL Server RAISEERROR statement overview ----*/
SELECT    
    *
FROM    
    sys.messages
WHERE 
    message_id = 500050;
--- Raise System Error message 
RAISERROR ( 500050,1,1)
EXEC sp_dropmessage 
    @msgnum = 500050;  
--- raise User defined message
RAISERROR ( 'Whoops, an error occurred.',1,1)

/*--- SQL Server RAISERROR examples ---*/
DECLARE 
    @ErrorMessage  NVARCHAR(4000), 
    @ErrorSeverity INT, 
    @ErrorState    INT;
BEGIN TRY
    RAISERROR('Error occurred in the TRY block.', 17, 1);
END TRY
BEGIN CATCH
    SELECT 
        @ErrorMessage = ERROR_MESSAGE(), 
        @ErrorSeverity = ERROR_SEVERITY(), 
        @ErrorState = ERROR_STATE();
    -- return the error inside the CATCH block
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
END CATCH;



