
CREATE DATABASE SchoolManagementDb;
GO


--			p' cambiar el nombre
-- tambien me cambia el nombre del archivo
-- alter database SchoolManagementDb modify name = ScoolDb


USE SchoolManagementDb;

CREATE TABLE Students(
	Id INT PRIMARY KEY NOT NULL IDENTITY(1,1),
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	DateOfBirth DATE,
	StudentId NVARCHAR(10) UNIQUE,
	ProgrammeOfStudy NVARCHAR(150),
);

CREATE TABLE Lecturers(
	Id INT PRIMARY KEY NOT NULL IDENTITY(1,1),
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	DateOfBirth DATE,
	StaffId NVARCHAR(10) UNIQUE,
);

-- DROP TABLE Lecturers

CREATE TABLE Courses(
	Id INT PRIMARY KEY IDENTITY,
	Name NVARCHAR(50) NOT NULL,
	Code NVARCHAR(5) UNIQUE,
	Credits INT,
);

-- un courses es como matematicas y las classes es con quien da cada curso
--CREATE TABLE Classes (
--	Id INT PRIMARY KEY IDENTITY,
--	LecturerId INT FOREIGN KEY REFERENCES Lecturers(Id),
--	CourseId INT FOREIGN KEY REFERENCES Courses(Id),
--	[Time] TIME
--)


-- USE master
-- DROP DATABASE SchoolManagementDb;
