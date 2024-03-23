USE Gym;
GO

DROP TABLE IF EXISTS dbo.UserRoles;


CREATE TABLE UserRoles
(
	userId INT NOT NULL,
	roleId INT NOT NULL,
	
	CONSTRAINT PK_UserRoles_id PRIMARY KEY (userId, roleId),
	CONSTRAINT FK_UserRoles_userId FOREIGN KEY (userId) REFERENCES [AppUsers] (id),
	CONSTRAINT FK_UserRoles_roleId FOREIGN KEY (roleId) REFERENCES Roles (id)
);

SELECT * FROM UserRoles;


INSERT INTO [dbo].[UserRoles] (userId, roleId)
VALUES	(1, 1), (1, 2), (1, 3), (2, 2), (3, 2), (4, 2),
		(5, 2), (6, 2), (7, 2), (8, 2), (9, 2),
		(10, 2), (11, 2)
		,(12, 3), (13, 3), (14, 3) -- profes
;

SELECT * FROM [AppUsers]
SELECT * FROM [Roles]
SELECT * FROM UserRoles;

--TRUNCATE TABLE Gym.dbo.UserRoles;