
----------------------------------------------------------
USE AdventureWorks2016
GO




---------------------------------------------------------------
--Example using GOTO

DECLARE @i INT = 1
START:
PRINT 'Current Count:  ' + CAST(@i as VARCHAR);
SET @i = @i + 1
IF @i < 11 GOTO START




---------------------------------------------------------------
--What is Easier to READ?


--GOTO Loop
DECLARE @i INT = 1
START:
PRINT 'Current Count:  ' + CAST(@i as VARCHAR);
SET @i = @i + 1
IF @i < 11 GOTO START


--WHILE Loop
DECLARE @i int = 1;
WHILE @i <= 10
BEGIN
    PRINT 'Current Count:  ' + CAST(@i as VARCHAR);
    SET @i = @i + 1
END


