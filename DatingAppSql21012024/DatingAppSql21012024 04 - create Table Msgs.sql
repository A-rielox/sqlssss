USE DatingAppSql21012024;
GO

DROP TABLE IF EXISTS dbo.Msgs;


CREATE TABLE Msgs
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
	CONSTRAINT FK_Messages_SenderId FOREIGN KEY (SenderId) REFERENCES [AppUsers] (id),
	CONSTRAINT FK_Messages_RecipientId FOREIGN KEY (RecipientId) REFERENCES [AppUsers] (id)
);

SELECT * FROM Msgs;
SELECT * FROM [AppUsers];

INSERT INTO [dbo].[Msgs] (SenderId, SenderUsername, RecipientId, RecipientUsername, Content)
VALUES	(2, 'Lisa', 7, 'Todd', 'Mensaje 1 Lisa a Todd'),
		(7, 'Todd', 2, 'Lisa',  'Mensaje 2 Todd a  Lisa'),
		(2,	'Lisa', 7,	'Todd',	'Mensaje desde XD'),
		(2,	'Lisa',	7,	'Todd', 'Test message from Lisa to Todd'),
		(7,	'Todd',	2,	'Lisa', 'Test message from Todd to Lisa'),
		(2,	'Lisa',	7,	'Todd', 'Test message from Lisa to Todd'),
		(3,	'Karen', 8, 'Porter', 'Mensaje Karen a Porter'),
		(8,	'Porter', 3, 'Karen', 'Mensaje Porter a Karen'),
		(7,	'Todd',	3, 'Karen', 'Mensaje Todd a Karen')
;

SELECT * FROM Msgs;

--TRUNCATE TABLE DatingSql.dbo.Msgs;





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