USE DatingAppSql21012024;
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
	FROM dbo.[AppUsers]
	WHERE userName = @userName;

	SELECT ph.* 
	FROM [AppUsers] au
	LEFT JOIN [Photos] ph ON au.Id = ph.appUserId
	WHERE au.UserName = @userName
;

END
GO



EXEC dbo.sp_getUserByUserName @userName = 'lisa';





