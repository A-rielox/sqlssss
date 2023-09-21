USE DatingSql;
GO

DROP PROCEDURE IF EXISTS dbo.sp_getMsg;
GO

CREATE PROCEDURE dbo.sp_getMsg
(
	@msgId INT
)
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN
	
	SELECT * 
	FROM Msgs
	WHERE id = @msgId
;
END
GO



EXEC dbo.sp_getMsg @msgId = 1
;

SELECT * FROM Msgs;
