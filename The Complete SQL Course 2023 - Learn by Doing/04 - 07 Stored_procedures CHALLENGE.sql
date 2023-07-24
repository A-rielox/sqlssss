

--		CHALLENGE 1

-- sp q devuelve la cantidad de un item en un warehouse


USE SAMPLEDB;
GO

SELECT * FROM oes.inventories;

--			sp
GO
CREATE PROCEDURE  oes.getQuantityOnHand
(
	@product_id  INT,
	@warehouse_id INT
)
AS
BEGIN
	SELECT 
		product_id,
		warehouse_id,
		quantity_on_hand
	FROM oes.inventories 
	WHERE	product_id = @product_id AND
			warehouse_id = @warehouse_id;
END
GO

--			llamado sp
EXEC oes.getQuantityOnHand @product_id = 4, @warehouse_id = 2;







--			CHALLENGE 2


-- Create a stored procedure called oes.getCurrentProducts that returns current products (discontinued = 0) in the oes.products table. In addition, define two input parameters:

-- - A parameter called @product_name of data type VARCHAR(100). Allow users to wildcard search on the product_name.
-- - A parameter called @max_list_price of data type DECIMAL(19,4). Allow users to only include current products that have a list_price that is less than or equal to a specified value for this parameter.

-- Execute the stored procedure to return current products that contain the word ‘Drone’ and have a maximum price of $700.



SELECT * FROM oes.products;


SELECT * FROM oes.products
WHERE	discontinued = 0 AND
		product_name LIKE '%DRONE%' AND
		list_price <= 700.00
;


--			sp
GO

CREATE PROCEDURE  oes.getCurrentProducts
(
	@product_name  VARCHAR(100),
	@max_list_price DECIMAL(19,4)
)
AS
BEGIN
	SELECT *
	FROM oes.products 
	WHERE	discontinued = 0 AND
			product_name LIKE '%' + @product_name + '%' AND
			list_price <= @max_list_price;
END
GO

--			llamado sp
EXEC oes.getCurrentProducts @product_name = 'DRONE', @max_list_price = 700;





--			CHALLENGE 3


-- Create a stored procedure called oes.transferFunds that transfers money from one bank account to another bank account by updating the balance column in the oes.bank_accounts table. Also, insert the bank transaction details into oes.bank_transactions table. Define three input parameters:

-- - @withdraw_account_id of data type INT
-- - @deposit_account_id of data type INT
-- - @transfer_amount of data type DECIMAL(30,2)

-- Test the stored procedure by transferring $100 from Anna’s bank account to Bob’s account.



SELECT * FROM oes.bank_accounts; -- A33, B25
SELECT * FROM oes.bank_transactions;

GO

DROP PROCEDURE IF EXISTS oes.transferFunds;
GO
--				Stored procedure
CREATE PROCEDURE oes.transferFunds
(
	@withdraw_account_id INT,
	@deposit_account_id INT,
	@transfer_amount DECIMAL(30,2)
)
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN
BEGIN TRANSACTION
	-- update depositante
	UPDATE oes.bank_accounts
	SET balance = balance - @transfer_amount
	WHERE account_id = @withdraw_account_id;

	-- update depositado
	UPDATE oes.bank_accounts
	SET balance = balance + @transfer_amount
	WHERE account_id = @deposit_account_id;

	-- update transaccion
	INSERT INTO oes.bank_transactions (from_account_id,	to_account_id, amount) 
		VALUES (@withdraw_account_id, @deposit_account_id, @transfer_amount);
COMMIT TRANSACTION
END

GO
--				Stored procedure END


EXEC oes.transferFunds 
	@withdraw_account_id = 1,
	@deposit_account_id  = 2,
	@transfer_amount = 100
;

SELECT * FROM oes.bank_accounts; -- A27, B31
SELECT * FROM oes.bank_transactions;



