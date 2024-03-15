USE DatingAppSql21012024;
GO

DROP PROCEDURE IF EXISTS dbo.sp_getUsersWithRoles;
GO

CREATE PROCEDURE dbo.sp_getUsersWithRoles
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN

	SELECT	id, 
			userName
	FROM [AppUsers]
	ORDER BY userName;

	SELECT ur.userId, r.name
	FROM UserRoles ur
	LEFT JOIN Roles r ON ur.roleId = r.id;

END
GO



EXEC dbo.sp_getUsersWithRoles	-- @userName = 'nuevo user'
;


