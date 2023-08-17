USE DatingAppSqlS;
GO

DROP PROCEDURE IF EXISTS dbo.sp_getAllUsersAndPhotos
GO

CREATE PROCEDURE dbo.sp_getAllUsersAndPhotos 
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN

	SELECT *
	FROM dbo.Users;

	SELECT *
	FROM dbo.Photos;

END
GO

EXEC dbo.sp_getAllUsersAndPhotos;