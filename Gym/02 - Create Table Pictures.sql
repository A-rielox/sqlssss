USE Gym;
GO

DROP TABLE IF EXISTS dbo.Pictures;
GO

CREATE TABLE Pictures
(
	id INT IDENTITY(1,1),
	url VARCHAR(500),
	isMain BIT DEFAULT 0, -- 0 false, 1 true
	publicId VARCHAR(500),
	appUserId INT

	CONSTRAINT PK_Pictures_id PRIMARY KEY (id),
	CONSTRAINT FK_Pictures_appUserId FOREIGN KEY (appUserId) REFERENCES AppUsers (id)
);

SELECT * 
FROM Pictures ORDER BY appUserId;


INSERT INTO [dbo].[Pictures] (url, isMain, appUserId)
VALUES	('https://randomuser.me/api/portraits/women/54.jpg', 0, 2),
		('https://randomuser.me/api/portraits/women/70.jpg', 1, 2), -- 2da p' lisa, main photo
		('https://randomuser.me/api/portraits/women/21.jpg', 0, 2), -- 3da p' lisa
		('https://randomuser.me/api/portraits/women/50.jpg', 1, 3),
		('https://randomuser.me/api/portraits/women/14.jpg', 1, 4),
		('https://randomuser.me/api/portraits/women/11.jpg', 1, 5),
		('https://randomuser.me/api/portraits/women/84.jpg', 1, 6),
		('https://randomuser.me/api/portraits/men/90.jpg', 1, 7),
		('https://randomuser.me/api/portraits/men/87.jpg', 1, 8),
		('https://randomuser.me/api/portraits/men/57.jpg', 1, 9),
		('https://randomuser.me/api/portraits/men/11.jpg', 1, 10),
		('https://randomuser.me/api/portraits/men/93.jpg', 1, 11),

		('https://randomuser.me/api/portraits/men/77.jpg', 1, 12),
		('https://randomuser.me/api/portraits/men/42.jpg', 1, 13),
		('https://randomuser.me/api/portraits/men/37jpg', 1, 14)
;

SELECT * 
FROM Pictures ORDER BY appUserId;


--TRUNCATE TABLE Gym.dbo.Pictures;


