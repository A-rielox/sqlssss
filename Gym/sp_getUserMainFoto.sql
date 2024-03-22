USE Gym;
GO

DROP PROCEDURE IF EXISTS dbo.sp_getUserMainFoto;
GO

CREATE PROCEDURE dbo.sp_getUserMainFoto
(
	@userName VARCHAR(50)
)
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN

	SELECT *
	FROM [AppUsers]
	WHERE userName = @userName;

	SELECT pic.*
	FROM [AppUsers] au
	LEFT JOIN [Pictures] pic ON  au.Id = pic.appUserId
	WHERE	userName = @userName
			AND pic.isMain = 1
;

END
GO



EXEC dbo.sp_getUserMainFoto @userName = 'lisa';
