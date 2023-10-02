USE TestSql;
GO

DROP TABLE IF EXISTS dbo.Users;


CREATE TABLE Users
(
	id INT IDENTITY(1,1),
	userName VARCHAR(50) NOT NULL,
	passwordHash VARBINARY(MAX),
	passwordSalt VARBINARY(MAX),
	dateOfBirth DATETIME,
	knownAs VARCHAR(50),
    created DATETIME DEFAULT GETDATE(),
    lastActive DATETIME DEFAULT GETDATE(),
    gender VARCHAR(50),
    introduction VARCHAR(2500),
    lookingFor VARCHAR(2500),
    interests VARCHAR(2500),
    city VARCHAR(200),
    country VARCHAR(200),

	CONSTRAINT PK_Users_id PRIMARY KEY (ID)
);

SELECT * 
FROM Users;

DECLARE @Hash VARBINARY(MAX) = 0xA05D16B0AACB81D0499A5B0825889C9B73E6D9D2A60C78C0008A6C73D63602FF9ACB26A0AB83307B1A6E4048FB74A65B4E5C780E37D25543E11EE6BF57404F05;
DECLARE @Salt VARBINARY(MAX) = 0x63E67D0821643412FDE71BF04491A9B198FA88E1E06E82D0A666BA758828EF9973C9616E874B95B39F3AB4074F24FFBE91256B9E97F8FABE70FC8DF666D3F94A7CC87A86CF59C30E8A2F8CB8147E17A2C3418C2599ABFF7257C5D4A2797CEE87581553595D70729DF0F85D0B4F83BCA43F27CA972C4E35ABD9ED68708EFF089E;


