USE Gym
GO

DROP TABLE IF EXISTS dbo.Pictures; --appUserId
GO
DROP TABLE IF EXISTS dbo.ClaseHorario; -- claseId, sectoId ,	diaId ,	horaId ,
GO
DROP TABLE IF EXISTS dbo.UserRoles; -- userId, roleId
GO
DROP TABLE IF EXISTS dbo.UserClase; -- userId, claseId
GO
DROP TABLE IF EXISTS dbo.Clase; -- TipoClase, NivelClase
GO

DROP TABLE IF EXISTS dbo.NivelClase;
GO
DROP TABLE IF EXISTS dbo.Roles;
GO
DROP TABLE IF EXISTS dbo.Sector;
GO
DROP TABLE IF EXISTS dbo.TipoClase;
GO
DROP TABLE IF EXISTS dbo.Hora;
GO
DROP TABLE IF EXISTS dbo.Dia;
GO
DROP TABLE IF EXISTS dbo.AppUsers;
GO



------------------------------------------
CREATE TABLE AppUsers
(
	Id INT IDENTITY(1,1),
	UserName VARCHAR(50) NOT NULL,
	PasswordHash VARCHAR(MAX),
	KnownAs VARCHAR(50),
    Created DATETIME DEFAULT GETDATE(),
    LastActive DATETIME DEFAULT GETDATE(),
    City VARCHAR(200),
    Country VARCHAR(200),

	Email VARCHAR(50) NOT NULL,
	NormalizedEmail VARCHAR(50) NOT NULL,

	CONSTRAINT PK_Users_id PRIMARY KEY (ID)
);

DECLARE @Hash VARCHAR(MAX) = 'AQAAAAIAAYagAAAAEC5owvdnPSxx7dGsh6TgaYYlube2B0ZMmmgJOO60BJuMd6ayKkCXcnGFZvVzOY0PnQ==';

INSERT INTO [dbo].[AppUsers] (UserName, KnownAs, Created, LastActive, City, Country, PasswordHash, Email, NormalizedEmail)
VALUES	('Admin', 'Admin', '1980-05-01', '1980-05-01', '...', '...', @Hash, 'Admin', 'ADMIN' ),
		('Lisa', 'Lisa', '2020-06-24', '2020-06-21', 'Greenbush', 'Martinique', @Hash, 'Lisa','LISA'),
		('Karen', 'Karen', '2019-12-09', '2020-05-06', 'Celeryville', 'Grenada', @Hash, 'Karen', 'KAREN'),
		('Margo', 'Margo', '2019-08-10', '2020-05-12', 'Rosewood', 'Svalbard and Jan Mayen Islands', @Hash, 'Margo','MARGO'),
		('Lois', 'Lois', '2019-04-24', '2020-06-17', 'Orviston', 'Zimbabwe', @Hash, 'Lois', 'LOIS'),
		('Ruthie', 'Ruthie', '2019-04-30', '2020-06-21', 'Germanton', 'Antigua and Barbuda', @Hash, 'Ruthie','RUTHIE'),
		('Todd', 'Todd', '2019-04-29', '2020-05-16', 'Cliff', 'British Indian Ocean Territory', @Hash, 'Todd', 'TODD'),
		('Porter', 'Porter', '2020-04-05', '2020-06-23', 'Welda', 'Christmas Island', @Hash, 'Porter', 'PORTER'),
		('Mayo', 'Mayo', '2020-03-14', '2020-05-17', 'Clarence', 'Burkina Faso', @Hash, 'Mayo', 'MAYO'),
		('Skinner', 'Skinner', '2019-01-28', '2020-06-07', 'Herald', 'Poland', @Hash, 'Skinner', 'SKINNER'),
		('Davis', 'Davis', '2020-02-25', '2020-06-11', 'Lupton', 'Luxembourg', @Hash, 'Davis', 'DAVIS')
		-- profes
		, ('Sergio', 'Sergio', '2020-02-25', '2020-06-11', 'Monterrey', 'México', @Hash, 'Sergio', 'SERGIO')
		, ('Ricardo', 'Ricardo', '2020-02-25', '2020-06-11', 'Santiago', 'México', @Hash, 'Ricardo', 'RICARDO')
		, ('Samu', 'Samu', '2020-02-25', '2020-06-11', 'Linares', 'México', @Hash, 'Samu', 'SAMU')
;
GO
------------------------------------------
CREATE TABLE Hora
(
	id INT IDENTITY(1,1),
	nombreHora TINYINT,
	
	CONSTRAINT PK_Hora_id PRIMARY KEY (id),
);

INSERT INTO [dbo].[Hora] (nombreHora)
VALUES	(8), (9), (10), (11), (12), (13), (14),
		(15), (16), (17), (18), (19), (20)
;
GO
------------------------------------------
CREATE TABLE Dia
(
	id INT IDENTITY(1,1),
	nombreDia VARCHAR(1),
	
	CONSTRAINT PK_Dia_id PRIMARY KEY (id),
);

INSERT INTO [dbo].[Dia] (nombreDia)
VALUES	('L'),
		('M'),
		('X'),
		('J'),
		('V'),
		('S')
;
GO
------------------------------------------
CREATE TABLE TipoClase
(
	id INT IDENTITY(1,1),
	nombreTipoClase VARCHAR(50),
	
	CONSTRAINT PK_TipoClase_id PRIMARY KEY (id),
);

INSERT INTO [dbo].[TipoClase] (nombreTipoClase)
VALUES	('Salsa'), ('Zumba'), ('Karate'), ('Yoga')
;
GO
------------------------------------------
CREATE TABLE Sector
(
	id INT IDENTITY(1,1),
	nombreSector VARCHAR(100),
	
	CONSTRAINT PK_Sector_id PRIMARY KEY (id),
);

