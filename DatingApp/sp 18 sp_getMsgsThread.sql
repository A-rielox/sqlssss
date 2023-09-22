USE DatingSql;
GO

DROP PROCEDURE IF EXISTS dbo.sp_getMsgsThread;
GO

CREATE PROCEDURE dbo.sp_getMsgsThread
(
	@currentUserName VARCHAR(50), -- el que esta logeado
	@recipientUserName VARCHAR(10) -- la persona que mira en los mensajes
)
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN

	-- ids de msgs
	DECLARE @msgsIds TABLE(msgId INT);
	-- ids de usuarios en msgs
	DECLARE @usersIds TABLE(sUserId INT, rUserId INT);
	-- id de fotos de usuarios en msg
	DECLARE @usersMainPhotosId TABLE(photoId INT);
	-- id de msgs no leidos
	DECLARE @unreadMsgs TABLE(msgId INT);


	
	INSERT INTO @msgsIds
	SELECT id
	FROM Msgs
	WHERE	(
				RecipientUsername = @currentUserName AND 
				RecipientDeleted = 0 AND
				SenderUsername = @recipientUserName		-- el q recibe soy yo _Y_ el q envia es el
			) OR
			(
				RecipientUsername = @recipientUserName AND 
				SenderDeleted = 0 AND
				SenderUsername = @currentUserName		-- el q recibe es el _Y_ el q envia soy yo
			);

	-- lleno @usersIds
	INSERT INTO @usersIds
	SELECT SenderId, RecipientId
	FROM Msgs
	WHERE id IN (
		SELECT msgId FROM @msgsIds
	);


	-- lleno @usersMainPhotosId ( puedo quitar este paso y mandar directo las fotos )
	INSERT INTO @usersMainPhotosId
	SELECT id
	FROM Photos
	WHERE 
	(
		appUserId IN (
			SELECT sUserId FROM @usersIds
		) OR appUserId IN (
			SELECT rUserId FROM @usersIds
		)
	)
	AND isMain = 1;


	-- actualizando mensajes no leidos
	UPDATE dbo.Msgs
	SET DateRead = GETDATE()
	WHERE	id IN (
				SELECT msgId FROM @msgsIds
			) AND
			DateRead IS NULL AND 
			RecipientUsername = @currentUserName;


	-- los mensajes
	SELECT * 
	FROM Msgs
	WHERE id IN (
		SELECT msgId FROM  @msgsIds
	)
	ORDER BY MessageSent DESC;


	-- las fotos
	SELECT * 
	FROM Photos
	WHERE id IN (
		SELECT photoId FROM @usersMainPhotosId
	)

END
GO


--
EXEC dbo.sp_getMsgsThread	@currentUserName = 'lisa',
							@recipientUserName = 'todd'
;

--SELECT * FROM Msgs;
SELECT * FROM Photos
WHERE appUserId IN (1, 6);
