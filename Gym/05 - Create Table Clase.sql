USE Gym;
GO

DROP TABLE IF EXISTS dbo.Clase;
GO

CREATE TABLE Clase
(
	id INT IDENTITY(1,1),
	nombre VARCHAR(200),
	tipo INT,
	nivel INT,
	
	CONSTRAINT PK_Clase_id PRIMARY KEY (id),
	CONSTRAINT FK_Clase_tipo FOREIGN KEY (tipo) REFERENCES [TipoClase] (id),
	CONSTRAINT FK_Clase_nivel FOREIGN KEY (nivel) REFERENCES [NivelClase] (id),
);

SELECT * FROM Clase;
	
INSERT INTO [dbo].[Clase] (nombre, tipo, nivel)
VALUES	('Salsa principiantes', 1, 1),
		('Salsa intermedio', 1, 2),
		('Zumba avanzado', 2, 3),
		('Karate niños principiante', 3, 1),
		('Karate adultos intermedio', 3, 2),
		('Karate adultos avanzado', 3, 3),
		('Yoga adulto mayor intermedio', 4, 2)
;

SELECT * FROM Clase;
SELECT * FROM TipoClase;
SELECT * FROM NivelClase;


--TRUNCATE TABLE Gym.dbo.Clase;