INSERT INTO [dbo].[Users] (userName, gender, dateOfBirth, knownAs, created, lastActive, introduction, lookingFor, interests, city, country, passwordHash, passwordSalt)
VALUES	('Admin', 'male', '1980-05-01', 'Admin', '1980-05-01', '1980-05-01', '...', '...', '...', '...', '...', @Hash, @Salt),
		('Lisa', 'female', '1956-07-22', 'Lisa', '2020-06-24', '2020-06-21', 'Sunt esse aliqua ullamco in incididunt consequat commodo. Nisi ad esse elit ipsum commodo fugiat est ad. Incididunt nostrud incididunt nostrud sit excepteur occaecat.', 'Dolor anim cupidatat occaecat aliquip et Lorem ut elit fugiat. Mollit eu pariatur est sunt. Minim fugiat sit do dolore eu elit ex do id sunt. Qui fugiat nostrud occaecat nisi est dolor qui fugiat laborum cillum. Occaecat consequat ex mollit commodo ad irure cillum nulla velit ex pariatur veniam cupidatat. Officia veniam officia non deserunt mollit.', 'Sit sit incididunt proident velit.', 'Greenbush', 'Martinique', @Hash, @Salt),
		('Karen', 'female', '1995-10-12', 'Karen', '2019-12-09', '2020-05-06', 'Laborum dolore aliquip voluptate sunt cupidatat fugiat. Aliqua cillum deserunt do sunt ullamco aute Lorem nisi irure velit esse excepteur ex qui. Aliquip cupidatat officia ullamco duis veniam quis elit dolore nisi proident exercitation id cillum ullamco. In exercitation aliqua commodo veniam culpa duis commodo mollit et sint culpa.', 'Dolor magna eu reprehenderit nostrud do et. Amet voluptate ut laboris ut officia eiusmod exercitation elit labore anim. In consequat ut ex adipisicing irure. Sit proident sint laboris est proident aute mollit minim et mollit. Cillum in enim velit occaecat aliquip. Voluptate aliquip et culpa est ad proident elit duis.', 'Dolor aliquip velit amet aliqua minim labore sit laboris non aliquip cillum.', 'Celeryville', 'Grenada', @Hash, @Salt),
		('Margo', 'female', '1959-01-24', 'Margo', '2019-08-10', '2020-05-12', 'Dolor ut mollit sunt fugiat magna do eu et aliqua. Dolor consectetur reprehenderit irure non adipisicing ad irure sint id amet reprehenderit esse consectetur ex. Nisi sunt minim amet dolore eiusmod occaecat commodo nostrud tempor dolore velit. Fugiat labore duis nulla do officia voluptate ullamco. Velit ex ullamco cillum amet qui anim et ullamco adipisicing fugiat exercitation aliqua. Consectetur et do labore enim aliqua occaecat.', 'Magna consectetur amet sint aliqua cillum proident commodo. Irure aute ad do dolore sunt aliqua sint aliqua sint. Qui eiusmod veniam qui adipisicing id incididunt non. Ad occaecat proident eiusmod ex dolor aliqua velit laboris qui cillum Lorem enim ex enim. Magna nisi duis minim deserunt.', 'Commodo do eiusmod quis labore est non.', 'Rosewood', 'Svalbard and Jan Mayen Islands', @Hash, @Salt),
		('Lois', 'female', '1988-06-22', 'Lois', '2019-04-24', '2020-06-17', 'Cillum elit nostrud enim laboris pariatur labore ipsum ut. Quis elit irure sint velit laboris anim Lorem laboris. Labore reprehenderit magna officia aliquip pariatur ea id id commodo. Culpa duis non ex nisi. Deserunt pariatur aliqua consequat reprehenderit sunt ex exercitation.', 'Dolor est cupidatat dolor cupidatat cillum amet veniam eiusmod aliqua adipisicing aliquip proident adipisicing. Non nulla ex nisi magna ut cillum Lorem ad. Fugiat nulla laboris consequat excepteur ut est veniam voluptate ut officia anim reprehenderit proident sunt. Do proident laboris consequat laboris cillum minim reprehenderit velit.', 'Duis in est laboris anim pariatur incididunt mollit laboris ea velit aliquip cillum.', 'Orviston', 'Zimbabwe', @Hash, @Salt),
		('Ruthie', 'female', '1956-01-12', 'Ruthie', '2019-04-30', '2020-06-21', 'Qui ipsum voluptate exercitation officia nisi velit adipisicing exercitation sint nulla do. Qui fugiat non nisi excepteur et duis elit consectetur ullamco velit fugiat. Sit do esse cupidatat quis eiusmod cupidatat.', 'Est quis dolore duis excepteur exercitation reprehenderit ipsum elit aliquip dolor nostrud. Sint incididunt sunt deserunt pariatur pariatur minim velit voluptate consequat amet qui. Sit cillum ullamco culpa deserunt commodo culpa ad anim. Do aliqua aute proident eiusmod esse veniam ipsum nisi anim veniam ut aliquip incididunt culpa.', 'Elit Lorem aliquip deserunt cupidatat ex aliquip ullamco.', 'Germanton', 'Antigua and Barbuda', @Hash, @Salt),
		('Todd', 'male', '1950-02-07', 'Todd', '2019-04-29', '2020-05-16', 'Mollit elit cillum dolore ea laboris consequat excepteur eiusmod eiusmod qui magna mollit occaecat. Sint qui ut veniam non. Est non veniam magna in consectetur ullamco eiusmod in elit aute ea ipsum aliquip. Duis nisi do dolore ad. Consectetur incididunt quis exercitation aliquip officia. Ex anim pariatur veniam fugiat aute consequat quis nisi in quis.', 'Magna ex non ullamco ipsum commodo minim cupidatat sit. Sint dolor enim amet cupidatat. Anim et ea officia ea officia veniam adipisicing tempor. Labore consequat in duis deserunt tempor aliqua. Eu incididunt id deserunt proident ullamco aliqua culpa officia anim deserunt fugiat amet voluptate qui. In id non sint sint aliqua commodo reprehenderit excepteur cillum Lorem minim.', 'Esse cillum deserunt fugiat deserunt irure ea esse deserunt quis exercitation velit do nisi reprehenderit.', 'Cliff', 'British Indian Ocean Territory', @Hash, @Salt),
		('Porter', 'male', '1967-04-09', 'Porter', '2020-04-05', '2020-06-23', 'Qui adipisicing enim mollit magna fugiat. Quis laborum sit adipisicing Lorem veniam magna. Aliqua ex occaecat id duis aute excepteur quis eu eiusmod. Cillum consectetur dolore officia consequat veniam nulla qui occaecat ullamco ipsum sit incididunt aute ullamco.', 'Officia id adipisicing duis culpa aute voluptate Lorem quis aliquip qui. Cupidatat aliquip amet reprehenderit excepteur amet et est dolore est. Veniam pariatur elit non ullamco labore quis do. Ad non cillum nisi non. Non cupidatat nisi fugiat officia tempor officia sunt qui duis.', 'Aliquip proident pariatur excepteur incididunt irure et.', 'Welda', 'Christmas Island', @Hash, @Salt),
		('Mayo', 'male', '1990-03-23', 'Mayo', '2020-03-14', '2020-05-17', 'Aliquip labore nisi veniam exercitation sit laborum nisi pariatur dolore tempor irure. Ad officia et eu cupidatat qui irure pariatur qui excepteur dolor ut eiusmod. Exercitation qui cillum elit elit officia elit culpa eu consequat cupidatat velit esse.', 'Duis tempor amet officia irure amet do ipsum est dolore culpa id Lorem exercitation labore. Cupidatat minim duis nulla occaecat excepteur anim laboris id culpa ullamco culpa. Ullamco mollit labore mollit esse labore eiusmod elit enim voluptate laborum irure amet eu in. Pariatur consectetur Lorem velit incididunt excepteur. Magna proident nulla ex laboris veniam tempor proident nisi elit. Ex tempor excepteur eiusmod et occaecat laboris ad ex veniam voluptate. Ipsum mollit voluptate nulla eiusmod nostrud sit anim anim qui est aute pariatur sint.', 'Duis consectetur proident labore velit minim irure proident incididunt officia duis.', 'Clarence', 'Burkina Faso', @Hash, @Salt),
		('Skinner', 'male', '1952-12-01', 'Skinner', '2019-01-28', '2020-06-07', 'Cupidatat dolor irure officia qui consequat ea laborum excepteur esse. Esse qui cupidatat minim laborum velit occaecat officia. Nulla consectetur nisi laborum in eu fugiat ipsum magna. Ipsum sunt consectetur reprehenderit ea consectetur fugiat anim enim nostrud. Ut fugiat cupidatat aliquip ipsum laborum adipisicing sint tempor. Eu deserunt aute Lorem duis exercitation aute aute commodo ut eu elit elit commodo officia.', 'Sunt est cillum nisi officia cupidatat sit ullamco. Labore aliquip pariatur amet velit labore cillum irure dolor. Anim ut cupidatat qui pariatur veniam eu. Eu est cillum non amet consectetur deserunt eiusmod ea sint nostrud quis ipsum cillum. Irure id et minim do nostrud consectetur quis ex duis nostrud dolor. Veniam enim sint proident officia sint enim eiusmod occaecat adipisicing do ad proident.', 'Pariatur qui ut commodo laboris officia.', 'Herald', 'Poland', @Hash, @Salt),
		('Davis', 'male', '1978-03-20', 'Davis', '2020-02-25', '2020-06-11', 'Voluptate sunt adipisicing ea nisi ex ullamco veniam dolor. Dolor do et exercitation in. Aute enim pariatur amet commodo. Deserunt consectetur quis culpa aliqua voluptate ipsum exercitation exercitation exercitation ea aliqua sunt.', 'Do do minim est incididunt minim qui aliqua nulla pariatur culpa pariatur culpa non. Aliquip esse quis ullamco sint voluptate. Eiusmod reprehenderit nostrud elit eu. Sit est incididunt elit excepteur eu non. Non tempor labore nisi consequat excepteur magna non velit. Nostrud labore ex nostrud magna adipisicing aute exercitation ad in incididunt pariatur anim. Officia dolor proident nulla laboris quis.', 'Labore consectetur labore ut nulla voluptate nulla quis labore tempor dolor laborum.', 'Lupton', 'Luxembourg', @Hash, @Salt),
		('sin foto', 'male', '1978-03-20', 'sin foto', '2020-02-25', '2020-06-11', 'sin foto', 'sin foto', 'sin foto', 'sin foto', 'sin foto', @Hash, @Salt)
;

SELECT * 
FROM Users;


--TRUNCATE TABLE DatingAppSqlS.dbo.Users;


