CREATE TABLE [dbo].[doc_types]
(
	[id] SMALLINT NOT NULL PRIMARY KEY, 
    [name] NVARCHAR(150) NOT NULL, 
    [sys_name] NVARCHAR(20) NOT NULL, 
    [dattim1] DATETIME NOT NULL DEFAULT getdate(), 
    [enabled] BIT NOT NULL DEFAULT 1
)
