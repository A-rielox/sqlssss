


---------------------------------------------------------------
-- Calculate @velocity = @distance / @time
DECLARE @velocity FLOAT;
DECLARE @distance FLOAT = 120.0;
DECLARE @time FLOAT = 45;

IF @time = 0.0 RETURN -- cannot divide by zero!
SET @velocity = @distance / @time
SELECT @velocity;

