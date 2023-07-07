USE Contacts;
GO

DROP PROCEDURE IF EXISTS dbo.InsertContact
GO

-- p' hacer un parametro opcional le paso un valor xdefault
CREATE PROCEDURE dbo.InsertContact
(
	@FirstName				VARCHAR(40),
	@LastName				VARCHAR(40),
	@DateOfBirth			DATE = NULL,
	@AllowContactByPhone	BIT,
	@ContactId				INT OUTPUT
)
AS
BEGIN

	SET NOCOUNT ON;

	IF NOT EXISTS 
	(
	SELECT 1 FROM dbo.Contacts
		WHERE FirstName = @FirstName AND
				LastName = @LastName AND
				(
					(DateOfBirth IS NULL AND @DateOfBirth IS NULL) OR
					(DateOfBirth = @DateOfBirth)
				)
	)
	BEGIN
		INSERT INTO dbo.Contacts
			(FirstName, LastName, DateOfBirth, AllowContactByPhone)
		VALUES
			(@FirstName, @LastName, @DateOfBirth, @AllowContactByPhone);

		SELECT @ContactId = SCOPE_IDENTITY();  -- retorna el ultimo identity value insertado en el sp actual
	END

	EXEC dbo.SelectContact @ContactId = @ContactId;

	SET NOCOUNT OFF;

END

