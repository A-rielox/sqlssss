USE DatingSql;
GO

DROP PROCEDURE IF EXISTS dbo.sp_editRoles;
GO

CREATE PROCEDURE dbo.sp_editRoles
(
	@userName VARCHAR(50),
	@rolesList dbo.RolesListType READONLY
)
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN

	DECLARE @userId AS INT;

	-- id de user enviado
	SELECT @userId = id
	FROM Users
	WHERE userName LIKE @userName;

	-- quito todos los roles
	DELETE FROM dbo.UserRoles
	WHERE userId = @userId;

	-- agrego lista de roles
	DECLARE @i INT = 1

	WHILE @i <= ( SELECT COUNT(*) FROM @rolesList )
	BEGIN
		INSERT INTO dbo.UserRoles (userId, roleId)
		SELECT userName, roleName FROM @rolesList;

		SET @i = @i + 1
	END

	



END
GO

-----------------
SELECT * FROM Users WHERE id = 2
SELECT * FROM UserRoles
WHERE userId = 2


DECLARE @tablilla AS dbo.RolesListType;
INSERT INTO @tablilla VALUES ('Moderator'),('Member')

EXEC dbo.sp_editRoles	@userName = 'Lisa',
						@rolesList = @tablilla
;

EXEC dbo.sp_getUsersWithRoles	-- @userName = 'nuevo user'
;