USE LaAppSql;
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


--TRUNCATE TABLE DatingSql.dbo.UserRoles;

INSERT INTO [dbo].[UserRoles] (userId, roleId)
VALUES	(1, 2), (1, 3), (2, 1), (3, 1), (4, 1),
		(5, 1), (6, 1), (7, 1), (8, 1), (9, 1),
		(10, 1), (11, 1)
;

SELECT * FROM [AppUsers]
SELECT * FROM [Roles]
SELECT * FROM UserRoles;

TRUNCATE TABLE LaAppSql.dbo.UserRoles;