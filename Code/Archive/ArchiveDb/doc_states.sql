CREATE TABLE [dbo].[doc_states]
(
	[id] SMALLINT NOT NULL PRIMARY KEY, 
    [name] NVARCHAR(50) NOT NULL, 
    [dattim1] DATETIME NOT NULL DEFAULT getdate(), 
    [enabled] BIT NOT NULL DEFAULT 1, 
    [sys_name] NVARCHAR(10) NOT NULL 
)
