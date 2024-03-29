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

	SELECT uc.userId, cl.nombre AS nombre_clase, di.nombreDia, ho.nombreHora, se.nombreSector
	FROM [UserClase] uc
	LEFT JOIN [Clase] cl ON uc.claseId = cl.id
	LEFT JOIN [ClaseHorario] ch ON uc.claseId = ch.claseId
	LEFT JOIN [Dia] di ON ch.diaId = di.id
	LEFT JOIN [Hora] ho ON ch.horaId = ho.id
	LEFT JOIN [Sector] se ON ch.sectoId = se.id
	WHERE uc.userId = @userId
;

END
GO



EXEC dbo.sp_horarioDeClasesDeUser @userId = 13;
