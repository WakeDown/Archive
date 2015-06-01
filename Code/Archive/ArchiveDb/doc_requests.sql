CREATE TABLE [dbo].[doc_requests]
(
	[id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [user_sid] VARCHAR(36) NOT NULL, 
    [id_document] BIGINT NOT NULL, 
    [id_req_state] SMALLINT NOT NULL , 
    [dattim1] DATETIME NOT NULL DEFAULT getdate(), 
    [dattim2] DATETIME NOT NULL DEFAULT '3.3.3333', 
    [enabled] BIT NOT NULL DEFAULT 1
)

GO

CREATE INDEX [IX_DocRequests_id_document] ON [dbo].[doc_requests] ([id_document])

GO

CREATE INDEX [IX_DocRequests_user_guid] ON [dbo].[doc_requests] ([user_sid])
