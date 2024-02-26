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



SELECT * FROM [AppUsers];
SELECT li.*, auS.KnownAs, auT.KnownAs FROM Likes li
LEFT JOIN AppUsers auS ON li.SourceUserId = auS.Id
LEFT JOIN AppUsers auT ON li.TargetUserId = auT.Id

--TRUNCATE TABLE DatingAppSqlS.dbo.Users;