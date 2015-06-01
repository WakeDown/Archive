CREATE TABLE [dbo].[stock]
(
	[id] BIGINT NOT NULL PRIMARY KEY IDENTITY , 
    [id_stock_import] INT NOT NULL, 
    [id_rec] NVARCHAR(20) NULL, 
    [doc_type] NVARCHAR(150) NULL, 
    [doc_number] NVARCHAR(50) NULL, 
    [doc_date] NVARCHAR(20) NULL, 
    [contractor] NVARCHAR(250) NULL, 
    [manager] NVARCHAR(150) NULL, 
    [organization] NVARCHAR(150) NULL, 
    [is_processed] BIT NOT NULL DEFAULT 1, 
    [dattim1] DATETIME NOT NULL DEFAULT getdate(), 
    [date_process] DATETIME NULL
)

GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Дата обработки',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Stock',
    @level2type = N'COLUMN',
    @level2name = N'date_process'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Юр. лицо ЮНИТ',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Stock',
    @level2type = N'COLUMN',
    @level2name = N'organization'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'ID записи из источника (1С)',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Stock',
    @level2type = N'COLUMN',
    @level2name = N'id_rec'
GO


CREATE NONCLUSTERED INDEX [IX_Stock_id_stock_import] ON [dbo].[stock] ([id_stock_import])
