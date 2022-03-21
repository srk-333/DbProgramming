/*---- Use Database ----*/
use sales

/*--- Cursor in SQL server ---*/
DECLARE 
    @product_name VARCHAR(200), 
    @price   DECIMAL,
	@NetPay Decimal,
	@Category Varchar(200);
DECLARE cursor_product CURSOR FOR SELECT 
	Product_name, Price, NetPay, Category
FROM 
    product;

-- open Cursor
OPEN cursor_product;

-- Fetch Each Row From Cursor
FETCH NEXT FROM cursor_product INTO 
    @product_name, 
    @price,
	@NetPay,
	@Category ;

-- Use while loop to fetch Each Row From Cursor
WHILE @@FETCH_STATUS = 0
    BEGIN
        print concat('Product Name: ', @product_name);
		print concat('Product Price: ', @price);
		print concat('Product NetPay: ', @NetPay);
		print concat('Product Category: ', @Category);
		print '============================';
        FETCH NEXT FROM cursor_product INTO 
            @product_name, 
            @price,
			@NetPay,
			@Category ;
    END;
-- Close Cursor 
CLOSE cursor_product;
--Release Cursor from Memory
DEALLOCATE cursor_product;