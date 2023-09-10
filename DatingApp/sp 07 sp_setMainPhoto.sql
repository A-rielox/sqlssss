USE DatingSql;
GO

DROP PROCEDURE IF EXISTS dbo.sp_setMainPhoto;
GO

CREATE PROCEDURE dbo.sp_setMainPhoto
(
	@oldMainId INT,
	@newMainId INT
)
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRANSACTION;

	DECLARE @RowCount int;

	UPDATE [dbo].[Photos]
	SET isMain = 0
	WHERE id = @oldMainId;

	SET @RowCount = @@ROWCOUNT;

	UPDATE [dbo].[Photos]
	SET isMain = 1
	WHERE id = @newMainId;

	SET @RowCount = @RowCount + @@ROWCOUNT;
;
	
	IF @RowCount = 2
	BEGIN
		SELECT @RowCount;
		COMMIT TRANSACTION;
	END
		
	ELSE
	BEGIN
		SELECT @RowCount;
		ROLLBACK TRANSACTION
	END

GO

--IF @@ROWCOUNT = 0
--BEGIN
--       mandar algo
--END

EXEC dbo.sp_setMainPhoto	@oldMainId = 20,
							@newMainId = 23;
