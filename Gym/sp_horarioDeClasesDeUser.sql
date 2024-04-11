USE Gym;
GO

DROP PROCEDURE IF EXISTS dbo.sp_horarioDeClasesDeUser;
GO

CREATE PROCEDURE dbo.sp_horarioDeClasesDeUser
(
	@userId int
)
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN
	
	SELECT		uc.userId
				, uc.claseId AS ClassId
				, cl.nombre AS ClassName
				, di.nombreDia AS 'DayName'
				, ho.nombreHora AS HourName
				, se.nombreSector AS SectorName
				, uc2.userId AS teacher_id
				, au.KnownAs AS teacher_nombre
				, pic.url AS teacher_foto
	FROM [UserClase] uc
	LEFT JOIN [UserRoles] ur ON uc.userId = ur.userId
	LEFT JOIN [UserClase] uc2 ON uc2.claseId = uc.claseId
	LEFT JOIN [UserRoles] ur2 ON uc2.userId = ur2.userId
	LEFT JOIN [Clase] cl ON uc.claseId = cl.id
	LEFT JOIN [ClaseHorario] ch ON uc.claseId = ch.claseId
	LEFT JOIN [Dia] di ON ch.diaId = di.id
	LEFT JOIN [Hora] ho ON ch.horaId = ho.id
	LEFT JOIN [Sector] se ON ch.sectoId = se.id
	LEFT JOIN [AppUsers] au ON au.Id = uc2.userId
	LEFT JOIN [Pictures] pic ON uc2.userId = pic.appUserId
	WHERE	uc.userId = 2
			and ur2.roleId = 3
	ORDER BY uc.claseId
;

END
GO



--select * from AppUsers where [Id] = 3;
EXEC dbo.sp_horarioDeClasesDeUser @userId = 2;
