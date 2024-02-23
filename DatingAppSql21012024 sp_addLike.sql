USE DatingAppSql21012024;
GO

DROP PROCEDURE IF EXISTS dbo.sp_addLike;
GO

CREATE PROCEDURE dbo.sp_addLike
(
	@sourceUserId INT,
	@targetUserId INT
)
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN

	-- // antes de meterlo checo que no exista previamente el mismo like, asi q no debe mandar error, pero...
	BEGIN TRY
	
		INSERT INTO [dbo].[Likes] (SourceUserId, TargetUserId)
		VALUES	(@sourceUserId, @targetUserId);

		SELECT @@ROWCOUNT;

	END TRY
	BEGIN CATCH

		SELECT 0;

	END CATCH
;

END
GO



EXEC dbo.sp_addLike @sourceUserId = 3,
					@targetUserId = 1
;

SELECT * FROM Likes;

--TRUNCATE TABLE DatingAppSqlS.dbo.Users;