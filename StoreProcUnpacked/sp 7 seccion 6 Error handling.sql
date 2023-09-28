USE AdventureWorks2016
GO

-- CON ESTE SE HACIA ANTES EL ERROR CHECKING
--  @@ERROR  --> manda 0 si no hay errores
-- se resetea despues de c/ statement , asi q hay q checarlo tras c/ statement




--The error number reported is the message_id from Sys.messages
SELECT TOP 20 *
  FROM sys.messages


--Use AdventureWorks2017
USE AdventureWorks2016  
GO  
UPDATE HumanResources.EmployeePayHistory  
    SET PayFrequency = 4  
    WHERE BusinessEntityID = 1;  
IF @@ERROR = 547  
    PRINT N'A check constraint violation occurred.';  
GO  


-- ==============================
-- ==============================

--Example 1
USE AdventureWorks2016  
GO  

CREATE PROC dbo.DivideByZeroExample
AS
BEGIN
	PRINT 'Stored Procedure Starts'


	BEGIN TRY  
		-- Generate divide-by-zero error.  
		SELECT 1/0;  
	END TRY  
	BEGIN CATCH  
		SELECT  
			ERROR_NUMBER() AS ErrorNumber  
			,ERROR_SEVERITY() AS ErrorSeverity  
			,ERROR_STATE() AS ErrorState  
			,ERROR_PROCEDURE() AS ErrorProcedure  
			,ERROR_LINE() AS ErrorLine  
			,ERROR_MESSAGE() AS ErrorMessage;
		PRINT 'Divide By Zero Error!'
	END CATCH

	PRINT 'Stored Procedure Complete'

END
GO

--Example 2
USE AdventureWorks2016  
GO  


CREATE PROC dbo.GetAverageEmployeeVacationHours
AS

BEGIN TRY  
	DECLARE @TotalHours FLOAT, 
			@TotalEmployees FLOAT,
			@AVGHours FLOAT


	SELECT @TotalHours =  SUM(VacationHours)
	FROM HumanResources.Employee;

	SELECT @TOTALEmployees = COUNT(*)
	FROM HumanResources.Employee
	WHERE HireDate > '2020-01-01' -- ---> p' lanzar el error

	SET @AVGHours = @TotalHours / @TotalEmployees;
	PRINT 'Average Vacation Hours For Employees Are:  ' + CAST(@AVGHours as VARCHAR);
END TRY

BEGIN CATCH  
    PRINT N'Error Procedure = ' + ERROR_PROCEDURE() 
    PRINT N'Error State = ' + CAST(ERROR_STATE() AS VARCHAR)
    PRINT N'Error Severity = ' + CAST(ERROR_SEVERITY() AS VARCHAR)	
    PRINT N'Error Message = ' + ERROR_MESSAGE()
    PRINT N'Error Number = ' + CAST(ERROR_NUMBER() AS VARCHAR)
    PRINT N'Error Line = ' + CAST(ERROR_LINE() AS VARCHAR) 
END CATCH;


EXEC dbo.GetAverageEmployeeVacationHours;


DROP PROCEDURE IF EXISTS dbo.GetAverageEmployeeVacationHours
GO


