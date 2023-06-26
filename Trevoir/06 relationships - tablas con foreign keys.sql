USE SchoolManagementDb


-- ESTAS SON LAS LINKER TABLES DE MANY-TO-MANY

-- esto comentado lo hace en design
--CREATE TABLE ProgrammesOfStudy (
--	Id INT PRIMARY KEY IDENTITY,
--	Name NVARCHAR(150),
--	DurationInYears DECIMAL(10,2)
--)
-- puso la FK (ProgrammeOfStudyId) a esta en Courses y Students

CREATE TABLE Classes (
	Id INT PRIMARY KEY IDENTITY,
	LecturerId INT FOREIGN KEY REFERENCES Lecturers(Id),
	CourseId INT FOREIGN KEY REFERENCES Courses(Id),
	[Time] TIME
)

-- esta va despues xq hace referencia a la de arriba en ClassId
CREATE TABLE Enrollments (
	Id INT PRIMARY KEY IDENTITY,
	StudentId INT FOREIGN KEY REFERENCES Students(Id),
	ClassId INT FOREIGN KEY REFERENCES Classes(Id),
	Grade NVARCHAR(2)
)

-- DROP TABLE Enrollments;
-- DROP TABLE Classes;


-- un courses es como matematicas y las classes es con quien da cada curso
--CREATE TABLE Courses(
--	Id INT PRIMARY KEY IDENTITY,
--	Name NVARCHAR(50) NOT NULL,
--	Code NVARCHAR(5) UNIQUE,
--	Credits INT,
--);
