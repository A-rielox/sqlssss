USE DatingAppSql21012024;
GO

DROP PROCEDURE IF EXISTS dbo.sp_getUserByUserNameStore;
GO

CREATE PROCEDURE dbo.sp_getUserByUserNameStore
(
	@userName VARCHAR(50)
)
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN

	SELECT *
	FROM dbo.AppUsers
	WHERE userName = @userName;

	--SELECT ph.*
	--FROM [dbo].[Photos] ph
	--LEFT JOIN [dbo].[AppUsers] au ON ph.appUserId = au.Id
	--WHERE	au.UserName = @userName
	--		and ph.isMain = 1
END
GO



EXEC dbo.sp_getUserByUserNameStore @userName = 'lisa';





