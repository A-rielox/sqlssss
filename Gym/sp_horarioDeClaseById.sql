USE Gym;
GO

DROP PROCEDURE IF EXISTS dbo.sp_horarioDeClaseById;
GO

CREATE PROCEDURE dbo.sp_horarioDeClaseById
(
	@claseId int
)
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN
	
	SELECT ch.claseId, di.nombreDia, ho.nombreHora, se.nombreSector
	FROM [ClaseHorario] ch
	LEFT JOIN [Dia] di ON ch.diaId = di.id
	LEFT JOIN [Hora] ho ON ch.horaId = ho.id
	LEFT JOIN [Sector] se ON ch.sectoId = se.id
	WHERE [claseId] = @claseId;
;

END
GO



EXEC dbo.sp_horarioDeClaseById @claseId = 2;		-- 1 salsa ppte
