USE Gym
GO

DROP TABLE IF EXISTS dbo.Pictures; --appUserId
GO
DROP TABLE IF EXISTS dbo.PicturesClass; --classId
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


CREATE TABLE PicturesClass
(
	id INT IDENTITY(1,1),
	url VARCHAR(500),
	publicId VARCHAR(500),
	classId INT

	CONSTRAINT PK_PicturesClass_id PRIMARY KEY (id),
	CONSTRAINT FK_PicturesClass_appUserId FOREIGN KEY (classId) REFERENCES Clase (id)
);

INSERT INTO [dbo].[PicturesClass] (url, classId)
VALUES	('https://media.istockphoto.com/id/1362732103/es/foto/mujer-en-kimono-practicando-tabla-de-rotura.jpg?s=612x612&w=0&k=20&c=2CtZMDdHNx3ZOfLxIaciG4ajXYKqC-nDWUyepzkR27E=', 5),-- Karate adultos intermedio
		('https://media.istockphoto.com/id/1430749093/es/foto/maestros-de-karate-rompiendo-con-la-pata-de-tabla-de-madera.jpg?s=612x612&w=0&k=20&c=TCnHScZb9LAPZUmJv1zv_QN8bchDloVVPnby9XfY0n4=', 5),
		('https://media.istockphoto.com/id/1343482344/es/foto/jugador-de-karate-masculino-rompiendo-tablones-de-madera.jpg?s=612x612&w=0&k=20&c=v63MX88iMtTLcc_kIimoZrTdvhJt_mY9r5WScUKurmU=', 5),
		('https://media.istockphoto.com/id/1432699739/es/foto/maestros-de-karate-rompiendo-con-la-pata-de-tabla-de-madera.jpg?s=612x612&w=0&k=20&c=wrio9SXqUN20TcM5JI6DZpKFnbsT8X_DNNwBBRGukH4=', 5),

		('https://media.istockphoto.com/id/895781768/es/foto/con-un-cintur%C3%B3n-azul-una-chica-adulto-pega-una-patada.jpg?s=612x612&w=0&k=20&c=MwcpA7dv1Y7y7fVuxjYTGto_mAHpTc1Zlfr0P23uFZo=', 6),-- Karate adultos avanzado
		('https://media.istockphoto.com/id/503190180/es/foto/karate-jugadores-en-acciones.jpg?s=612x612&w=0&k=20&c=YV65peAExMrQG3TguhjQpXzX51M8icvqefBSY_6DEQI=', 6),
		('https://media.istockphoto.com/id/1037680658/es/foto/un-hombre-en-negro-guantes-golpea-con-la-mano-en-un-salto-aislado.jpg?s=612x612&w=0&k=20&c=FF7txg1W_XQM8o4KDZV0C0zdFdrHU8Sj0V_hpO61nm8=', 6),
		('https://media.istockphoto.com/id/839396254/es/foto/con-una-deportista-cintur%C3%B3n-naranja-sobre-un-fondo-blanco.jpg?s=612x612&w=0&k=20&c=2gCoWVZNMz5DpGXADv4wt42jQpoHH0KWcm41O6NLqEk=', 6),

		('https://media.istockphoto.com/id/1302910346/es/foto/mujer-atl%C3%A9tica-con-ropa-deportiva-pantalones-y-top-realizando-handstand-en-yoga.jpg?s=612x612&w=0&k=20&c=4ge4ud8oE-0ByhH68YguYTzR4ZR9KwYN464U_xls-ac=', 7),-- Yoga adulto mayor intermedio
		('https://media.istockphoto.com/id/601901840/es/vector/hombre-en-la-posici%C3%B3n-de-loto-de-asana.jpg?s=612x612&w=0&k=20&c=Q-LAKTspZefi6tlP7vFllrqlof9oAz17LzsQ2Ed5yEM=', 7),
		('https://media.istockphoto.com/id/482044074/es/foto/mujer-joven-meditar-al-aire-libre-en-una-terraza.jpg?s=612x612&w=0&k=20&c=eZnGHIG3mhVqY2Y_M80RDd4PZCxReREK1Un3F_E8BEI=', 7),
		('https://media.istockphoto.com/id/162535945/es/foto/feliz-mujer-joven-en-una-estera-de-yoga-estiramientos-las-piernas.jpg?s=612x612&w=0&k=20&c=P1rQmoJsNt6gT1BRKpTbhnfgUlqczWr330C65IdgDK0=', 7),

		('https://media.istockphoto.com/id/1302675836/es/foto/mujer-hispana-practicando-movimientos-de-zumba.jpg?s=612x612&w=0&k=20&c=cntrNpXaFkL9Q0FunvdiXXDfmylpdluqCbre4pkv0vs=', 3),-- Zumba avanzado
		('https://media.istockphoto.com/id/843203000/es/foto/bailarines-de-cardio-mujer-baile-fitness-ejercicio-ejercicios-aisla.jpg?s=612x612&w=0&k=20&c=1mHa297J5rH0rBUa_nHwQhpdGOioMThRtDkDJxrkabQ=', 3),
		('https://media.istockphoto.com/id/538854567/es/foto/baile-zumba-mujer.jpg?s=612x612&w=0&k=20&c=J7HmUKYp-XbmALgElOtp6i_PIeB86UcMmPVlFiBaADs=', 3),
		('https://media.istockphoto.com/id/1155585331/es/vector/banner-gente-feliz-bailando.jpg?s=612x612&w=0&k=20&c=wwb4qPQ5BN1SBJHXANvHq2y0aZN7qnUFWJIv5rPRBdI=', 3),

		('https://media.istockphoto.com/id/155235113/es/foto/pareja-de-baile-latino-en-sal%C3%B3n-de-baile.jpg?s=612x612&w=0&k=20&c=FY0PVOMC1NkQ9Ia7749vHhyqPtksPwKgk-HdE0M1WrY=', 1),-- salsa principiante
		('https://media.istockphoto.com/id/467293786/es/foto/pareja-de-baile-latino-en-acci%C3%B3n-samba-salvaje-de-baile.jpg?s=612x612&w=0&k=20&c=WcK-2A-ifW0Pt8uIb0Eq1A6hTfGX0k6NZH5R-3jnexY=', 1),
		('https://media.istockphoto.com/id/911529800/es/vector/ultra-violeta-grabado-de-una-raza-mixta-mujer-bailar-salsa.jpg?s=612x612&w=0&k=20&c=KOZe73KCy_oVEbQxnPj79DLRhagmnlQgtyAXc5Wx3uk=',1),
		('https://media.istockphoto.com/id/1175415462/es/vector/texto-nocturno-de-salsa-sobre-fondo-colorido.jpg?s=612x612&w=0&k=20&c=CQO4kmXpj_ps5A7qEAio5Bb51mkcdywZ2JadcB-IL2w=', 1),

		('https://media.istockphoto.com/id/535873133/es/foto/mujer-joven-contra-explosi%C3%B3n-de-baile-flamenco.jpg?s=612x612&w=0&k=20&c=KxXkiknZih4OP3K4f6vfYfTq1qUqqrPJ_vtOuhIMqjQ=', 2),-- salsa intermedio
		('https://media.istockphoto.com/id/822599876/es/vector/el-baile-de-salsa.jpg?s=612x612&w=0&k=20&c=k70PwWFMesqpDhm1SwsZsQ8e4nRCoJMy3sdQcc11Awk=', 2),
		('https://media.istockphoto.com/id/1370556766/es/foto/par-de-bailarines-bailando-baile-de-sal%C3%B3n-sobre-fondo-de-pintura-art%C3%ADstica-aviador.jpg?s=612x612&w=0&k=20&c=uKDpdD7C9E2W_LBHVUpz7cJ7RDB_MZCtN8M1CpmNR5w=', 2),
		('https://media.istockphoto.com/id/1536222099/es/vector/pareja-de-ancianos-bailan-ilustraci%C3%B3n-vectorial-divertida-pareja-de-ancianos-bailando.jpg?s=612x612&w=0&k=20&c=oJtiyOmtfN2fg2eUKVoenluc4xWdHyS46-5mURbPDpM=', 2),

		('https://media.istockphoto.com/id/1359873270/es/vector/ilustraci%C3%B3n-de-dibujos-animados-de-un-ni%C3%B1o-jugando-karate.jpg?s=612x612&w=0&k=20&c=6fdkJR1b5SyvWiJ1HjlI7WP-B0pdnybXWhb2uTcrKLk=', 4),-- Karate niños principiante
		('https://media.istockphoto.com/id/1227071974/es/vector/dise%C3%B1o-del-logotipo-de-esport-de-la-mascota-de-karate-martial.jpg?s=612x612&w=0&k=20&c=rrcnuA57-wxBCNA6DgOQ55G0h6SuILfwneQ-CILRfeY=', 4),
		('https://media.istockphoto.com/id/453933987/es/foto/la-chica-est%C3%A1-protegido-de-un-ni%C3%B1o-lanzar.jpg?s=612x612&w=0&k=20&c=CVPeUqTwdoO6lSHEBnXXOuZJ0Jp5HzWuBVcogd0CQww=', 4),
		('https://media.istockphoto.com/id/1403143477/es/vector/personaje-de-dibujos-animados-ninja-con-espada-katana.jpg?s=612x612&w=0&k=20&c=KEecjotFCbayUKTFTaIDTXY8R15JFk32DRZlB2oqieM=', 4)
;
GO
------------------------------------------
