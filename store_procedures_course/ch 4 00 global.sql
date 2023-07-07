
USE Contacts;

exec dbo.InsertContactNotes
	@ContactId = 22,
	@Notes = 'Ollie called, He wants you to ring him back., Hal Roach agreed to meet., Way Out West is a big hit!';



-- p' checar q un dato este con un formato que yo quiera => creo un "Type"

--	en otro archivo


--USE Contacts;

--GO

--CREATE TYPE dbo.DrivingLicense
--FROM CHAR(16) NOT NULL;

--

USE Contacts;

-- si tiene + caracteres los va a cortar
DECLARE @DV dbo.DrivingLicense = 'LAUREL98741UD176H';

SELECT @DV; -- LAUREL98741UD176


-- para borrar un tipo

DROP TYPE IF EXISTS dbo.DrivingLicense;
-- lo dropea solo si otros objetos no dependen de el



-- p' pasar las notas con TVP

USE Contacts;

DECLARE @TempNotes	dbo.ContactNote;

INSERT INTO @TempNotes (Note) VALUES
	('Hi, Peter called333.'),
	('Quick note to let you know Jo wants you to ring her. She rang at 14:30333.'),
	('Terri asked about the quote, I have asked her to ring back tomorrow333.')

EXEC dbo.InsertContactNotes
	@ContactId = 21,
	@Notes = @TempNotes
;

