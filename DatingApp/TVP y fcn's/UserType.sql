
USE TestSql;
GO


DROP TYPE IF EXISTS dbo.UserType;

GO

CREATE TYPE dbo.UserType
AS TABLE
(
	id INT,
	userName VARCHAR(50),
	passwordHash VARBINARY(MAX),
	passwordSalt VARBINARY(MAX),
	dateOfBirth DATETIME,
	knownAs VARCHAR(50),
    created DATETIME,
    lastActive DATETIME,
    gender VARCHAR(50),
    introduction VARCHAR(2500),
    lookingFor VARCHAR(2500),
    interests VARCHAR(2500),
    city VARCHAR(200),
    country VARCHAR(200)
);



