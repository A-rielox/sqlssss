USE Gym;
GO

DROP TABLE IF EXISTS dbo.Roles;


CREATE TABLE Roles
(
	id INT IDENTITY(1,1),
	name VARCHAR(20),
	normalizedName VARCHAR(20),
	
	CONSTRAINT PK_Roles_id PRIMARY KEY (id),
);

SELECT * FROM Roles;

INSERT INTO [dbo].[Roles] (name, normalizedName)
VALUES	('Admin', 'ADMIN'),
		('Member', 'MEMBER'),
		('Teacher', 'TEACHER')
;

SELECT * 
FROM Roles;


TRUNCATE TABLE Gym.dbo.Roles;