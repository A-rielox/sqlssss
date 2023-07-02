-- ================================================
-- Template generated from Template Explorer using:
-- Create Scalar Function (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the function.
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

