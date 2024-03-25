USE Gym
GO

DROP TABLE IF EXISTS dbo.TipoClase;
GO

CREATE TABLE TipoClase
(
	id INT IDENTITY(1,1),
	nombreTipoClase VARCHAR(50),
	
	CONSTRAINT PK_TipoClase_id PRIMARY KEY (id),
);

SELECT * FROM TipoClase;

INSERT INTO [dbo].[TipoClase] (nombreTipoClase)
VALUES	('Salsa'), ('Zumba'), ('Karate'), ('Yoga')
;

SELECT * FROM TipoClase;


--TRUNCATE TABLE Gym.dbo.TipoClase;
