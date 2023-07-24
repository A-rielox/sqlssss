
USE SAMPLEDB
GO

-- Begin a new Transaction:
BEGIN TRANSACTION;

	-- Declare a variable called @new_product_id that will hold the new product_id value:
	DECLARE @new_product_id INT; 

	-- Insert the new product. The product_id value is generated by the IDENTITY property:
	INSERT INTO oes.products (product_name, category_id, list_price, discontinued)
	 VALUES ('PBX Printer', 7, 45.99, 0);

	-- The SCOPE_INDENTITY() function returns the last value inserted into the IDENTITY column:
	SET @new_product_id = SCOPE_IDENTITY(); 

	-- Insert the inventory information for the new product:
	INSERT INTO oes.inventories (product_id, warehouse_id, quantity_on_hand)
		VALUES	(@new_product_id, 1, 100),
				(@new_product_id, 4, 35);

-- Commit the changes. The commit will only happen if all statements within the transaction are successful:
COMMIT TRANSACTION;
