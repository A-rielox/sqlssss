
DROP TABLE IF EXISTS dbo.Hora;

CREATE TABLE Hora
(
	id INT IDENTITY(1,1),
	nombreHora TINYINT,
	
	CONSTRAINT PK_Hora_id PRIMARY KEY (id),
);

SELECT * FROM Hora;

INSERT INTO [dbo].[Hora] (nombreHora)
VALUES	(8), (9), (10), (11), (12), (13), (14),
		(15), (16), (17), (18), (19), (20)
;

SELECT * FROM Hora;


TRUNCATE TABLE Gym.dbo.Hora;
