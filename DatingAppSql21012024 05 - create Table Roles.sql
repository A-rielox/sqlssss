USE DatingAppSql21012024;
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
VALUES	('Member', 'MEMBER'),
		('Admin', 'ADMIN'),
		('Moderator', 'MODERATOR')
;

SELECT * 
FROM Roles;


TRUNCATE TABLE DatingSql.dbo.Roles;