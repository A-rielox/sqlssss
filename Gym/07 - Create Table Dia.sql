USE Gym
GO

DROP TABLE IF EXISTS dbo.Dia;
GO

CREATE TABLE Dia
(
	id INT IDENTITY(1,1),
	nombreDia VARCHAR(1),
	
	CONSTRAINT PK_Dia_id PRIMARY KEY (id),
);

SELECT * FROM Dia;

INSERT INTO [dbo].[Dia] (nombreDia)
VALUES	('L'),
		('M'),
		('X'),
		('J'),
		('V'),
		('S')
;

SELECT * FROM Dia;


TRUNCATE TABLE Gym.dbo.Dia;