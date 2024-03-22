

DROP TABLE IF EXISTS dbo.Pictures;
GO

DROP TABLE IF EXISTS dbo.UserRoles;
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


SELECT * FROM [AppUsers]
SELECT * FROM [Roles]
SELECT * FROM UserRoles;
SELECT * FROM [Pictures]
