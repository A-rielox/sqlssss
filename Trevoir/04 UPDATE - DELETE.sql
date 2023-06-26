
--						UPDATE

USE  SchoolManagementDb;

SELECT * FROM Lecturers;
UPDATE Lecturers SET DateOfBirth = '1988-02-05', 
					 FirstName = 'Britt'
				 WHERE Id = 6;


SELECT * FROM Lecturers WHERE DateOfBirth IS NULL;
UPDATE Lecturers SET DateOfBirth = '1000-01-01'
				 WHERE DateOfBirth IS NULL;




--						DELETE

INSERT INTO Lecturers(LastName, FirstName, StaffId)
	VALUES	('Tajay6', 'Reid', '1978523627'),
			('Tajay7', 'Reid', '2078523627'),
			('Tajay8', 'Reid', '2178523627'),
			('Tajay9', 'Reid', '2278523627');
			

SELECT * FROM Lecturers;

SELECT * FROM Lecturers 
			WHERE LastName <> 'Tajay' AND FirstName = 'Reid';

DELETE FROM Lecturers
			WHERE LastName <> 'Tajay' AND FirstName = 'Reid';

