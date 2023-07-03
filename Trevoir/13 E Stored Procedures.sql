USE [SchoolManagementDb]
GO
/****** Object:  StoredProcedure [dbo].[spins_AddStudent]    Script Date: 02/07/2023 16:26:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		A-rielox
-- Create date: <Create Date,,>
-- Description:	Add Student
-- =============================================
ALTER PROCEDURE [dbo].[spins_AddStudent]
	-- Add the parameters for the stored procedure here
	@StudentId NVARCHAR(10),
	@LastName NVARCHAR(50),
	@FirstName NVARCHAR(50),
	@DateOfBirth DATE,
	@ProgrammeId INT = NULL,
	@id INT OUTPUT -- --------------> output parameter
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Students VALUES 
		(@FirstName, @LastName, @DateOfBirth, @StudentId, @ProgrammeId)

	-- SCOPE_IDENTITY() me devuelve la id de la operacion
	SELECT @id = SCOPE_IDENTITY()
END
