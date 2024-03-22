USE Gym;
GO

DROP PROCEDURE IF EXISTS dbo.sp_getAllUsersAndPictures
GO

CREATE PROCEDURE dbo.sp_getAllUsersAndPictures 
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN

	SELECT *
	FROM dbo.[AppUsers];

	SELECT *
	FROM dbo.Pictures;

END
GO

EXEC dbo.sp_getAllUsersAndPictures;
