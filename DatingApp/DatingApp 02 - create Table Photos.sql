USE DatingAppSqlS;
GO

DROP TABLE IF EXISTS DatingAppSqlS.dbo.Photos;
GO

CREATE TABLE Photos
(
	id INT IDENTITY(1,1),
	url VARCHAR(500),
	isMain BIT DEFAULT 0, -- 0 false, 1 true
	publicId VARCHAR(500),
	appUserId INT

	CONSTRAINT PK_Photos_id PRIMARY KEY (id),
	CONSTRAINT FK_Photos_appUserId FOREIGN KEY (appUserId) REFERENCES Users (id)
);

SELECT * 
FROM Photos;


INSERT INTO [dbo].[Photos] (url, isMain, appUserId)
VALUES	('https://randomuser.me/api/portraits/women/54.jpg', 1, 1),
		('https://randomuser.me/api/portraits/women/50.jpg', 1, 2),
		('https://randomuser.me/api/portraits/women/14.jpg', 1, 3),
		('https://randomuser.me/api/portraits/women/11.jpg', 1, 4),
		('https://randomuser.me/api/portraits/women/84.jpg', 1, 5),
		('https://randomuser.me/api/portraits/men/90.jpg', 1, 6),
		('https://randomuser.me/api/portraits/men/87.jpg', 1, 7),
		('https://randomuser.me/api/portraits/men/57.jpg', 1, 8),
		('https://randomuser.me/api/portraits/men/11.jpg', 1, 9),
		('https://randomuser.me/api/portraits/men/93.jpg', 1, 10)
;

SELECT * 
FROM Photos;


TRUNCATE TABLE DatingAppSqlS.dbo.Photos;


