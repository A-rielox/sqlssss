USE SchoolManagementDb
GO

CREATE VIEW vw_StudentEnrollmentDetail
AS
     SELECT s.StudentId, -- min max avg grade
            s.FirstName + ' ' + s.LastName [student name],
			AVG([grade]) [Average Grade],
			MIN(Grade) [Lowest Grade],
			MAX(Grade) [Highest Grade],
			COUNT(Grade) [number of grades]
     FROM Enrollments e
          INNER JOIN Students s ON s.Id = e.StudentId
     GROUP BY s.StudentId, 
              s.FirstName, 
              s.LastName
;




-- DROP VIEW vw_StudentEnrollmentDetail;

