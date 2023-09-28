----------------------------------------------------------
--Example: Count to 10
----------------------------------------------------------
USE AdventureWorks2016
GO

CREATE PROC dbo.Loop10
AS
BEGIN

	DECLARE @i int = 1;

	WHILE @i <= 10
	BEGIN
		PRINT 'Current Count:  ' + CAST(@i as VARCHAR);
		SET @i = @i + 1
	END

END
GO



EXEC dbo.Loop10;

DROP PROCEDURE IF EXISTS dbo.Loop10;
GO



----------------------------------------------------------
--GENERATE ROWS IN A TABLE Example
----------------------------------------------------------
USE AdventureWorks2016
GO


DROP PROCEDURE IF EXISTS dbo.WeekCreate;
GO

CREATE PROC dbo.WeekCreate
AS
BEGIN
	--Setup Variables 
	DECLARE @myTable TABLE(WeekNumber INT, 
						   DateStarting SMALLDATETIME) 
	 
	DECLARE @n INT = 0 
	DECLARE @firstWeek SMALLDATETIME = '12/31/2017' 
	 
	--Loop Through weeks 
	WHILE @n <= 52 
		BEGIN 
		   INSERT INTO @myTable VALUES (@n, DATEADD(wk,@n,@firstWeek)); 
		   SELECT @n = @n + 1 
		END 
	 
	--Show Results 
	SELECT	WeekNumber, 
			CONVERT(DATE, DateStarting) AS DateStarting
	FROM   @myTable 
END



EXEC dbo.WeekCreate;

DROP PROCEDURE IF EXISTS dbo.WeekCreate;
GO





----------------------------------------------------------
--BREAK AND CONTINUE
----------------------------------------------------------
USE AdventureWorks2016
GO


DROP PROCEDURE IF EXISTS dbo.WeekCreateWithBreak;
GO

CREATE PROC dbo.WeekCreateWithBreak
AS
BEGIN
	--Setup Variables 
	DECLARE @myTable TABLE(WeekNumber int, 
						   DateStarting smalldatetime) 
	 
	DECLARE @n int = 0 
	DECLARE @firstWeek smalldatetime = '12/31/2017' 
	 
	--Loop Through weeks 
	WHILE 1 = 1
	BEGIN 
	   INSERT INTO @myTable VALUES (@n, DATEADD(wk,@n,@firstWeek)); 
	   SELECT @n = @n + 1
	 
		IF @n > 52 BREAK; -- Exit if we have gone too far	 
	END 
	 
	--Show Results 
	SELECT WeekNumber, DateStarting 
	FROM   @myTable
END



EXEC dbo.WeekCreateWithBreak;

DROP PROCEDURE IF EXISTS dbo.WeekCreateWithBreak;
GO


