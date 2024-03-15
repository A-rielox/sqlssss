USE [DatingAppSql21012024];
GO

DROP PROCEDURE IF EXISTS dbo.sp_getUsersCount
GO

CREATE PROCEDURE dbo.sp_getUsersCount
(	
	@currentUsername VARCHAR(50), -- viene el usuario actual
	@gender VARCHAR(20), -- viene el genero opuesto
	@minDob DATE, -- año mas bajo
    @maxDob DATE -- año mas alto
)
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN

	SELECT COUNT(*)
	FROM dbo.[AppUsers]
	WHERE	userName <> @currentUsername
			AND gender = @gender
			AND dateOfBirth >= @minDob AND dateOfBirth <= @maxDob
;

END
GO



EXEC dbo.sp_getUsersCount	@currentUsername = 'lois',
							@gender = 'female',
							@minDob = '1950-01-11',
							@maxDob = '1960-12-11'
;

SELECT UserName, DateOfBirth, Gender FROM dbo.[AppUsers];
