
USE SchoolManagementDb

INSERT INTO Courses(Name, Code, Credits)
	VALUES	('Database Development', 'DB101', 3),
			('C++', 'CP101', 3)
			

INSERT INTO Lecturers VALUES ('Trevoir','Williams','2000-12-25', NULL)
INSERT INTO Lecturers VALUES ('Rhodrey','Shaw','1995-11-25', '1011209435')

INSERT INTO Lecturers(LastName, FirstName, StaffId)
	VALUES	('Tajay', 'Reid', '1478523627'),
			('Lennon', 'Wilson', '1478533697'),
			('Howard', 'Bryant', '1478553697'),
			('Brittany', 'Wilson', '1478836973'),
			('Yanique', 'Foster', '1475523697')

-- SELECT * FROM Lecturers;
