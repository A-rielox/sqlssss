SELECT * FROM Lecturers;

SELECT FirstName, LastName, StaffId 
	FROM Lecturers


SELECT	FirstName as 'First Name',
		LastName as 'Last Name',
		StaffId as 'Staff Id'
FROM Lecturers


--					  FILTER
SELECT * FROM Lecturers;
SELECT * FROM Lecturers
	WHERE Id = 5


SELECT * FROM Lecturers;
SELECT * FROM Lecturers
	WHERE FirstName = 'Tajay' OR LastName = 'Tajay'

SELECT * FROM Lecturers;
SELECT * FROM Lecturers
	WHERE FirstName = 'Reid' AND LastName = 'Tajay'

SELECT * FROM Lecturers
	WHERE FirstName LIKE 'R%';


-- lo q pongo en el where no tiene q necesariamente estar
-- dentro de lo que hago select
SELECT FirstName, LastName, StaffId 
	FROM Lecturers
	WHERE StaffId IS NULL;

-- para q no aparesca el NULL de staffId
SELECT	FirstName,		
		LastName, 
		StaffId,
		CASE WHEN StaffId IS NULL 
			 THEN 'Sin Inscripcion' ELSE StaffId
		END [Staff Id]
	FROM Lecturers;