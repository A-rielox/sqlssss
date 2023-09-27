----------------------------------------------------------
USE AdventureWorks2016
GO




---------------------------------------------------------------
--EXAMPLE – Wait for DELAY
PRINT CONVERT(VARCHAR, GETDATE(), 109);
WAITFOR DELAY '00:00:05' -- hh:mm:ss
PRINT CONVERT(VARCHAR, GETDATE(), 109);


--EXAMPLE WAITFOR TIME
PRINT CONVERT(VARCHAR, GETDATE(), 109);
WAITFOR TIME '14:53:10' -- enter time close to when you run this as hh:mm:ss
PRINT CONVERT(VARCHAR, GETDATE(), 109);


--Example Monitor Database LOG Growth
DECLARE @row INT = 1;
DECLARE @i INT = 1;

WHILE @i <= 10
BEGIN
	SELECT @row = COUNT(*) FROM DatabaseLog;
	WAITFOR DELAY '00:00:01'; -- Five Second Delay
	PRINT 'Row Count: ' + CAST(@row as VARCHAR);
	SET @i = @i + 1
END

