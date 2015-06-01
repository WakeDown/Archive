CREATE TABLE [dbo].[documents]
(
	[id] BIGINT NOT NULL PRIMARY KEY IDENTITY , 
    [id_stock] BIGINT NOT NULL, 
    [id_contractor] INT NOT NULL, 
    [manager_sid] VARCHAR(36) NOT NULL, 
    [id_doc_type] SMALLINT NOT NULL, 
    [doc_date] DATETIME NOT NULL, 
    [id_organization] SMALLINT NOT NULL, 
    [doc_number] NVARCHAR(50) NOT NULL, 
    [id_doc_state] SMALLINT NOT NULL, 
    [dattim1] DATETIME NOT NULL DEFAULT getdate(), 
    [dattim2] DATETIME NOT NULL DEFAULT '3.3.3333', 
    [enabled] BIT NOT NULL DEFAULT 1 
)

GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Юр. лицо ЮНИТ',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Documents',
    @level2type = N'COLUMN',
    @level2name = N'id_organization'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Контрагент',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Documents',
    @level2type = N'COLUMN',
    @level2name = N'id_contractor'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Номер документа',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Documents',
    @level2type = N'COLUMN',
    @level2name = N'doc_number'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Дата создания/проведения (начала) документа',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Documents',
    @level2type = N'COLUMN',
    @level2name = N'doc_date'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Текущий статус документа',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Documents',
    @level2type = N'COLUMN',
    @level2name = N'id_doc_state'
GO

CREATE INDEX [IX_Documents_id_doc_state] ON [dbo].[documents] ([id_doc_state])

GO

CREATE INDEX [IX_Documents_manager_guid] ON [dbo].[documents] ([manager_sid])
