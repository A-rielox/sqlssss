USE Gym
GO

DROP TABLE IF EXISTS dbo.Sector;
GO

CREATE TABLE Sector
(
	id INT IDENTITY(1,1),
	nombreSector VARCHAR(100),
	
	CONSTRAINT PK_Sector_id PRIMARY KEY (id),
);

SELECT * FROM Sector;

INSERT INTO [dbo].[Sector] (nombreSector)
VALUES	('Piso 1 - A'),
		('Piso 1 - B'),
		('Piso 2 - A'),
		('Piso 2 - B'),
		('Piso 2 - C')
;

SELECT * FROM Sector;


TRUNCATE TABLE Gym.dbo.Sector;