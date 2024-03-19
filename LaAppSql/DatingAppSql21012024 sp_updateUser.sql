USE LaAppSql;
GO

DROP PROCEDURE IF EXISTS dbo.sp_updateUser;
GO

CREATE PROCEDURE dbo.sp_updateUser
(
	@userId INT,

    @introduction VARCHAR(2500),
    @interests VARCHAR(2500),
    @city VARCHAR(200),
    @country VARCHAR(200),
	@lastActive DATETIME
)
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN

	UPDATE dbo.[AppUsers]
	SET introduction = @introduction,
		interests = @interests,
		city = @city,
		country = @country,
		lastActive = @lastActive
	WHERE id = @userId

	SELECT @@ROWCOUNT; 
;

END
GO




---- Todd

SELECT * FROM [dbo].[AppUsers] WHERE id = 7;
EXEC dbo.sp_updateUser	@userId = 7,
						@introduction = 'Intro',
						@interests = 'Interests',
						@city = 'Ciudad',
						@country = 'Pais',
						@lastActive = '2023-09-19';

SELECT * FROM [dbo].[AppUsers] WHERE id = 7;

