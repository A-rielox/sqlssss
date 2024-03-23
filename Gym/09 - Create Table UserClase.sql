
DROP TABLE IF EXISTS dbo.UserClase;

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
VALUES	(2, 1) -- lisa > salsa princi
		, (6, 1) -- ruthie > salsa princi
		, (8, 1) -- porter > salsa princi
		, (9, 1) -- mayo > salsa princi
		, (10, 1) -- skinner > salsa princi
		, (11, 1) -- davis > salsa princi
		, (13, 1) -- Ricardo > salsa princi -- PROFE

		, (2, 3) --lisa > zumba avanzado
		, (9, 3) -- mayo > zumba avanzado
		, (5, 3) -- Lois > zumba avanzado
		, (7, 3) -- todd > zumba avanzado
		, (10, 3) -- skinner > zumba avanzado
		, (14, 3) -- samu > zumba avanzado -- PROFE

		, (7, 4) -- todd > karate niños
		, (3, 4) -- karen > karate niños
		, (5, 4) -- Lois > karate niños
		, (11, 4) -- davis > karate niños
		, (13, 4) -- Ricardo > karate niños -- PROFE

		, (10, 6) -- skinner > yoga adulto mayor
		, (4, 6) -- margo > yoga adulto mayor
		, (6, 6) -- ruthie > yoga adulto mayor
		, (8, 6) -- porter > yoga adulto mayor
		, (12, 6) -- Sergio > yoga adulto mayor -- PROFE

		, (8, 5) -- porter > karate adulto
		, (9, 5) -- mayo > karate adulto
		, (2, 5) -- lisa > karate adulto
		, (6, 5) -- ruthie > karate adulto
		, (10, 5) -- skinner > karate adulto
		, (12, 5) -- Sergio > karate adulto -- PROFE
;

SELECT * FROM UserClase;


TRUNCATE TABLE Gym.dbo.UserClase;
