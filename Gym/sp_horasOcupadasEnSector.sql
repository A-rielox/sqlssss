USE Gym;
GO

DROP PROCEDURE IF EXISTS dbo.sp_horasOcupadasEnSector;
GO

CREATE PROCEDURE dbo.sp_horasOcupadasEnSector
(
	@sectorId INT
)
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN

	
	SELECT ch.sectoId, di.nombreDia, ho.nombreHora, se.nombreSector
	FROM [ClaseHorario] ch
	LEFT JOIN [Dia] di ON ch.diaId = di.id
	LEFT JOIN [Hora] ho ON ch.horaId = ho.id
	LEFT JOIN [Sector] se ON ch.sectoId = se.id
	WHERE [sectoId] = @sectorId
	ORDER BY di.id, ho.id
;

END
GO



EXEC dbo.sp_horasOcupadasEnSector @sectorId = 1;
