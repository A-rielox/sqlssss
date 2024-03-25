USE Gym
GO

DROP TABLE IF EXISTS dbo.UserClase;
GO

CREATE TABLE UserClase
(
	userId INT NOT NULL,
	claseId INT NOT NULL,
	
	CONSTRAINT PK_UserClase_id PRIMARY KEY (userId, claseId), -- no puede un alumno o profe estar + de 1 vez en 1 clase
	CONSTRAINT FK_UserClase_userId FOREIGN KEY (userId) REFERENCES [AppUsers] (id),
	CONSTRAINT FK_UserClase_claseId FOREIGN KEY (claseId) REFERENCES [Clase] (id)
);

SELECT * FROM UserClase;

INSERT INTO [dbo].[UserClase] (userId, claseId)
VALUES	(2, 1)	 -- lisa >		salsa principiantes
		, (6, 1) -- ruthie > 
		, (8, 1) -- porter > 
		, (9, 1) -- mayo > 
		, (10, 1) -- skinner > 
		, (11, 1) -- davis > 
		, (13, 1) -- Ricardo >   -- PROFE

		, (2, 3) --lisa >		zumba avanzado
		, (9, 3) -- mayo >
		, (5, 3) -- Lois > 
		, (7, 3) -- todd > 
		, (10, 3) -- skinner > 
		, (14, 3) -- samu >      -- PROFE

		, (7, 4) -- todd >		karate niños principiante
		, (3, 4) -- karen > 
		, (5, 4) -- Lois > 
		, (11, 4) -- davis > 
		, (13, 4) -- Ricardo >  -- PROFE

		, (10, 7) -- skinner > yoga adulto mayor intermedio
		, (4, 7) -- margo > 
		, (6, 7) -- ruthie > 
		, (8, 7) -- porter > 
		, (12, 7) -- Sergio >			 -- PROFE

		, (8, 5) -- porter > karate adultos intermedio
		, (9, 5) -- mayo > 
		, (2, 5) -- lisa > 
		, (6, 5) -- ruthie >
		, (10, 5) -- skinner > 
		, (12, 5) -- Sergio >   -- PROFE
;

SELECT * FROM UserClase;


--TRUNCATE TABLE Gym.dbo.UserClase;
