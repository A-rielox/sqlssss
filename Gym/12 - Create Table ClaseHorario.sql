USE Gym
GO

DROP TABLE IF EXISTS dbo.ClaseHorario;
GO

CREATE TABLE ClaseHorario
(
	id INT IDENTITY(1,1),
	claseId INT NOT NULL,
	sectoId INT NOT NULL,
	diaId INT NOT NULL,
	horaId INT NOT NULL,
	
	CONSTRAINT FK_ClaseHorario_claseId FOREIGN KEY (claseId) REFERENCES [Clase] (id),
	CONSTRAINT FK_ClaseHorario_sectoId FOREIGN KEY (sectoId) REFERENCES [Sector] (id),
	CONSTRAINT FK_ClaseHorario_diaId FOREIGN KEY (diaId) REFERENCES [Dia] (id),
	CONSTRAINT FK_ClaseHorario_horaId FOREIGN KEY (horaId) REFERENCES [Hora] (id),
);

SELECT * FROM ClaseHorario;

INSERT INTO [dbo].[ClaseHorario] ( claseId, sectoId, diaId, horaId )
VALUES	(1, 3, 1, 1)	-- Salsa principiantes			Piso 2 - A		L	8
		, (1, 3, 3, 1)	-- Salsa principiantes			Piso 2 - A		X	8
		, (1, 3, 5, 1)	-- Salsa principiantes			Piso 2 - A		V	8

		, (2, 2, 2, 1)	-- Salsa intermedio				Piso 1 - B		M	8
		, (2, 2, 4, 1)	-- Salsa intermedio				Piso 1 - B		J	8
		, (2, 2, 6, 1)	-- Salsa intermedio				Piso 1 - B		S	8

		,(3, 4, 1, 11)	-- 	Zumba avanzado				Piso 2 - B		L	18
		,(3, 4, 3, 11)	-- 	Zumba avanzado				Piso 2 - B		X	18
		,(3, 4, 5, 11)	-- 	Zumba avanzado				Piso 2 - B		V	18

		,(4, 3, 2, 11)	-- 	Karate niños principiante		Piso 2 - A		M	18
		,(4, 3, 4, 11)	-- 	Karate niños principiante		Piso 2 - A		J	18
		,(4, 3, 6, 11)	-- 	Karate niños principiante		Piso 2 - A		S	18

		,(5, 5, 2, 13)	-- 	Karate adultos intermedio		Piso 2 - C		M	20
		,(5, 5, 4, 13)	-- 	Karate adultos intermedio		Piso 2 - C		J	20
		,(5, 5, 6, 13)	-- 	Karate adultos intermedio		Piso 2 - C		S	20

		,(6, 1, 1, 13)	-- 	Karate adultos avanzado			Piso 1 - A		L	20
		,(6, 1, 3, 13)	-- 	Karate adultos avanzado			Piso 1 - A		x	20
		,(6, 1, 5, 13)	-- 	Karate adultos avanzado			Piso 1 - A		V	20

		,(7, 1, 3, 3)	-- 	Yoga adulto mayor intermedio	Piso 1 - A		x	10
		,(7, 1, 6, 3)	-- 	Yoga adulto mayor intermedio	Piso 1 - A		S	10
		
;

SELECT * FROM ClaseHorario;


--TRUNCATE TABLE Gym.dbo.ClaseHorario;
