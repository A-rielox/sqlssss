USE AdventureWorks2016  
GO  

DROP PROCEDURE IF EXISTS dbo.uspCalcArea
GO

--Calculate Area
CREATE PROCEDURE uspCalcArea
                 @height FLOAT,
                 @width FLOAT,
                 @area FLOAT OUTPUT
AS
BEGIN
      -- SET NOCOUNT to ON to no longer display the count message.
	SET NOCOUNT ON;
	SET @area = @height * @width;
END





DECLARE @result FLOAT;
EXECUTE uspCalcArea 11.0, 
					20.0, 
					@result OUTPUT; --	 **		 NO es necesario q se llame = a como esta definido en el sp

PRINT 'The Area is ' + CAST(@result as VARCHAR);
go


DROP PROCEDURE IF EXISTS dbo.uspCalcArea
GO



-- Example with two output Parameters

--Create Full Name


USE AdventureWorks2016  
GO  

DROP PROCEDURE IF EXISTS dbo.uspFullName
GO

CREATE PROCEDURE uspFullName
					@first NVARCHAR(40),
					@last NVARCHAR(40),
					@full NVARCHAR(80) OUTPUT,
					@initials NVARCHAR(4) OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	IF LEN(@first) > 0
		BEGIN
			SET @full = @first + ' ' + @last;
			SET @initials = LEFT(@first,1) + LEFT(@last,1);
		END;
	ELSE
		BEGIN
			SET @full = @last;
			SET @initials = LEFT(@last,1);
		END;
END
GO



DECLARE @full NVARCHAR(80)
DECLARE @initials NVARCHAR(10)

EXECUTE uspFullName 'Michael',
					'Jordan',
					@full OUTPUT,
					@initials OUTPUT

PRINT 'Full Name: ' + @full;
PRINT ' Initials: ' + @initials;




DROP PROCEDURE IF EXISTS dbo.uspFullName