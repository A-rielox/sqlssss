-- Inserting records in One-to-many related tables
USE SchoolManagementDb;

SELECT * FROM ProgrammesOfStudy;

--			ONE TO MANY

SET IDENTITY_INSERT ProgrammesOfStudy OFF;

INSERT INTO ProgrammesOfStudy (Id, Name, DurationInYears) VALUES
	(1,'Bsc. in Information Technology', 4),
	(2,'Bsc. in Teaching', 2),
	(3,'ASc. in Gardening', 2),
	(4,'ASc. in Finance', 2);



SELECT * FROM Courses;
UPDATE Courses SET ProgrammeOfStudyId = 1;

INSERT INTO students VALUES 
	('Peter', 'Johnson', '1991-08-09', '1478523685', 1),
	('Peter', 'Pan', '1991-08-09', '1478523756', 2),
	('John', 'Paul', '1991-08-09', '1478523678', 3),
	('Matthew', 'Swanson', '1991-08-09', '1278523696', 3);
SELECT * FROM Students;




-- MANY TO MANY

SELECT * FROM Lecturers;
SELECT * FROM Courses;

INSERT INTO Classes VALUES 
	(4,	4, '12:00'), 
	(4,	5, '13:00'), 
	(3,	4, '10:00'), 
	(7,	4, '08:00'), 
	(7,	6, '15:00');

SELECT * FROM Classes;



SELECT * FROM classes;
SELECT * FROM students;
SELECT * FROM Enrollments;

insert into Enrollments values
(1, 1, NULL), 
(1, 3, NULL), 
(2, 1, NULL), 
(4, 1, NULL), 
(4, 5, NULL)


-- 34