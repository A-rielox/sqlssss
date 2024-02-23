USE DatingAppSql21012024;
GO

DROP PROCEDURE IF EXISTS dbo.sp_getLike;
GO

CREATE PROCEDURE dbo.sp_getLike
(
	@sourceUserId INT,
	@targetUserId INT
)
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN

	SELECT * 
	FROM Likes
	WHERE	SourceUserId = @sourceUserId AND
			TargetUserId = @targetUserId
;

END
GO



EXEC dbo.sp_getLike @sourceUserId = 3,
					@targetUserId = 2
;

SELECT * FROM Likes;

--TRUNCATE TABLE DatingAppSqlS.dbo.Users;