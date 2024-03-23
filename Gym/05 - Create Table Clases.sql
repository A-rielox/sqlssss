USE Gym;
GO

DROP TABLE IF EXISTS dbo.Clase;

CREATE TABLE Clase
(
	id INT IDENTITY(1,1),
	nombreClase VARCHAR(100),
	
	CONSTRAINT PK_Clases_id PRIMARY KEY (id),
);

SELECT * FROM Clase;

INSERT INTO [dbo].[Clase] (nombreClase)
VALUES	('Salsa principiantes'),
		('Salsa intermedio'),
		('Zumba avanzado'),
		('Karate niños'),
		('Karate adultos'),
		('Yoga adulto mayor')
;

SELECT * FROM Clase;


TRUNCATE TABLE Gym.dbo.Clase;