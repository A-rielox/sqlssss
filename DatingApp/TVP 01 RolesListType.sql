USE DatingSql;
GO


DROP TYPE IF EXISTS dbo.RolesListType;
GO

CREATE TYPE dbo.RolesListType
AS TABLE
(
	rolesName VARCHAR(20)
);

