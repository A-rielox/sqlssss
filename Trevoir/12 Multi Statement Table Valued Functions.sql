
--		Multi Statement Table Valued Functions

-- ================================================
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION fcn_GetAllSchoolPersonnel 
(
	-- Add the parameters for the function here
	-- <@param1, sysname, @p1> <data_type_for_param1, , int>, 
	-- <@param2, sysname, @p2> <data_type_for_param2, , char>
)
RETURNS 
@persons TABLE 
(
	-- Add the column definitions for the TABLE variable here
	SchoolId NVARCHAR(10),
	Name NVARCHAR(100),
	DateOfBirth DATE,
	PersonType NVARCHAR(15)
)
AS
BEGIN
	-- Fill the table variable with the rows for your result set
	
	INSERT INTO @persons
	SELECT StudentId,
		   FirstName + ' ' + LastName,
		   DateOfBirth,
		   'Student'
	FROM Students

	INSERT INTO @persons
	SELECT StaffId,
		   FirstName + ' ' + LastName,
		   DateOfBirth,
		   'Lecturer'
	FROM Lecturers

	RETURN 
END
GO