

USE Contacts;


EXEC dbo.InsertContactAddress
		@ContactId = 24,
		@HouseNumber = '10',
		@Street = 'Downing Street',
		@City = 'Londonon',
		@Postcode = 'SW1 2AA'
;





-- p' contactRoles
USE Contacts;


EXEC dbo.InsertContactRole
		@ContactId = 22,
		@RoleTitle = 'Comedian'
;


--DELETE FROM Roles WHERE RoleTitle = 'Comedian'
--;
SELECT * FROM Roles;
SELECT * FROM ContactRoles;





