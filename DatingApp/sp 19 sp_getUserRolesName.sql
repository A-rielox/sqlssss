USE DatingSql;
GO

DROP PROCEDURE IF EXISTS dbo.sp_getUserRolesName;
GO

CREATE PROCEDURE dbo.sp_getUserRolesName
(
	@userId INT
)
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN
	
	SELECT r.name 
	FROM UserRoles ur
	LEFT JOIN Roles r ON ur.roleId = r.id
	WHERE userId = @userId
;
END
GO



EXEC dbo.sp_getUserRolesName @userId = 2;

SELECT * FROM UserRoles
WHERE userId = 2;
