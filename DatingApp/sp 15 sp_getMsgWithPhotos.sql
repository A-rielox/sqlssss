USE DatingSql;
GO

DROP PROCEDURE IF EXISTS dbo.sp_getMsgWithPhotos;
GO

CREATE PROCEDURE dbo.sp_getMsgWithPhotos
(
	@msgId INT
)
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN

	-- ids de usuarios en msg
	DECLARE @usersIds TABLE(sUserId INT, rUserId INT);
	-- fotos de usuarios en msg
	DECLARE @usersMainPhotosId TABLE(photoId INT);

	-- lleno @usersIds
	INSERT INTO @usersIds
	SELECT SenderId, RecipientId
	FROM Msgs
	WHERE	id = @msgId;

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

	-- el mensaje
	SELECT * 
	FROM Msgs
	WHERE id = @msgId;

	-- las fotos
	SELECT * 
	FROM Photos
	WHERE id IN (
		SELECT photoId FROM @usersMainPhotosId
	)

END
GO



EXEC dbo.sp_getMsgWithPhotos @msgId = 1
;

SELECT * FROM Msgs;
SELECT * FROM Photos
WHERE appUserId IN (1, 6);



/*
USE DatingSql;
GO

DROP PROCEDURE IF EXISTS dbo.sp_getMsg;
GO

CREATE PROCEDURE dbo.sp_getMsg
(
	@msgId INT
)
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN

	-- ids de usuarios en msg
	DECLARE @usersIds TABLE(sUserId INT, rUserId INT);
	-- fotos de usuarios en msg
	DECLARE @usersMainPhotos TABLE(usersMainPhotos VARCHAR(500));

	-- lleno @usersIds
	INSERT INTO @usersIds
	SELECT SenderId, RecipientId
	FROM Msgs
	WHERE	id = @msgId;

	-- lleno @@usersMainPhotos
	INSERT INTO @usersMainPhotos
	SELECT url
	FROM Photos
	WHERE appUserId IN (
		SELECT sUserId FROM @usersIds
	) OR appUserId IN (
		SELECT rUserId FROM @usersIds
	)
	AND isMain = 1;

	-- el mensaje
	SELECT * 
	FROM Msgs
	WHERE	id = @msgId;

	-- las fotos
	SELECT * FROM @usersMainPhotos;


END
GO



EXEC dbo.sp_getMsg @msgId = 5
;

--SELECT * FROM Msgs;
SELECT * FROM Photos
WHERE appUserId IN (2, 7);



*/