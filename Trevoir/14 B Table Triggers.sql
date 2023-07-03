
USE SchoolManagementDb
GO

DECLARE @idCreated INT

EXEC [dbo].[spins_AddStudent]
	'8463954763', 'Godoy', 'Pepi', '2006-06-19', NULL, @idCreated OUTPUT
;
-- trae student con un id
EXEC [dbo].[sp_SelectStudentById] @id = @idCreated


