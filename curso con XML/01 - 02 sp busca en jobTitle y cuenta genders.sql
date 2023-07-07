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

DROP PROCEDURE IF EXISTS dbo.Filter_procedure;
GO

CREATE PROCEDURE Filter_procedure
	-- Add the parameters for the stored procedure here
	@jobTitle1 NVARCHAR(30),
	@jobTitle2 NVARCHAR(30) = NULL
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @search NVARCHAR(MAX)

	SET @jobTitle1 = TRIM(@jobTitle1)
	SET @jobTitle2 = ' ' + TRIM(@jobTitle2)

	IF @jobTitle2 IS NULL -- solo 1 palabra
		BEGIN
			SET @search = '%' + @jobTitle1 + '%'
		END
	ELSE
		BEGIN
			SET @search = '%' + @jobTitle1 + @jobTitle2 + '%'
		END

	DECLARE @dynamic NVARCHAR(MAX)
	SET @dynamic = '
					SELECT	JobTitle,
							COUNT(CASE WHEN GENDER = ''M'' THEN 1 END) AS Male,
							COUNT(CASE WHEN GENDER = ''F'' THEN 1 END) AS Female
					FROM HumanResources.Employee
					WHERE JobTitle LIKE @searchParam
					GROUP BY JobTitle;
					'

    -- Insert statements for procedure here
	EXEC sp_executesql @dynamic, N'@searchParam NVARCHAR(100)', @searchParam = @search
END
GO
