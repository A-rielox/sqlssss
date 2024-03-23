USE Gym;
GO

DROP TABLE IF EXISTS dbo.AppUsers;
GO

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

SELECT * FROM AppUsers;

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

SELECT * FROM AppUsers;


--TRUNCATE TABLE Gym.dbo.AppUsers;
--SELECT * FROM AppUsers;

--ALTER TABLE [Pictures] DROP CONSTRAINT FK_Pictures_appUserId;
--ALTER TABLE [UserRoles] DROP CONSTRAINT FK_UserRoles_userId;

--ALTER TABLE [Pictures] ADD CONSTRAINT FK_Pictures_appUserId FOREIGN KEY (appUserId) REFERENCES AppUsers (id);
--ALTER TABLE [UserRoles] ADD CONSTRAINT FK_UserRoles_userId FOREIGN KEY (userId) REFERENCES [AppUsers] (id);
