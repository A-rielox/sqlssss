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
CREATE TRIGGER dbo.AssignProgrammeOfStudyIdToStudent
   ON  dbo.Students
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
	DECLARE @programmeId INT
	DECLARE @Id INT
	
	SELECT @programmeId = ProgrammeOfStudyId,
		   @Id = Id 
	FROM inserted

	IF @programmeId IS NULL
	BEGIN
		UPDATE Students SET ProgrammeOfStudyId = 6
			WHERE Id = @Id
	END
END
GO
