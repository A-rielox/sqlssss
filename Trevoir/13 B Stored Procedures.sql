
USE SchoolManagementDb;


-- sp q trae todos los estudiantes
exec [dbo].[sp_SelectAllStudents];

-- sp q trae uno pasando Id
-- para pasar los parametros
exec [dbo].[sp_SelectStudentById] @Id = 3;




-- sp q inserta estudiante
SELECT * FROM Students;

 exec [dbo].[spins_AddStudent]
	@StudentId = '7896541230',
	@LastName = 'Thomson',
	@FirstName = 'Abbi',
	@DateOfBirth = '2000-03-05',
	@ProgrammeId = 1
;

 exec [dbo].[spins_AddStudent]
	@StudentId = '7899991230',
	@LastName = 'Thomson',
	@FirstName = 'Felicia',
	@DateOfBirth = '2001-05-05'
;

SELECT * FROM Students;





-- se modifico p' entregar un output parameter, devuelve el id
-- del student creado
-- al pasar los parametros si estan en el mismo orden => puedo na mas pasarlos asi

DECLARE @idCreated INT

EXEC [dbo].[spins_AddStudent]
	'7858957491', 'Martinez', 'Sindy', '1982-12-01', 1, @idCreated OUTPUT
;

-- SELECT @idCreated [Id created];

-- o lo veo con mi otro sp
EXEC [dbo].[sp_SelectStudentById] @id = @idCreated


