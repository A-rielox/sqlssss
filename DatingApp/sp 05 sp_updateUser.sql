USE DatingSql;
GO

DROP PROCEDURE IF EXISTS dbo.sp_updateUser;
GO

CREATE PROCEDURE dbo.sp_updateUser
(
	@userId INT,

    @introduction VARCHAR(2500),
    @lookingFor VARCHAR(2500),
    @interests VARCHAR(2500),
    @city VARCHAR(200),
    @country VARCHAR(200)
)
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN

	UPDATE dbo.Users
	SET introduction = @introduction,
		lookingFor = @lookingFor,
		interests = @interests,
		city = @city,
		country = @country
	WHERE id = @userId

	SELECT @@ROWCOUNT; -- me devuelve el usuario editado
;

END
GO

--IF @@ROWCOUNT = 0
--BEGIN
--       mandar algo
--END

---- BOB
EXEC dbo.sp_updateUser	@userId = 12,
						@introduction = 'Intro Editada',
						@lookingFor = 'Looking For Editados1',
						@interests = 'Interests Editados',
						@city = 'Ciudad Editada',
						@country = 'Pais Editado';

SELECT * FROM [DatingSql].[dbo].[Users] WHERE id = 12;

