USE [DatingAppSql21012024];
GO

DROP PROCEDURE IF EXISTS dbo.sp_getSortedAndPagedUsers;
GO

CREATE PROCEDURE dbo.sp_getSortedAndPagedUsers
(
	@pageNumber INT,
	@rowsOfPage INT,
	@currentUsername VARCHAR(50), -- viene el usuario actual
	@gender VARCHAR(20), -- viene el genero opuesto
	@minDob DATE, -- año mas bajo
    @maxDob DATE, -- año mas alto
	@sortingCol VARCHAR(20) ='lastActive', -- x created o lastActive
	@sortType VARCHAR(10) = 'DESC' -- no la estoy ocupando, de momento solo desc
)
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN

	-- ids de usuarios paginados
	DECLARE @usersIds TABLE(userId INT);
	
	-- SET ids de usuarios a devolver
	INSERT INTO @usersIds
	SELECT id
	FROM dbo.AppUsers
	WHERE	userName <> @currentUsername
			AND gender = @gender
			AND dateOfBirth >= @minDob AND dateOfBirth <= @maxDob
	ORDER BY 
		CASE WHEN @SortingCol = 'lastActive' AND @SortType ='ASC' 
			THEN lastActive END,
		CASE WHEN @SortingCol = 'lastActive' AND @SortType ='DESC' 
			THEN lastActive END DESC,
		CASE WHEN @SortingCol = 'Created' AND @SortType ='ASC' 
			THEN created END,
		CASE WHEN @SortingCol = 'Created' AND @SortType ='DESC' 
			THEN created END DESC
	OFFSET ( @PageNumber - 1 ) * @RowsOfPage ROWS
	FETCH NEXT @RowsOfPage ROWS ONLY
;

	-- usuarios a devolver
	SELECT * FROM dbo.AppUsers
	WHERE id IN (
		SELECT * FROM @usersIds
	)
	ORDER BY -- tambien necesito ordenar aqui xq sino me ordena x Id
		CASE WHEN @SortingCol = 'lastActive' AND @SortType ='ASC' 
			THEN lastActive END,
		CASE WHEN @SortingCol = 'lastActive' AND @SortType ='DESC' 
			THEN lastActive END DESC,
		CASE WHEN @SortingCol = 'Created' AND @SortType ='ASC' 
			THEN created END,
		CASE WHEN @SortingCol = 'Created' AND @SortType ='DESC' 
			THEN created END DESC
;

	-- fotos a devolver
	SELECT * FROM dbo.Photos
	WHERE appUserId IN (
		SELECT * FROM @usersIds
	)
;

END
GO



EXEC dbo.sp_getSortedAndPagedUsers	@pageNumber = 1,
									@rowsOfPage = 20,
									@currentUsername = 'KAREN',
									@gender = 'male',
									@minDob = '1922-09-11',
									@maxDob = '1978-09-11',
									@sortingCol ='Created'
									--@sortType = 'DESC';

SELECT * FROM Photos ORDER BY appUserId;
SELECT * FROM AppUsers
WHERE gender LIKE 'male'
--WHERE gender LIKE 'female'
;

