USE Contacts;

DROP PROCEDURE IF EXISTS dbo.InsertContactAddress;

GO

CREATE PROCEDURE dbo.InsertContactAddress
(
 @ContactId		INT,
 @HouseNumber	VARCHAR(200),
 @Street		VARCHAR(200),
 @City			VARCHAR(200),
 @Postcode		VARCHAR(20)
)
AS
BEGIN;

SET NOCOUNT ON;

DECLARE @AddressId	INT;

--SELECT 	@ContactId = 24,
--		@HouseNumber = '10',
--		@Street = 'Downing Street',
--		@City = 'London',
--		@Postcode = 'SW1 2AA'

--PRINT 'street left: ' + UPPER(LEFT(@Street, 1));
--PRINT 'street right: ' + LOWER(RIGHT(@Street, LEN(@Street) -1));
--PRINT 'City left: ' + UPPER(LEFT(@City, 1));
--PRINT 'City right: ' + LOWER(RIGHT(@City, LEN(@City) - 1));

SELECT @Street = UPPER(LEFT(@Street, 1)) + LOWER(RIGHT(@Street, LEN(@Street) -1));
SELECT @City = UPPER(LEFT(@City, 1)) + LOWER(RIGHT(@City, LEN(@City) - 1));

PRINT 'street: ' + @Street;
PRINT 'city: ' + @City;

INSERT INTO dbo.ContactAddresses (ContactId, HouseNumber, Street, City, Postcode)
	VALUES (@ContactId, @HouseNumber, @Street, @City, @Postcode);

SELECT @AddressId = SCOPE_IDENTITY();

SELECT ContactId, AddressId, HouseNumber, Street, City, Postcode
	FROM dbo.ContactAddresses
WHERE ContactId = @ContactId;

SET NOCOUNT OFF;

END;