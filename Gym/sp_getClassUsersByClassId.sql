USE Gym;
GO

DROP PROCEDURE IF EXISTS dbo.sp_getClassUsersByClassId;
GO

CREATE PROCEDURE dbo.sp_getClassUsersByClassId
(
	@userType INT		-- 2 member, 3 profe, NULL ambos
	, @claseId INT
)
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN

	SELECT au.Id, au.UserName, au.KnownAs, pic.url
	FROM [UserClase] uc
	LEFT JOIN [UserRoles] ur ON uc.userId = ur.userId
	LEFT JOIN [AppUsers] au ON uc.userId = au.Id
	LEFT JOIN [Pictures] pic ON uc.userId = pic.appUserId
	WHERE	
			uc.claseId = @claseId
			AND (						-- si es NULL => se salta este AND
				ISNULL(@userType, 0) = 0
					OR ur.roleId = @userType
				)
			AND ( pic.isMain = 1 OR pic.isMain IS NULL )
	ORDER BY au.UserName	
;

END
GO



EXEC dbo.sp_getClassUsersByClassId @userType = 3		-- 2 member, 3 profe, NULL ambos
								, @claseId = 1;		-- 1 salsa ppte

/*
	SELECT au.UserName, au.KnownAs, Pic.url
	FROM [UserClase] uc
	LEFT JOIN [UserRoles] ur ON uc.userId = ur.userId
	LEFT JOIN [AppUsers] au ON uc.userId = au.Id
	OUTER APPLY (
		SELECT * FROM [Pictures] pict
		WHERE uc.userId = pict.appUserId
	) AS Pic
	WHERE	ur.roleId = 3
			AND uc.claseId = 1
	ORDER BY au.UserName	
*/