/*	PRUEBA

USE DatingSql;
GO

DECLARE @pageNumber AS INT
DECLARE @rowsOfPage AS INT
DECLARE @sortingCol AS VARCHAR(20) ='LastActive' -- x created o lastActive
DECLARE @sortType AS VARCHAR(10) = 'DESC'

SET @PageNumber = 3
SET @RowsOfPage = 4
SET @sortingCol = 'Created'
SET @sortType = 'ASC'

--
DECLARE @usersIds TABLE(userId INT);
--

-- id de usuarios a devolvel
INSERT INTO @usersIds
SELECT id
FROM dbo.Users
ORDER BY 
	CASE WHEN @SortingCol = 'LastActive' AND @SortType ='ASC' 
		THEN lastActive END,
	CASE WHEN @SortingCol = 'LastActive' AND @SortType ='DESC' 
		THEN lastActive END DESC,
	CASE WHEN @SortingCol = 'Created' AND @SortType ='ASC' 
		THEN created END,
	CASE WHEN @SortingCol = 'Created' AND @SortType ='DESC' 
		THEN created END DESC
OFFSET ( @PageNumber - 1 ) * @RowsOfPage ROWS
FETCH NEXT @RowsOfPage ROWS ONLY

-- usuarios a devolver
SELECT * FROM dbo.Users
WHERE id IN (
	SELECT * FROM @usersIds
)
ORDER BY 
	CASE WHEN @SortingCol = 'LastActive' AND @SortType ='ASC' 
		THEN lastActive END,
	CASE WHEN @SortingCol = 'LastActive' AND @SortType ='DESC' 
		THEN lastActive END DESC,
	CASE WHEN @SortingCol = 'Created' AND @SortType ='ASC' 
		THEN created END,
	CASE WHEN @SortingCol = 'Created' AND @SortType ='DESC' 
		THEN created END DESC
;

-- fotos a devolver
SELECT * FROM dbo.Photos
WHERE appUserId IN (
	SELECT * FROM @usersIds
);

*/





/*	SP ORIGINAL

USE DatingSql;
GO

DROP PROCEDURE IF EXISTS dbo.sp_getSortedAndPagedUsers;
GO

CREATE PROCEDURE dbo.sp_getSortedAndPagedUsers
(
	@pageNumber INT,
	@rowsOfPage INT,
	@sortingCol VARCHAR(20) ='LastActive', -- x created o lastActive
	@sortType VARCHAR(10) = 'DESC'
)
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN

	SELECT u.*, p.* 
	FROM dbo.Users u
	LEFT JOIN dbo.Photos p ON u.id = p.appUserId
	ORDER BY 
		CASE WHEN @SortingCol = 'LastActive' AND @SortType ='ASC' 
			THEN lastActive END,
		CASE WHEN @SortingCol = 'LastActive' AND @SortType ='DESC' 
			THEN lastActive END DESC,
		CASE WHEN @SortingCol = 'Created' AND @SortType ='ASC' 
			THEN created END,
		CASE WHEN @SortingCol = 'Created' AND @SortType ='DESC' 
			THEN created END DESC
	OFFSET ( @PageNumber - 1 ) * @RowsOfPage ROWS
	FETCH NEXT @RowsOfPage ROWS ONLY
;

END
GO



EXEC dbo.sp_getSortedAndPagedUsers	@pageNumber = 5,
									@rowsOfPage = 4,
									@sortingCol ='Created',
									@sortType = 'ASC'

*/






/*	PRUEBA ORIGINAL

USE DatingSql;
GO

DECLARE @pageNumber AS INT
DECLARE @rowsOfPage AS INT
DECLARE @sortingCol AS VARCHAR(20) ='LastActive' -- x created o lastActive
DECLARE @sortType AS VARCHAR(10) = 'DESC'

SET @PageNumber = 2
SET @RowsOfPage = 4
SET @sortingCol = 'Created'
SET @sortType = 'ASC'

SELECT id, userName, CONVERT(DATE, lastActive) AS lastActive, CONVERT(DATE, created ) AS created FROM dbo.Users
ORDER BY 
	CASE WHEN @SortingCol = 'LastActive' AND @SortType ='ASC' 
		THEN lastActive END,
	CASE WHEN @SortingCol = 'LastActive' AND @SortType ='DESC' 
		THEN lastActive END DESC,
	CASE WHEN @SortingCol = 'Created' AND @SortType ='ASC' 
		THEN created END,
	CASE WHEN @SortingCol = 'Created' AND @SortType ='DESC' 
		THEN created END DESC
OFFSET ( @PageNumber - 1 ) * @RowsOfPage ROWS
FETCH NEXT @RowsOfPage ROWS ONLY

*/
