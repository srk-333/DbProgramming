/*---- Use Database ----*/
use sales

/*---- Begin End Control Flow ----*/
create procedure FindProduct(@min_price DECIMAL)
AS
BEGIN
    SELECT
        Product_Name,
        Price
    FROM 
       product
    WHERE
        Price >= @min_price
    ORDER BY
        Price;
END;

Alter procedure FindProduct(@min_price DECIMAL)
AS
BEGIN
    SELECT
        Product_Name,
        Price
    FROM 
       product
    WHERE
        Price > @min_price
    ORDER BY
        Price;
	IF @@ROWCOUNT = 0
        PRINT 'No product with this price found';
END;

/*---- Nesting Begin End Control Flow ----*/
BEGIN
    DECLARE @name VARCHAR(MAX);
    SELECT TOP 1
        @name = product_name
    FROM
        product
    ORDER BY
        price DESC;   
    IF @@ROWCOUNT <> 0
    BEGIN
        PRINT 'The most expensive product is ' + @name
    END
    ELSE
    BEGIN
        PRINT 'No product found';
    END;
END

/*---- If Control Flow ----*/
BEGIN
    DECLARE @totalprice decimal;
    SELECT 
        @totalprice = SUM(price)
    FROM
        product
    SELECT @totalprice;
	IF @totalprice > 100000
    BEGIN
        PRINT 'Great! The total price is greater than 100000';
    END
END

/*---- If Else Control Flow ----*/
BEGIN
    DECLARE @totalprice2 decimal;
    SELECT 
        @totalprice2 = SUM(price)
    FROM
        product
	IF @totalprice2 > 10000000
    BEGIN
        PRINT 'Great! The total price is greater than 100000';
    END
	Else
	BEGIN
		PRINT 'The total price is not greater than 10000000';
	END
END

/*---- Nested If Else Control Flow ----*/
BEGIN
    DECLARE @x INT = 10,
            @y INT = 20;

    IF (@x > 0)
    BEGIN
        IF (@x < @y)
            PRINT 'x > 0 and x < y';
        ELSE
            PRINT 'x > 0 and x >= y';
    END			
END

/*---- While Control Flow ----*/
DECLARE @counter INT = 1;
WHILE @counter <= 11
BEGIN
    PRINT @counter;
    SET @counter = @counter + 1;
END

/*---- Use Cotinue in While Loop ----*/
DECLARE @counter2 INT = 1;
WHILE @counter2 <= 5
BEGIN  
    SET @counter2 = @counter2 + 1;
	IF @counter2 = 3
		Continue;
	 PRINT @counter2;
END

/*---- Use Break in While Loop ----*/
DECLARE @num INT = 0;
WHILE @num <= 10
BEGIN  
    SET @num = @num +1;
	IF @num = 6
		Break;
	 PRINT @num;
END
