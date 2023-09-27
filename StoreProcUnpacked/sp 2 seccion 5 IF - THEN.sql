---------------------------------------------------------------
--Example 1 – IF
DECLARE @weight FLOAT;
DECLARE @totalPrice FLOAT;
DECLARE @pricePerPound FLOAT;

SET @weight = 0;
SET @totalPrice = 10.98;

IF @weight = 0
	BEGIN
		PRINT 'Weight is 0, this is not allowed, changing weight to 1';
		SET @weight = 1.0;
	END

SET @pricePerPound = @totalPrice / @weight
PRINT 'The price per pound is ' + CAST(@pricePerPound as NVARCHAR)

---------------------------------------------------------------
--Example 2 – IF ELSE
DECLARE @weight FLOAT;
DECLARE @totalPrice FLOAT;
DECLARE @pricePerPound FLOAT;

SET @weight = 2.5;
SET @totalPrice = 10.98;

IF @weight = 0
	BEGIN
		PRINT 'Weight is 0, this is not allowed, changing weight to 1';
		SET @weight = 1.0;
	END
ELSE
	BEGIN
		Print 'Valid weight entered, calculating price per pound.'
	END

SET @pricePerPound = @totalPrice / @weight
PRINT 'The price per pound is ' + CAST(@pricePerPound as NVARCHAR)

---------------------------------------------------------------
--Example 3 – No Code Blocks
DECLARE @weight FLOAT;
DECLARE @totalPrice FLOAT;
DECLARE @pricePerPound FLOAT;

SET @weight = 2.5;
SET @totalPrice = 10.98;

IF @weight = 0
	BEGIN
		PRINT 'Weight is 0, this is not allowed, changing weight to 1';
		SET @weight = 1.0;
	END
ELSE
	Print 'Valid weight entered, calculating price per pound.'

SET @pricePerPound = @totalPrice / @weight
PRINT 'The price per pound is ' + CAST(@pricePerPound as NVARCHAR)

---------------------------------------------------------------
--EXAMPLE 4 – Nested Ifs
--											** las extras p' hacerlas sp
CREATE PROC dbo.CalcPricePerPound		-- **
AS										-- **
BEGIN									-- **
	DECLARE @weight FLOAT;
	DECLARE @totalPrice FLOAT;
	DECLARE @pricePerPound FLOAT;

	SET @weight = 2.5;
	SET @totalPrice = 10.98;

	IF @weight = 0
		BEGIN
			PRINT 'Weight is 0, this is not allowed, changing weight to 1';
			SET @weight = 1.0;
			IF @totalPrice > 100
				BEGIN
					PRINT 'Total Price too large, setting to 100.';
					SET @totalPrice = 100;
				END
		END
	ELSE
		BEGIN
			Print 'Valid weight entered, calculating price per pound.'
			IF @totalPrice > 100
				BEGIN
					PRINT 'Total Price too large, setting to 100.';
					SET @totalPrice = 100;
				END
		END

	SET @pricePerPound = @totalPrice / @weight
	PRINT 'The price per pound is ' + CAST(@pricePerPound as NVARCHAR)
END									-- **


-- ========================================
-- p' sacar el IF repetido




---------------------------------------------------------------
--EXAMPLE 4 – Nested Ifs
--											** las extras p' hacerlas sp
CREATE PROC dbo.CalcPricePerPound		-- **
AS										-- **
BEGIN									-- **
	DECLARE @weight FLOAT;
	DECLARE @totalPrice FLOAT;
	DECLARE @pricePerPound FLOAT;

	SET @weight = 2.5;
	SET @totalPrice = 10.98;

	IF @weight = 0
		BEGIN
			PRINT 'Weight is 0, this is not allowed, changing weight to 1';
			SET @weight = 1.0;
		--	IF @totalPrice > 100
		--		BEGIN
		--			PRINT 'Total Price too large, setting to 100.';
		--			SET @totalPrice = 100;
		--		END
		END
	ELSE
		BEGIN
			Print 'Valid weight entered, calculating price per pound.'
			--IF @totalPrice > 100
			--	BEGIN
			--		PRINT 'Total Price too large, setting to 100.';
			--		SET @totalPrice = 100;
			--	END
		END

	--
	IF @totalPrice > 100
		BEGIN
			PRINT 'Total Price too large, setting to 100.';
			SET @totalPrice = 100;
		END
	--

	SET @pricePerPound = @totalPrice / @weight
	PRINT 'The price per pound is ' + CAST(@pricePerPound as NVARCHAR)
END									-- **





