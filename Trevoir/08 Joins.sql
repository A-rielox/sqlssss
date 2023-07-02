
USE SchoolManagementDb;

SELECT * FROM ProgrammesOfStudy;
SELECT * FROM students;
SELECT * FROM classes;
SELECT * FROM Courses;
SELECT * FROM Lecturers;
SELECT * FROM Enrollments;


SELECT *
FROM Students s
     JOIN ProgrammesOfStudy p ON s.ProgrammeOfStudyId = p.Id
;

SELECT co.Name [nombre-clase], 
       l.FirstName [clase-profe], 
       CONVERT(VARCHAR, c.Time, 8) [clase-hora]
FROM Classes c
     JOIN Lecturers l ON c.LecturerId = l.Id
     JOIN Courses co ON c.CourseId = co.Id
;


-- clases y quien enseña
SELECT * FROM Classes;

SELECT C.Id [Class Id], 
       l.FirstName [Lecturer Name], 
       c.Time [Class Hour]
FROM Classes c
     JOIN Lecturers l ON c.LecturerId = l.Id;
;

SELECT C.Id [Class Id], 
	   CASE
           WHEN l.FirstName IS NULL
           THEN 'Not Asigned'
           ELSE l.FirstName
       END [Lecturer Name],
	   convert(varchar, c.Time, 108) [Class Hour]
FROM Classes c
     LEFT JOIN Lecturers l ON c.LecturerId = l.Id;
;



