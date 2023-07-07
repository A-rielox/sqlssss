
USE Contacts

DROP PROCEDURE IF EXISTS dbo.InsertContactNotes;
GO

CREATE PROCEDURE dbo.InsertContactNotes
(
	@ContactId	INT,
	@Notes		dbo.ContactNote READONLY --  READONLY xser TVP (parametro de tipo tabla)
)
AS
BEGIN;

	INSERT INTO dbo.ContactNotes (ContactId, Notes)
	SELECT	@ContactId,
			Note FROM @Notes;

	SELECT * FROM dbo.ContactNotes
		WHERE ContactId = @ContactId
	ORDER BY NoteId DESC;

END;



