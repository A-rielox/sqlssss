USE DatingAppSql21012024;
GO

DROP PROCEDURE IF EXISTS dbo.sp_deleteMsg;
GO

CREATE PROCEDURE dbo.sp_deleteMsg
(
	@msgId INT,
	@userNameDeleting VARCHAR(50)
)
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN
	-- en api checo que sea el sender o recipient quien borra
	DECLARE @RowCount int;

	IF ( SELECT SenderUsername FROM Msgs WHERE id = @msgId ) = @userNameDeleting
		BEGIN
			UPDATE dbo.Msgs
			SET SenderDeleted = 1
			WHERE id = @msgId;

			SET @RowCount = @@ROWCOUNT;
		END
	--ELSE
	IF ( SELECT RecipientUsername FROM Msgs WHERE id = @msgId ) = @userNameDeleting
		BEGIN
			UPDATE dbo.Msgs
			SET RecipientDeleted = 1
			WHERE id = @msgId;

			SET @RowCount = @@ROWCOUNT;
		END

	-- borrando
	IF	( SELECT SenderDeleted FROM [Msgs] WHERE id = @msgId ) = 1 AND
		( SELECT RecipientDeleted FROM [Msgs] WHERE id = @msgId ) = 1
		BEGIN
			DELETE FROM [dbo].[Msgs]
			WHERE id = @msgId

			SET @RowCount = @RowCount + @@ROWCOUNT;
		END

	SELECT @RowCount;
;

END
GO

-- manda 0 si no existe msg,
-- 1 si solo edita y no borra ( si el mismo manda a borrar, el front no deja tambien va a mandar 1 )
-- 2 si edita y borra
-- null si se manda un user q no es ni el sender ni el recipient


SELECT * FROM [Msgs]
WHERE id = 13;

EXEC dbo.sp_deleteMsg	@msgId = 13,
						@userNameDeleting = 'Mayo'
;

SELECT * FROM [Msgs]
WHERE id = 13;

/*

USE DatingAppSql21012024;
GO

DROP PROCEDURE IF EXISTS dbo.sp_deleteMsg;
GO

CREATE PROCEDURE dbo.sp_deleteMsg
(
	@msgId INT,
	@userNameDeleting VARCHAR(50)
)
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN
	-- en api checo que sea el sender o recipient quien borra
	DECLARE @RowCount int;

	IF (SELECT SenderUsername FROM Msgs WHERE id = @msgId ) = @userNameDeleting
		BEGIN
			UPDATE dbo.Msgs
			SET SenderDeleted = 1
			WHERE id = @msgId;

			SET @RowCount = @@ROWCOUNT;
		END
	ELSE
		BEGIN
			UPDATE dbo.Msgs
			SET RecipientDeleted = 1
			WHERE id = @msgId;

			SET @RowCount = @@ROWCOUNT;
		END

	-- sacando quien(es) ha borrado
	DECLARE @erasedBy TABLE(erasedBySender BIT, erasedByRecipient BIT);

	INSERT INTO @erasedBy
	SELECT SenderDeleted, RecipientDeleted
	FROM Msgs
	WHERE id = @msgId;

	-- borrando
	IF	(SELECT erasedBySender FROM @erasedBy) = 1 AND
		(SELECT erasedByRecipient FROM @erasedBy) = 1
		BEGIN
			DELETE FROM [dbo].[Msgs]
			WHERE id = @msgId

			SET @RowCount = @RowCount + @@ROWCOUNT;
		END

	SELECT @RowCount;
;

END
GO


*/
