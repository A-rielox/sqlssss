USE DatingSql;
GO

DROP TABLE IF EXISTS DatingSql.dbo.Messages;


CREATE TABLE Messages
(
	id INT IDENTITY(1,1),

    SenderId INT NOT NULL,
    SenderUsername VARCHAR(50), -- nullable

    RecipientId INT NOT NULL,
    RecipientUsername VARCHAR(50), -- nullable

    Content VARCHAR(2500), -- nullable
    DateRead DATETIME, -- nullable
    MessageSent DATETIME DEFAULT GETDATE(),
    SenderDeleted BIT DEFAULT 0, -- 0 false, 1 true
    RecipientDeleted BIT DEFAULT 0, -- 0 false, 1 true
	
	CONSTRAINT PK_Messages_id PRIMARY KEY (id),
	CONSTRAINT FK_Messages_SenderId FOREIGN KEY (SenderId) REFERENCES Users (id),
	CONSTRAINT FK_Messages_RecipientId FOREIGN KEY (RecipientId) REFERENCES Users (id)
);

SELECT * FROM Messages;
SELECT * FROM Users;

INSERT INTO [dbo].[Messages] (SenderId, SenderUsername, RecipientId, RecipientUsername, Content)
VALUES	(1, 'Lisa', 6, 'Todd', 'Mensaje 1 Lisa a Todd'),
		(6, 'Todd', 1, 'Lisa',  'Mensaje 2 Todd a  Lisa')
;

SELECT * FROM Messages;

--TRUNCATE TABLE DatingSql.dbo.Messages;





/*
	public int Id { get; set; }
    /////////////////////
    public int SenderId { get; set; }
    public string SenderUsername { get; set; } // nullable
    //public AppUser Sender { get; set; }
    /////////////////////
    public int RecipientId { get; set; }
    public string RecipientUsername { get; set; } // nullable
    //public AppUser Recipient { get; set; }
    /////////////////////
    public string Content { get; set; } // nullable
    public DateTime? DateRead { get; set; } // nullable
    public DateTime MessageSent { get; set; } = DateTime.UtcNow;
    public bool SenderDeleted { get; set; }
    public bool RecipientDeleted { get; set; }
*/