USE Gym
GO

DROP TABLE IF EXISTS dbo.NivelClase;
GO

CREATE TABLE NivelClase
(
	id INT IDENTITY(1,1),
	nombreNivelClase VARCHAR(50),
	
	CONSTRAINT PK_NivelClase_id PRIMARY KEY (id),
);

SELECT * FROM NivelClase;

INSERT INTO [dbo].[NivelClase] (nombreNivelClase)
VALUES	('Principiante'), ('Intermedio'), ('Avanzado')
;

SELECT * FROM NivelClase;


--TRUNCATE TABLE Gym.dbo.NivelClase;
