-- ================================================
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		A-rielox
-- Create date: <Create Date,,>
-- Description:	Return Grades between two values
-- =============================================
CREATE FUNCTION fnc_GetGradeRange 
(	
	-- Add the parameters for the function here
	@MinGrade decimal(3,1), 
	@MaxGrade decimal(3,1)
)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	SELECT Grade FROM Enrollments  -- ******---------> puedo devolver varias cols
		WHERE Grade BETWEEN @MinGrade AND @MaxGrade
)
GO
