USE DatingSql;
GO

DROP PROCEDURE IF EXISTS dbo.sp_createUser;
GO

CREATE PROCEDURE dbo.sp_createUser
(
	@userName VARCHAR(50),
	@knownAs VARCHAR(50),
	@gender VARCHAR(50),
	@dateOfBirth DATETIME,
	@city VARCHAR(200),
	@country VARCHAR(200),
	@passwordHash VARBINARY(MAX),
	@passwordSalt VARBINARY(MAX)
)
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN

	DECLARE @newUserId AS INT;
	
	INSERT INTO [dbo].[Users] 
	(
		userName, knownAs, gender, 
		dateOfBirth, city, country, 
		passwordHash, passwordSalt
	)
	VALUES
	(
		@userName, @knownAs, @gender,
		@dateOfBirth, @city, @country,
		@passwordHash, @passwordSalt
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


DECLARE @Hash VARBINARY(MAX) = 0xA05D16B0AACB81D0499A5B0825889C9B73E6D9D2A60C78C0008A6C73D63602FF9ACB26A0AB83307B1A6E4048FB74A65B4E5C780E37D25543E11EE6BF57404F05;
DECLARE @Salt VARBINARY(MAX) = 0x63E67D0821643412FDE71BF04491A9B198FA88E1E06E82D0A666BA758828EF9973C9616E874B95B39F3AB4074F24FFBE91256B9E97F8FABE70FC8DF666D3F94A7CC87A86CF59C30E8A2F8CB8147E17A2C3418C2599ABFF7257C5D4A2797CEE87581553595D70729DF0F85D0B4F83BCA43F27CA972C4E35ABD9ED68708EFF089E;

EXEC dbo.sp_createUser	@userName = 'nuevo user',
						@knownAs = '@knownAs',
						@gender = '@gender',
						@dateOfBirth = '1980-05-01',
						@city = '@city',
						@country = '@country',
						@passwordHash = @Hash,
						@passwordSalt = @Salt
;
