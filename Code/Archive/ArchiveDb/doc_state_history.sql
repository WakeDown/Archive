CREATE TABLE [dbo].[doc_state_history]
(
	[id] BIGINT NOT NULL PRIMARY KEY IDENTITY , 
    [id_document] BIGINT NOT NULL, 
    [id_doc_state] SMALLINT NOT NULL, 
    [dattim1] DATETIME NOT NULL DEFAULT getdate(), 
    [creator_sid] VARCHAR(36) NOT NULL 
)

GO

CREATE INDEX [IX_DocStateHistory_id_document] ON [dbo].[doc_state_history] ([id_document])
