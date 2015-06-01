CREATE TABLE [dbo].[stock_imports]
(
	[id] INT NOT NULL PRIMARY KEY IDENTITY , 
    [date_load] DATETIME NOT NULL DEFAULT getdate(), 
    [descr] NVARCHAR(500) NULL
)
