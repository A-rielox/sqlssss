USE Gym;
GO

DROP PROCEDURE IF EXISTS dbo.sp_updateUser;
GO

CREATE PROCEDURE dbo.sp_updateUser
(
	@userId INT,

    @knownAs VARCHAR(50),
    @city VARCHAR(200),
    @country VARCHAR(200),
	@lastActive DATETIME
)
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN

	UPDATE dbo.[AppUsers]
	SET knownAs = @knownAs,
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
						@knownAs = 'KnownAs',
						@city = 'Ciudad',
						@country = 'Pais',
						@lastActive = '2023-09-19';

SELECT * FROM [dbo].[AppUsers] WHERE id = 7;