INSERT INTO [dbo].[Sector] (nombreSector)
VALUES	('Piso 1 - A'),
		('Piso 1 - B'),
		('Piso 2 - A'),
		('Piso 2 - B'),
		('Piso 2 - C')
;
GO
------------------------------------------
CREATE TABLE Roles
(
	id INT IDENTITY(1,1),
	name VARCHAR(20),
	normalizedName VARCHAR(20),
	
	CONSTRAINT PK_Roles_id PRIMARY KEY (id),
);

INSERT INTO [dbo].[Roles] (name, normalizedName)
VALUES	('Admin', 'ADMIN'),
		('Member', 'MEMBER'),
		('Teacher', 'TEACHER')
;
GO
------------------------------------------
CREATE TABLE NivelClase
(
	id INT IDENTITY(1,1),
	nombreNivelClase VARCHAR(50),
	
	CONSTRAINT PK_NivelClase_id PRIMARY KEY (id),
);

INSERT INTO [dbo].[NivelClase] (nombreNivelClase)
VALUES	('Principiante'), ('Intermedio'), ('Avanzado')
;
GO
------------------------------------------
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

INSERT INTO [dbo].[Clase] (nombre, tipo, nivel)
VALUES	('Salsa principiantes', 1, 1),
		('Salsa intermedio', 1, 2),
		('Zumba avanzado', 2, 3),
		('Karate niños principiante', 3, 1),
		('Karate adultos intermedio', 3, 2),
		('Karate adultos avanzado', 3, 3),
		('Yoga adulto mayor intermedio', 4, 2)
;
GO
------------------------------------------
CREATE TABLE UserClase
(
	userId INT NOT NULL,
	claseId INT NOT NULL,
	
	CONSTRAINT PK_UserClase_id PRIMARY KEY (userId, claseId), -- no puede un alumno o profe estar + de 1 vez en 1 clase
	CONSTRAINT FK_UserClase_userId FOREIGN KEY (userId) REFERENCES [AppUsers] (id),
	CONSTRAINT FK_UserClase_claseId FOREIGN KEY (claseId) REFERENCES [Clase] (id)
);

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
GO
------------------------------------------
CREATE TABLE UserRoles
(
	userId INT NOT NULL,
	roleId INT NOT NULL,
	
	CONSTRAINT PK_UserRoles_id PRIMARY KEY (userId, roleId),
	CONSTRAINT FK_UserRoles_userId FOREIGN KEY (userId) REFERENCES [AppUsers] (id),
	CONSTRAINT FK_UserRoles_roleId FOREIGN KEY (roleId) REFERENCES Roles (id)
);

INSERT INTO [dbo].[UserRoles] (userId, roleId)
VALUES	(1, 1), (1, 2), (1, 3), (2, 2), (3, 2), (4, 2),
		(5, 2), (6, 2), (7, 2), (8, 2), (9, 2),
		(10, 2), (11, 2)
		,(12, 3), (13, 3), (14, 3) -- profes
;
GO
------------------------------------------
CREATE TABLE ClaseHorario
(
	id INT IDENTITY(1,1),
	claseId INT NOT NULL,
	sectorId INT NOT NULL,
	diaId INT NOT NULL,
	horaId INT NOT NULL,
	
	CONSTRAINT FK_ClaseHorario_claseId FOREIGN KEY (claseId) REFERENCES [Clase] (id),
	CONSTRAINT FK_ClaseHorario_sectoId FOREIGN KEY (sectorId) REFERENCES [Sector] (id),
	CONSTRAINT FK_ClaseHorario_diaId FOREIGN KEY (diaId) REFERENCES [Dia] (id),
	CONSTRAINT FK_ClaseHorario_horaId FOREIGN KEY (horaId) REFERENCES [Hora] (id),
);

INSERT INTO [dbo].[ClaseHorario] ( claseId, sectorId, diaId, horaId )
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
GO
------------------------------------------
CREATE TABLE Pictures
(
	id INT IDENTITY(1,1),
	url VARCHAR(500),
	isMain BIT DEFAULT 0, -- 0 false, 1 true
	publicId VARCHAR(500),
	appUserId INT

	CONSTRAINT PK_Pictures_id PRIMARY KEY (id),
	CONSTRAINT FK_Pictures_appUserId FOREIGN KEY (appUserId) REFERENCES AppUsers (id)
);

INSERT INTO [dbo].[Pictures] (url, isMain, appUserId)
VALUES	('https://randomuser.me/api/portraits/women/54.jpg', 0, 2),
		('https://randomuser.me/api/portraits/women/70.jpg', 1, 2), -- 2da p' lisa, main photo
		('https://randomuser.me/api/portraits/women/21.jpg', 0, 2), -- 3da p' lisa
		('https://randomuser.me/api/portraits/women/50.jpg', 1, 3),
		('https://randomuser.me/api/portraits/women/14.jpg', 1, 4),
		('https://randomuser.me/api/portraits/women/11.jpg', 1, 5),
		('https://randomuser.me/api/portraits/women/84.jpg', 1, 6),
		('https://randomuser.me/api/portraits/men/90.jpg', 1, 7),
		('https://randomuser.me/api/portraits/men/87.jpg', 1, 8),
		('https://randomuser.me/api/portraits/men/57.jpg', 1, 9),
		('https://randomuser.me/api/portraits/men/11.jpg', 1, 10),
		('https://randomuser.me/api/portraits/men/93.jpg', 1, 11),
		('https://randomuser.me/api/portraits/men/77.jpg', 1, 12),
		('https://randomuser.me/api/portraits/men/42.jpg', 1, 13),
		('https://randomuser.me/api/portraits/men/37.jpg', 1, 14)
;
GO
------------------------------------------


