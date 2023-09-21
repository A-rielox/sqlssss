USE DatingSql;
GO

DROP PROCEDURE IF EXISTS dbo.sp_getMsgsForUser;
GO

CREATE PROCEDURE dbo.sp_getMsgsForUser
(
	@username VARCHAR(50),
	@container VARCHAR(10)
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


	-- lleno msgsIds
	IF @container = 'Inbox'
		BEGIN
			INSERT INTO @msgsIds
			SELECT id
			FROM Msgs
			WHERE	RecipientUsername = @username AND
					RecipientDeleted = 0
		END
	IF @container = 'Outbox'
		BEGIN
			INSERT INTO @msgsIds
			SELECT id
			FROM Msgs
			WHERE	SenderUsername = @username AND
					RecipientDeleted = 0
		END
	IF @container = 'Unread'			-- los no leidos
		BEGIN
			INSERT INTO @msgsIds
			SELECT id
			FROM Msgs
			WHERE	RecipientUsername = @username AND
					RecipientDeleted = 0 AND
					DateRead IS NULL
		END
	

	-- lleno @usersIds
	INSERT INTO @usersIds
	SELECT SenderId, RecipientId
	FROM Msgs
	WHERE id IN (
		SELECT msgId FROM @msgsIds
	);

	-- lleno @usersMainPhotosId
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

	-- los mensajes
	SELECT * 
	FROM Msgs
	WHERE id IN (
		SELECT msgId FROM  @msgsIds
	);

	-- las fotos
	SELECT * 
	FROM Photos
	WHERE id IN (
		SELECT photoId FROM @usersMainPhotosId
	)

END
GO


--	'Inbox'		'Outbox'	''
EXEC dbo.sp_getMsgsForUser	@username = 'Lisa',
							@container = 'Unread'
;

--SELECT * FROM Msgs;
SELECT * FROM Photos
WHERE appUserId IN (1, 6);
