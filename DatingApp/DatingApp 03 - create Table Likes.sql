USE DatingSql;
GO

DROP TABLE IF EXISTS DatingSql.dbo.Likes;


CREATE TABLE Likes
(
	SourceUserId INT NOT NULL,	-- el q da el like
	TargetUserId INT NOT NULL,	-- al q se le da el like
	
	CONSTRAINT PK_Likes_id PRIMARY KEY (SourceUserId, TargetUserId),
	CONSTRAINT FK_Likes_SourceUserId FOREIGN KEY (SourceUserId) REFERENCES Users (id),
	CONSTRAINT FK_Likes_TargetUserId FOREIGN KEY (TargetUserId) REFERENCES Users (id)
);

SELECT * FROM Likes;
SELECT * FROM Users;

INSERT INTO [dbo].[Likes] (SourceUserId, TargetUserId)
VALUES	(1, 2),
		(2, 1),
		(3, 2)
;

SELECT * 
FROM Likes;


TRUNCATE TABLE DatingSql.dbo.Likes;