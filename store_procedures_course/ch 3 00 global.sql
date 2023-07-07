USE Contacts;


-- EXEC dbo.InsertContact 'Oliver', 'Hardy', '1892-01-18', 0;

DECLARE @ContactIdOut	INT;

EXEC dbo.InsertContact
		@FirstName = 'Harolds5',
		@LastName = 'Lloyds5',
		@DateOfBirth = '1921-07-14',
		@AllowContactByPhone = 0,
		@ContactId = @ContactIdOut OUTPUT
;

-- SELECT * from Contacts ORDER BY ContactId DESC;

-- SELECT @ContactIdOut;


