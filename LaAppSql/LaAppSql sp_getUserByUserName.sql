USE LaAppSql;
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

	SELECT pic.* 
	FROM [AppUsers] au
	LEFT JOIN [Pictures] pic ON au.Id = pic.appUserId
	WHERE au.UserName = @userName
;

END
GO



EXEC dbo.sp_getUserByUserName @userName = 'lisa';





