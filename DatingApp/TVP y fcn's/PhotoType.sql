
USE TestSql;
GO


DROP TYPE IF EXISTS dbo.PhotoType;
GO

CREATE TYPE dbo.PhotoType
AS TABLE
(
	id INT,
	url VARCHAR(500),
	isMain BIT, -- 0 false, 1 true
	publicId VARCHAR(500),
	appUserId INT
);

