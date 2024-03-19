USE LaAppSql;
GO

DROP TABLE IF EXISTS dbo.AppUsers;


CREATE TABLE AppUsers
(
	Id INT IDENTITY(1,1),
	UserName VARCHAR(50) NOT NULL,
	PasswordHash VARCHAR(MAX),
	KnownAs VARCHAR(50),
    Created DATETIME DEFAULT GETDATE(),
    LastActive DATETIME DEFAULT GETDATE(),
    Introduction VARCHAR(2500),
    Interests VARCHAR(2500),
    City VARCHAR(200),
    Country VARCHAR(200),

	Email VARCHAR(50) NOT NULL,
	NormalizedEmail VARCHAR(50) NOT NULL,


	CONSTRAINT PK_Users_id PRIMARY KEY (ID)
);

SELECT * FROM AppUsers;

DECLARE @Hash VARCHAR(MAX) = 'AQAAAAIAAYagAAAAEC5owvdnPSxx7dGsh6TgaYYlube2B0ZMmmgJOO60BJuMd6ayKkCXcnGFZvVzOY0PnQ==';


INSERT INTO [dbo].[AppUsers] (UserName, KnownAs, Created, LastActive, Introduction, Interests, City, Country, PasswordHash, Email, NormalizedEmail)
VALUES	('Admin', 'Admin', '1980-05-01', '1980-05-01', '...', '...', '...', '...', @Hash, 'Admin', 'ADMIN' ),
		('Lisa', 'Lisa', '2020-06-24', '2020-06-21', 'Dolor anim cupidatat occaecat aliquip et Lorem ut elit fugiat. Mollit eu pariatur est sunt. Minim fugiat sit do dolore eu elit ex do id sunt. Qui fugiat nostrud occaecat nisi est dolor qui fugiat laborum cillum. Occaecat consequat ex mollit commodo ad irure cillum nulla velit ex pariatur veniam cupidatat. Officia veniam officia non deserunt mollit.', 'Sit sit incididunt proident velit.', 'Greenbush', 'Martinique', @Hash, 'Lisa','LISA'),
		('Karen', 'Karen', '2019-12-09', '2020-05-06', 'Dolor magna eu reprehenderit nostrud do et. Amet voluptate ut laboris ut officia eiusmod exercitation elit labore anim. In consequat ut ex adipisicing irure. Sit proident sint laboris est proident aute mollit minim et mollit. Cillum in enim velit occaecat aliquip. Voluptate aliquip et culpa est ad proident elit duis.', 'Dolor aliquip velit amet aliqua minim labore sit laboris non aliquip cillum.', 'Celeryville', 'Grenada', @Hash, 'Karen', 'KAREN'),
		('Margo', 'Margo', '2019-08-10', '2020-05-12', 'Magna consectetur amet sint aliqua cillum proident commodo. Irure aute ad do dolore sunt aliqua sint aliqua sint. Qui eiusmod veniam qui adipisicing id incididunt non. Ad occaecat proident eiusmod ex dolor aliqua velit laboris qui cillum Lorem enim ex enim. Magna nisi duis minim deserunt.', 'Commodo do eiusmod quis labore est non.', 'Rosewood', 'Svalbard and Jan Mayen Islands', @Hash, 'Margo','MARGO'),
		('Lois', 'Lois', '2019-04-24', '2020-06-17', 'Dolor est cupidatat dolor cupidatat cillum amet veniam eiusmod aliqua adipisicing aliquip proident adipisicing. Non nulla ex nisi magna ut cillum Lorem ad. Fugiat nulla laboris consequat excepteur ut est veniam voluptate ut officia anim reprehenderit proident sunt. Do proident laboris consequat laboris cillum minim reprehenderit velit.', 'Duis in est laboris anim pariatur incididunt mollit laboris ea velit aliquip cillum.', 'Orviston', 'Zimbabwe', @Hash, 'Lois', 'LOIS'),
		('Ruthie', 'Ruthie', '2019-04-30', '2020-06-21', 'Est quis dolore duis excepteur exercitation reprehenderit ipsum elit aliquip dolor nostrud. Sint incididunt sunt deserunt pariatur pariatur minim velit voluptate consequat amet qui. Sit cillum ullamco culpa deserunt commodo culpa ad anim. Do aliqua aute proident eiusmod esse veniam ipsum nisi anim veniam ut aliquip incididunt culpa.', 'Elit Lorem aliquip deserunt cupidatat ex aliquip ullamco.', 'Germanton', 'Antigua and Barbuda', @Hash, 'Ruthie','RUTHIE'),
		('Todd', 'Todd', '2019-04-29', '2020-05-16', 'Magna ex non ullamco ipsum commodo minim cupidatat sit. Sint dolor enim amet cupidatat. Anim et ea officia ea officia veniam adipisicing tempor. Labore consequat in duis deserunt tempor aliqua. Eu incididunt id deserunt proident ullamco aliqua culpa officia anim deserunt fugiat amet voluptate qui. In id non sint sint aliqua commodo reprehenderit excepteur cillum Lorem minim.', 'Esse cillum deserunt fugiat deserunt irure ea esse deserunt quis exercitation velit do nisi reprehenderit.', 'Cliff', 'British Indian Ocean Territory', @Hash, 'Todd', 'TODD'),
		('Porter', 'Porter', '2020-04-05', '2020-06-23', 'Officia id adipisicing duis culpa aute voluptate Lorem quis aliquip qui. Cupidatat aliquip amet reprehenderit excepteur amet et est dolore est. Veniam pariatur elit non ullamco labore quis do. Ad non cillum nisi non. Non cupidatat nisi fugiat officia tempor officia sunt qui duis.', 'Aliquip proident pariatur excepteur incididunt irure et.', 'Welda', 'Christmas Island', @Hash, 'Porter', 'PORTER'),
		('Mayo', 'Mayo', '2020-03-14', '2020-05-17', 'Duis tempor amet officia irure amet do ipsum est dolore culpa id Lorem exercitation labore. Cupidatat minim duis nulla occaecat excepteur anim laboris id culpa ullamco culpa. Ullamco mollit labore mollit esse labore eiusmod elit enim voluptate laborum irure amet eu in. Pariatur consectetur Lorem velit incididunt excepteur. Magna proident nulla ex laboris veniam tempor proident nisi elit. Ex tempor excepteur eiusmod et occaecat laboris ad ex veniam voluptate. Ipsum mollit voluptate nulla eiusmod nostrud sit anim anim qui est aute pariatur sint.', 'Duis consectetur proident labore velit minim irure proident incididunt officia duis.', 'Clarence', 'Burkina Faso', @Hash, 'Mayo', 'MAYO'),
		('Skinner', 'Skinner', '2019-01-28', '2020-06-07', 'Sunt est cillum nisi officia cupidatat sit ullamco. Labore aliquip pariatur amet velit labore cillum irure dolor. Anim ut cupidatat qui pariatur veniam eu. Eu est cillum non amet consectetur deserunt eiusmod ea sint nostrud quis ipsum cillum. Irure id et minim do nostrud consectetur quis ex duis nostrud dolor. Veniam enim sint proident officia sint enim eiusmod occaecat adipisicing do ad proident.', 'Pariatur qui ut commodo laboris officia.', 'Herald', 'Poland', @Hash, 'Skinner', 'SKINNER'),
		('Davis', 'Davis', '2020-02-25', '2020-06-11', 'Do do minim est incididunt minim qui aliqua nulla pariatur culpa pariatur culpa non. Aliquip esse quis ullamco sint voluptate. Eiusmod reprehenderit nostrud elit eu. Sit est incididunt elit excepteur eu non. Non tempor labore nisi consequat excepteur magna non velit. Nostrud labore ex nostrud magna adipisicing aute exercitation ad in incididunt pariatur anim. Officia dolor proident nulla laboris quis.', 'Labore consectetur labore ut nulla voluptate nulla quis labore tempor dolor laborum.', 'Lupton', 'Luxembourg', @Hash, 'Davis', 'DAVIS')
;

SELECT * FROM AppUsers;


--TRUNCATE TABLE LaAppSql.dbo.AppUsers;
SELECT * FROM AppUsers;

ALTER TABLE [Pictures] DROP CONSTRAINT FK_Pictures_appUserId;
ALTER TABLE [UserRoles] DROP CONSTRAINT FK_UserRoles_userId;


ALTER TABLE [Pictures] ADD CONSTRAINT FK_Pictures_appUserId FOREIGN KEY (appUserId) REFERENCES AppUsers (id);
ALTER TABLE [UserRoles] ADD CONSTRAINT FK_UserRoles_userId FOREIGN KEY (userId) REFERENCES [AppUsers] (id);
