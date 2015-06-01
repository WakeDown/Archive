CREATE TABLE [dbo].[doc_scans]
(
	[id] BIGINT NOT NULL PRIMARY KEY IDENTITY, 
    [file_name] NVARCHAR(150) NOT NULL, 
    [path] NVARCHAR(500) NOT NULL, 
    [id_document] BIGINT NOT NULL, 
    [creator_sid] VARCHAR(36) NOT NULL, 
    [dattim1] DATETIME NOT NULL DEFAULT getdate(), 
    [dattim2] DATETIME NOT NULL DEFAULT '3.3.3333', 
    [enabled] BIT NOT NULL DEFAULT 1
)

GO

CREATE INDEX [IX_DocScans_id_document] ON [dbo].[doc_scans] ([id_document])
