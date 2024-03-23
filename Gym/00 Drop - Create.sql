USE Gym
GO

DROP TABLE IF EXISTS dbo.Pictures;
GO

DROP TABLE IF EXISTS dbo.UserRoles;
GO

DROP TABLE IF EXISTS dbo.UserClase;
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
		('https://randomuser.me/api/portraits/men/93.jpg', 1, 11)
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
;
GO
-------------------------------------------

CREATE TABLE UserClase
(
	userId INT NOT NULL,
	claseId INT NOT NULL,
	
	CONSTRAINT PK_UserClase_id PRIMARY KEY (userId, claseId),
	CONSTRAINT FK_UserClase_userId FOREIGN KEY (userId) REFERENCES [AppUsers] (id),
	CONSTRAINT FK_UserClase_claseId FOREIGN KEY (claseId) REFERENCES [Clase] (id)
);

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
GO
-------------------------------------------

SELECT * FROM [AppUsers]
SELECT * FROM UserRoles
SELECT * FROM [Pictures]
SELECT * FROM [UserClase]
