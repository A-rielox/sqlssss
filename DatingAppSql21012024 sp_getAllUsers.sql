USE DatingAppSql21012024;
GO

DROP PROCEDURE IF EXISTS dbo.sp_getAllUsers
GO

CREATE PROCEDURE dbo.sp_getAllUsers 
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN

	SELECT *
	FROM dbo.AppUsers;

END
GO

EXEC dbo.sp_getAllUsers;
