USE DatingAppSql21012024;
GO

DROP PROCEDURE IF EXISTS dbo.sp_addPhoto;
GO


CREATE PROCEDURE dbo.sp_addPhoto
(
	@url VARCHAR(500),
	@publicId VARCHAR(500),
	@appUserId INT,
	@isMain INT
)
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN

	INSERT INTO [dbo].[Photos] ( url, publicId, appUserId, isMain )
	VALUES ( @url, @publicId, @appUserId, @isMain );

	-- retorno el id creado
	select SCOPE_IDENTITY();
;

END
GO


--EXEC dbo.sp_addPhoto	
--;
