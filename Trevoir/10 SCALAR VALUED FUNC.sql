
--			SCALAR VALUED FUNC

-- retornan un valor
-- las aggregate func son scalar valued func

-- me voy a programmability y en Scalar-valued Functions
-- le pico a "New Scalar Valued Functions" y me genera el template


--		TIENE Q SER EN EL ARCHIVO NUEVO, SINO, ME LA PONE EN MASTER


-- ================================================
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		A-rielox
-- Create date: <Create Date, ,>
-- Description:	Returns Highest Grade
-- =============================================
CREATE FUNCTION fnc_GetHighestGrade 
(
	-- Add the parameters for the function here
	-- <@Param1, sysname, @p1> <Data_Type_For_Param1, , int>
)
RETURNS decimal(3,1)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @HighestGrade decimal(3,1)

	-- Add the T-SQL statements to compute the return value here
	SELECT @HighestGrade = MAX(Grade) FROM [dbo].[Enrollments]

	-- Return the result of the function
	RETURN @HighestGrade

END
GO


--
--
--

USE SchoolManagementDb
GO


SELECT [dbo].[fnc_GetHighestGrade]() [Highest Grade];

SELECT * FROM Enrollments;
SELECT [dbo].[fnc_GetStudentHighestGrade](4) ;


-- para modificarla le pico "modify" sobre la fcn
-- modifico
-- corro


