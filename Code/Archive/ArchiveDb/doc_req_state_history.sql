CREATE TABLE [dbo].[doc_req_state_history]
(
	[id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [id_request] INT NOT NULL, 
    [id_req_state] SMALLINT NOT NULL, 
    [dattim1] DATETIME NOT NULL DEFAULT getdate(), 
    [creator_sid] VARCHAR(36) NOT NULL 
)

GO

CREATE INDEX [IX_DocReqStateHistory_id_request] ON [dbo].[doc_req_state_history] ([id_request])
