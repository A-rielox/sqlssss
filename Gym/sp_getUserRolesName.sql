USE Gym;
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
	
	SELECT ro.name 
	FROM UserRoles ur
	LEFT JOIN Roles ro ON ur.roleId = ro.id
	WHERE userId = @userId
;
END
GO



EXEC dbo.sp_getUserRolesName @userId = 1;

SELECT * FROM UserRoles
WHERE userId = 1;
