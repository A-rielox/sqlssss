USE LaAppSql;
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
	WHERE userName = @userName
;

END
GO



EXEC dbo.sp_getUserByUserNameStore @userName = 'lisa';





