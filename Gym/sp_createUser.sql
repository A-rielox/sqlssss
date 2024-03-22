USE Gym;
GO

DROP PROCEDURE IF EXISTS dbo.sp_createUser;
GO

CREATE PROCEDURE dbo.sp_createUser
(
	@userName VARCHAR(50),
	@knownAs VARCHAR(50),
	@city VARCHAR(200),
	@country VARCHAR(200),
	@passwordHash VARCHAR(MAX)
	--@email VARCHAR(100),
	--@normalizedEmail VARCHAR(100)
)
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN

	DECLARE @newUserId AS INT;
	
	INSERT INTO [dbo].[AppUsers] 
	(
		UserName, KnownAs, City, Country, 
		PasswordHash, Email, NormalizedEmail
	)
	VALUES
	(
		@userName, @knownAs, @city, @country,
		@passwordHash, @userName, UPPER( @userName )
	);

	SELECT @newUserId = SCOPE_IDENTITY();

	-- agregandolo a la tabla de UserRoles como Member
	INSERT INTO [dbo].[UserRoles] ( userId, roleId )
	VALUES ( @newUserId, 1 );

	-- retorno el userId creado
	select @newUserId;
;

END
GO


DECLARE @Hash VARCHAR(MAX) = 'AQAAAAIAAYagAAAAEC5owvdnPSxx7dGsh6TgaYYlube2B0ZMmmgJOO60BJuMd6ayKkCXcnGFZvVzOY0PnQ==';

EXEC dbo.sp_createUser	@userName = 'Otto user',
						@knownAs = 'knownAs',
						@city = 'city',
						@country = 'country',
						@passwordHash = @Hash
						--@email = 'email',
						--@normalizedEmail = 'EMAIL'
;

select * from [AppUsers]

/*
*/