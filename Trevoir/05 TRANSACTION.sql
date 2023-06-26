-- Transaction create a staging area for changes

/*
	BEGIN TRANSACTION
		DELETE SQL COMMANDS
		UPDATE SQL COMMANDS
		INSERT SQL COMMANDS
	COMMIT - To Confirm
	ROLLBACK - To Undo
*/

USE SchoolManagementDb;

SELECT * FROM Lecturers;

BEGIN TRANSACTION
	DELETE FROM Lecturers WHERE StaffId = '1478836973'
-- ROLLBACK
COMMIT
