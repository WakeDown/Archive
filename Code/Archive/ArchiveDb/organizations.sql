CREATE TABLE [dbo].[organizations]
(
	[id] SMALLINT NOT NULL PRIMARY KEY, 
    [name] NVARCHAR(50) NOT NULL, 
    [sys_name] NVARCHAR(20) NOT NULL, 
    [dattim1] DATETIME NOT NULL DEFAULT getdate(), 
    [enabled] BIT NOT NULL DEFAULT 1
)
