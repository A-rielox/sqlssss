-- liked	-- la lista de a quienes a dado like - userid = sourceuserid
-- likedBy	-- la lista de quienes le han dado like - userid = likeduserid

USE DatingSql;
GO

DROP PROCEDURE IF EXISTS dbo.sp_getLikedLikedBy;
GO

CREATE PROCEDURE dbo.sp_getLikedLikedBy
(
	@predicate VARCHAR(15),
	@userId INT
)
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN

	DECLARE @usersId AS TABLE(userId INT);

	IF @predicate LIKE 'liked'
	
	BEGIN
		-- a los que el userId les ha dado like
		INSERT INTO @usersId
		SELECT TargetUserId
		FROM Likes
		WHERE SourceUserId = @userId
	END
	ELSE
	BEGIN
		-- los q han dado like al userId
		INSERT INTO @usersId
		SELECT SourceUserId
		FROM Likes
		WHERE TargetUserId = @userId
	END
	--WHERE SourceUserId = 
	--	CASE
	--		WHEN @predicate LIKE 'liked' THEN @userId
	--		WHEN @predicate LIKE 'likedBy' THEN @userId 
	--	END

	SELECT * 
	FROM Users
	WHERE id IN (
		SELECT * FROM @usersId
	)
	ORDER BY userName

	-- unico agregado a sp
	SELECT *
	FROM Photos
	WHERE isMain = 1 AND
		appUserId IN (
			SELECT * FROM @usersId
		)
;

END
GO


-- a quienes usuario 2 a dado like
-- @predicate = liked,
-- @userId = 2

-- quienes han dado like al usuario 2 
-- @predicate = likedBy,
-- @userId = 2

EXEC dbo.sp_getLikedLikedBy @predicate = 'likedBy',
							@userId = 1
;

SELECT * FROM Likes;

--TRUNCATE TABLE DatingAppSqlS.dbo.Users;

