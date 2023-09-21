USE DatingSql;
GO

DROP PROCEDURE IF EXISTS [dbo].[sp_addMsg];
GO

CREATE PROCEDURE [dbo].[sp_addMsg]
(
    @senderId INT,
    @senderUsername VARCHAR(50), -- nullable
    @recipientId INT,
    @recipientUsername VARCHAR(50), -- nullable
    @content VARCHAR(2500) -- nullable
)
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN

	BEGIN TRY
	
		INSERT INTO [dbo].[Msgs] (
									SenderId, SenderUsername, RecipientId,
									RecipientUsername, Content
								 )
		VALUES (
				@senderId, @senderUsername, @recipientId,
				@recipientUsername, @content
			   );

		SELECT @@ROWCOUNT;

	END TRY
	BEGIN CATCH

		SELECT 0;

	END CATCH
;

END
GO



EXEC [dbo].[sp_addMsg]	@senderId = 2,
						@senderUsername = 'Karen',
						@recipientId = 7,
						@recipientUsername = 'Porter',
						@content = 'Mensaje desde sp Karen a Porter'
;

SELECT * FROM [Msgs];

--TRUNCATE TABLE DatingAppSqlS.dbo.Users;