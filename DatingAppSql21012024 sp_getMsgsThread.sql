USE DatingAppSql21012024;
GO

DROP PROCEDURE IF EXISTS dbo.sp_getMsgsThread;
GO

CREATE PROCEDURE dbo.sp_getMsgsThread
(
	@currentUserName VARCHAR(50),		-- el que esta logeado
	@recipientUserName VARCHAR(10)		-- msgs del q esta logeado con este user
)
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN

	-- los mensajes
	select * from [Msgs]
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

	-- las fotos
	SELECT distinct XD.* 
	FROM [Msgs] ms
	CROSS APPLY (
		SELECT * FROM [Photos] ph
		WHERE	ph.isMain = 1
				AND (
						ms.SenderId = ph.appUserId
						OR ms.RecipientId = ph.appUserId
					)
	) XD
	WHERE	(
				RecipientUsername = @currentUserName AND 
				RecipientDeleted = 0 AND
				SenderUsername = @recipientUserName		-- el q recibe soy yo _Y_ el q envia es el
			) OR
			(
				RecipientUsername = @recipientUserName AND 
				SenderDeleted = 0 AND
				SenderUsername = @currentUserName		-- el q recibe es el _Y_ el q envia soy yo
			)
	;

	-- actualizando mensajes no leidos
	UPDATE dbo.Msgs
	SET DateRead = GETDATE()
	WHERE	(
				RecipientUsername = @currentUserName AND 
				RecipientDeleted = 0 AND
				SenderUsername = @recipientUserName		-- el q recibe soy yo _Y_ el q envia es el
			)
			AND DateRead IS NULL
	;

END
GO


--
EXEC dbo.sp_getMsgsThread	@currentUserName = 'Mayo',		-- el que esta logeado
							@recipientUserName = 'Margo'	-- msgs del q esta logeado con este user
;

--SELECT * FROM Msgs;
SELECT * FROM Photos
WHERE appUserId IN (1, 6);


/*						DE DatingSql

USE DatingAppSql21012024;
GO

DROP PROCEDURE IF EXISTS dbo.sp_getMsgsThread;
GO

CREATE PROCEDURE dbo.sp_getMsgsThread
(
	@currentUserName VARCHAR(50), -- el que esta logeado
	@recipientUserName VARCHAR(10) -- a quien le escribe los mensajes
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


*/