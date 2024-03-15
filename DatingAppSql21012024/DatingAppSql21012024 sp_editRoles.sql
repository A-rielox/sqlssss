USE DatingAppSql21012024;
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

	-- id de user enviado
	SELECT @userId = id
	FROM [AppUsers]
	WHERE userName LIKE @userName;

	-- quito todos los roles
	DELETE FROM dbo.UserRoles
	WHERE userId = @userId;

	-- insert en tabla de roles los nuevos p'el user
	INSERT INTO dbo.UserRoles
	SELECT @userId, r.id 
	FROM STRING_SPLIT(@rolesList, ',') rn
	LEFT JOIN Roles r ON rn.value = r.name
		
	SET @RowCount = @@ROWCOUNT;
	
	IF @RowCount = ( SELECT COUNT(*) FROM STRING_SPLIT(@rolesList, ',') )
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
						@rolesList = 'Admin,Moderator'
;

select * from UserRoles
where userId = 2

select * from Roles

select * from UserRoles



DELETE FROM dbo.UserRoles
WHERE userId = 2;

INSERT INTO [dbo].[UserRoles] (userId, roleId)
VALUES	(2, 1)
;


SELECT COUNT(*) FROM STRING_SPLIT('Member', ',')



