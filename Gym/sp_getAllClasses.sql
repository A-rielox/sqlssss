
USE Gym;
GO

DROP PROCEDURE IF EXISTS dbo.sp_getAllClasses;
GO

CREATE PROCEDURE dbo.sp_getAllClasses

AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN
	
	DECLARE @TablaCantidadAlumnos TABLE (claseId INT, cantidadAlumnos INT);

	INSERT INTO @TablaCantidadAlumnos (claseId, cantidadAlumnos)
	SELECT claseId, count(*) AS 'AlumnosEnClase' 
	FROM [UserClase] uc
	LEFT JOIN [UserRoles] ur ON uc.userId = ur.userId
	WHERE ur.roleId = 2 -- member
	GROUP By uc.claseId
;
	
	SELECT	ch.claseId AS ClassId
			, ISNULL(au.KnownAs, 'Sin profesor asignado') AS TeacherName
			, cl.nombre AS ClassName
			, ISNULL(se.nombreSector, 'Sin sector asignado') AS Sector
			, ISNULL(di.nombreDia, 'Sin día asignado') AS 'Day'
			, ISNULL(ho.nombreHora, 0) AS 'Hour'
			, tc.nombreTipoClase AS ClassType
			, nc.nombreNivelClase AS ClassLevel
			, ISNULL(pic.url, 'Sin profesor asignado') AS PictureTeacher
			, ISNULL(tca.cantidadAlumnos, 0) AS NumberOfStudents
	FROM [ClaseHorario] ch
	LEFT JOIN [Clase] cl ON ch.claseId = cl.id

	LEFT JOIN [Sector] se ON ch.sectorId = se.id
	LEFT JOIN [Dia] di ON ch.diaId = di.id
	LEFT JOIN [Hora] ho ON ch.horaId = ho.id

	LEFT JOIN [TipoClase] tc ON cl.tipo = tc.id
	LEFT JOIN [NivelClase] nc ON nc.id = cl.nivel

	FULL JOIN [UserClase] uc ON cl.id = uc.claseId
	LEFT JOIN [UserRoles] ur ON ur.userId = uc.userId
	LEFT JOIN [AppUsers] au ON au.Id = uc.userId
	LEFT JOIN [Pictures] pic ON pic.appUserId = au.Id

	LEFT JOIN @TablaCantidadAlumnos tca ON tca.claseId = cl.id
	WHERE ur.roleId = 3 OR ur.roleId IS NULL
	ORDER BY ch.claseId	
;

END
GO



EXEC dbo.sp_getAllClasses;