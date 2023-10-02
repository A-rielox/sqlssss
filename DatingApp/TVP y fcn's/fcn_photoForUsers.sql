USE TestSql;
GO

DROP FUNCTION IF EXISTS dbo.fcn_photoForUsers;
GO

CREATE FUNCTION dbo.fcn_photoForUsers 
(
	@usersTable dbo.UserType READONLY,
	@photosTable dbo.PhotoType READONLY
)
RETURNS 
@usersWithMainPhoto TABLE 
(
	id INT,
	userName VARCHAR(50),
	PhotoUrl VARCHAR(500),
	dateOfBirth DATETIME,
	knownAs VARCHAR(50),
    created DATETIME,
    lastActive DATETIME,
    gender VARCHAR(50),
    introduction VARCHAR(2500),
    lookingFor VARCHAR(2500),
    interests VARCHAR(2500),
    city VARCHAR(200),
    country VARCHAR(200)
)
AS
BEGIN

	DECLARE @usersWithNoPhotos AS TABLE (userId INT);
	
	INSERT INTO @usersWithMainPhoto (id, userName, PhotoUrl, dateOfBirth, knownAs, created, lastActive, gender, introduction, lookingFor, interests, city, country)
	SELECT	u.id,
			userName,
			p.url,
			dateOfBirth,
			knownAs,
			created,
			lastActive,
			gender,
			introduction,
			lookingFor,
			interests,
			city,
			country
	FROM Users u
	left join Photos p on u.id = p.appUserId
	where p.isMain = 1

	-- id of users with no photos
	INSERT INTO @usersWithNoPhotos
	select u.id
	from Users u
	left join Photos p on u.id = p.appUserId
	GROUP BY u.userName, u.id -- quitar u.userName
	HAVING COUNT( p.url ) = 0

	-- los q no tienen foto
	INSERT INTO @usersWithMainPhoto (id, userName, PhotoUrl, dateOfBirth, knownAs, created, lastActive, gender, introduction, lookingFor, interests, city, country)
	SELECT	u.id,
			userName,
			null,
			dateOfBirth,
			knownAs,
			created,
			lastActive,
			gender,
			introduction,
			lookingFor,
			interests,
			city,
			country
	FROM Users u
	left join Photos p on u.id = p.appUserId
	where u.id in (
		select userId from @usersWithNoPhotos
	)

	RETURN 
END
GO



-- -----------------


--select p.isMain, *
--from Users u
--left join Photos p on u.id = p.appUserId
--where p.isMain = 1


select p.isMain, *
from Users u
left join Photos p on u.id = p.appUserId
where p.isMain = 1


select u.userName, u.id, COUNT( p.url ) as num_of_photos
from Users u
left join Photos p on u.id = p.appUserId
GROUP BY u.userName, u.id -- quitar u.userName



select u.userName, u.id, COUNT( p.url ) as num_of_photos
from Users u
left join Photos p on u.id = p.appUserId
GROUP BY u.userName, u.id -- quitar u.userName
HAVING COUNT( p.url ) = 0




