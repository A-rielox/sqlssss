USE DatingSql;
GO

DROP PROCEDURE IF EXISTS dbo.sp_editRoles;
GO

CREATE PROCEDURE dbo.sp_editRoles
(
	@userName NVARCHAR(50),
	@rolesList NVARCHAR(500)
)
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRANSACTION;

	DECLARE @RowCount int;

	DECLARE @userId AS INT;
	DECLARE @rolesTable AS TABLE(userId INT, roleName VARCHAR(20));

	-- id de user enviado
	SELECT @userId = id
	FROM Users
	WHERE userName LIKE @userName;

	-- quito todos los roles
	DELETE FROM dbo.UserRoles
	WHERE userId = @userId;

	-- lleno tabla con user y sus nuevos roles
	INSERT INTO @rolesTable (roleName)
	SELECT * FROM STRING_SPLIT(@rolesList, ',')

	UPDATE @rolesTable
	SET userId = @userId

	-- insert en tabla de roles los nuevos p'el user
	INSERT INTO dbo.UserRoles
	SELECT	rt.userId, 
			r.id 
	FROM @rolesTable rt
	LEFT JOIN Roles r ON rt.rolename = r.name

		
	SET @RowCount = @@ROWCOUNT;
	
	IF @RowCount = ( SELECT COUNT(*) FROM @rolesTable )
		BEGIN
			-- envio de vuelta los roles actualizados del user
			SELECT r.name FROM UserRoles ur
			LEFT JOIN Roles r ON ur.roleId = r.id
			WHERE userId = @userId;

			COMMIT TRANSACTION;
		END		
	ELSE
		BEGIN
			SELECT @RowCount;
			ROLLBACK TRANSACTION
		END
GO

-----------------

EXEC dbo.sp_editRoles	@userName = 'Lisa',
						@rolesList = 'Member,Moderator'
;

select * from UserRoles
where userId = 2

select * from Roles




--DECLARE @rolesStrings NVARCHAR(200) = 'Member,Moderator'
--DECLARE @rolesTable AS TABLE(userId INT, rolename VARCHAR(20))


--INSERT INTO @rolesTable (rolename)
--SELECT * FROM STRING_SPLIT(@rolesStrings, ',')

--UPDATE @rolesTable
--SET userId = 2

--select rt.userId, r.id from @rolesTable rt
--left join Roles r on rt.rolename = r.name

--SELECT * FROM @rolesTable;
--select * from Roles
