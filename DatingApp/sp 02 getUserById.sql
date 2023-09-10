USE DatingSql;
GO

DROP PROCEDURE IF EXISTS dbo.sp_getUserById;
GO

CREATE PROCEDURE dbo.sp_getUserById
(
	@userId INT
)
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN

	SELECT *
	FROM dbo.Users
	WHERE id = @userId
;

END
GO



EXEC dbo.sp_getUserById @userId = 12;




