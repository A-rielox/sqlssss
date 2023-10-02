USE AdventureWorks2016  
GO  


CREATE PROCEDURE dbo.LogWrite (
    @LogName VARCHAR(255), 
    @LogMessage NVARCHAR(MAX)
)
AS
BEGIN

    IF object_id('dbo.Log', 'U') IS NULL -- 'U' p'q busque un dbo.Log que sea 'User defined'. ( si es true retorna el object id )
	BEGIN
        --create the log table for the first time
        CREATE TABLE dbo.Log
        (
            LogName VARCHAR(255) NOT NULL,
            LogDate DATETIME NOT NULL,
            LogMessage NVARCHAR(MAX) NULL
        )
        CREATE INDEX IdxLogNameLogDate ON dbo.Log (LogName, LogDate)
    END

    DECLARE @now AS DATETIME = GETDATE()
    INSERT INTO dbo.Log (LogName, LogDate, LogMessage)
           VALUES (@LogName, @now, @LogMessage)
           
END


-----

EXEC dbo.LogWrite 'TEST', 'Test message'

SELECT * FROM
dbo.Log;
