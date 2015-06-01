/*
Скрипт развертывания для Archive

Этот код был создан программным средством.
Изменения, внесенные в этот файл, могут привести к неверному выполнению кода и будут потеряны
в случае его повторного формирования.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "Archive"
:setvar DefaultFilePrefix "Archive"
:setvar DefaultDataPath "S:\SQL-DB\MSSQL10_50.MSSQLSERVER\MSSQL\Data\"
:setvar DefaultLogPath "T:\SQL-TL\MSSQL10_50.MSSQLSERVER\MSSQL\Data\"

GO
:on error exit
GO
/*
Проверьте режим SQLCMD и отключите выполнение скрипта, если режим SQLCMD не поддерживается.
Чтобы повторно включить скрипт после включения режима SQLCMD выполните следующую инструкцию:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'Для успешного выполнения этого скрипта должен быть включен режим SQLCMD.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'Выполняется создание [dbo].[DocCells]...';


GO
CREATE TABLE [dbo].[DocCells] (
    [Id] INT NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Выполняется создание [dbo].[documents]...';


GO
CREATE TABLE [dbo].[documents] (
    [id]              BIGINT           IDENTITY (1, 1) NOT NULL,
    [id_stock]        BIGINT           NOT NULL,
    [id_contractor]   INT              NOT NULL,
    [manager_guid]    UNIQUEIDENTIFIER NOT NULL,
    [id_doc_type]     SMALLINT         NOT NULL,
    [doc_date]        DATETIME         NOT NULL,
    [id_organization] SMALLINT         NOT NULL,
    [doc_number]      NVARCHAR (50)    NOT NULL,
    [id_doc_state]    SMALLINT         NOT NULL,
    [dattim1]         DATETIME         NOT NULL,
    [dattim2]         DATETIME         NOT NULL,
    [enabled]         BIT              NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
PRINT N'Выполняется создание [dbo].[documents].[IX_Documents_id_doc_state]...';


GO
CREATE NONCLUSTERED INDEX [IX_Documents_id_doc_state]
    ON [dbo].[documents]([id_doc_state] ASC);


GO
PRINT N'Выполняется создание [dbo].[documents].[IX_Documents_manager_guid]...';


GO
CREATE NONCLUSTERED INDEX [IX_Documents_manager_guid]
    ON [dbo].[documents]([manager_guid] ASC);


GO
PRINT N'Выполняется создание ограничение без названия для [dbo].[documents]...';


GO
ALTER TABLE [dbo].[documents]
    ADD DEFAULT getdate() FOR [dattim1];


GO
PRINT N'Выполняется создание ограничение без названия для [dbo].[documents]...';


GO
ALTER TABLE [dbo].[documents]
    ADD DEFAULT '3.3.3333' FOR [dattim2];


GO
PRINT N'Выполняется создание ограничение без названия для [dbo].[documents]...';


GO
ALTER TABLE [dbo].[documents]
    ADD DEFAULT 1 FOR [enabled];


GO
PRINT N'Выполняется создание [dbo].[Documents].[id_contractor].[MS_Description]...';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Контрагент', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'documents', @level2type = N'COLUMN', @level2name = N'id_contractor';


GO
PRINT N'Выполняется создание [dbo].[Documents].[doc_date].[MS_Description]...';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Дата создания/проведения (начала) документа', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'documents', @level2type = N'COLUMN', @level2name = N'doc_date';


GO
PRINT N'Выполняется создание [dbo].[Documents].[id_organization].[MS_Description]...';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Юр. лицо ЮНИТ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'documents', @level2type = N'COLUMN', @level2name = N'id_organization';


GO
PRINT N'Выполняется создание [dbo].[Documents].[doc_number].[MS_Description]...';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Номер документа', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'documents', @level2type = N'COLUMN', @level2name = N'doc_number';


GO
PRINT N'Выполняется создание [dbo].[Documents].[id_doc_state].[MS_Description]...';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Текущий статус документа', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'documents', @level2type = N'COLUMN', @level2name = N'id_doc_state';


GO
PRINT N'Обновление завершено.';


GO
