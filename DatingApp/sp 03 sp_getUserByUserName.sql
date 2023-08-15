USE DatingAppSqlS;
GO

DROP PROCEDURE IF EXISTS dbo.sp_getUserByUserName;
GO

CREATE PROCEDURE dbo.sp_getUserByUserName
(
	@userName VARCHAR(50)
)
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN

	SELECT *
	FROM dbo.Users
	WHERE userName = @userName
;

END
GO



EXEC dbo.sp_getUserByUserName @userName = 'bob';





