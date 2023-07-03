-- ================================================
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		A-rielox
-- Create date: <Create Date, ,>
-- Description:	Get student highest grade
-- =============================================
CREATE FUNCTION fnc_GetStudentHighestGrade 
(
	-- Add the parameters for the function here
	@StudentId int
)
RETURNS decimal(3,1)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @HighestGrade decimal(3,1)

	-- Add the T-SQL statements to compute the return value here
	SELECT @HighestGrade = MAX(Grade) FROM Enrollments 
									  WHERE StudentId = @StudentId

	-- Return the result of the function
	RETURN @HighestGrade

END
GO

