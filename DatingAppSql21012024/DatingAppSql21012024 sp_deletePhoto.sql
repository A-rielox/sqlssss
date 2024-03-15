USE DatingAppSql21012024;
GO

DROP PROCEDURE IF EXISTS dbo.sp_deletePhoto;
GO

CREATE PROCEDURE dbo.sp_deletePhoto
(
	@photoId INT
)
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN

	DELETE FROM [dbo].[Photos]
	WHERE id = @photoId

	SELECT @@ROWCOUNT;
;

END
GO

--IF @@ROWCOUNT = 0
--BEGIN
--       mandar algo
--END

EXEC dbo.sp_deletePhoto	@photoId = 173
