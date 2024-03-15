USE DatingAppSql21012024;
GO

DROP TABLE IF EXISTS [dbo].[Likes];


CREATE TABLE Likes
(
	SourceUserId INT NOT NULL,	-- el q da el like
	TargetUserId INT NOT NULL,	-- al q se le da el like
	
	CONSTRAINT PK_Likes_id PRIMARY KEY (SourceUserId, TargetUserId),
	CONSTRAINT FK_Likes_SourceUserId FOREIGN KEY (SourceUserId) REFERENCES AppUsers (id),
	CONSTRAINT FK_Likes_TargetUserId FOREIGN KEY (TargetUserId) REFERENCES AppUsers (id)
);

SELECT * FROM Likes;
SELECT * FROM AppUsers;

INSERT INTO [dbo].[Likes] (SourceUserId, TargetUserId)
VALUES	(2, 3),
		(3, 2),
		(4, 3)
;

SELECT * 
FROM Likes;


TRUNCATE TABLE [dbo].[Likes];