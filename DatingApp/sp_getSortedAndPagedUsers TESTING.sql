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

---------

--SELECT	id,
--		userName,
--		CONVERT(DATE, lastActive) AS lastActive,
--		CONVERT(DATE, created ) AS created 
--FROM dbo.Users
--ORDER BY created ASC

--SELECT * FROM dbo.Photos ORDER BY appUserId;