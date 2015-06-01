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
PRINT N'Выполняется создание [dbo].[doc_req_state_history]...';


GO
CREATE TABLE [dbo].[doc_req_state_history] (
    [id]           INT              IDENTITY (1, 1) NOT NULL,
    [id_request]   INT              NOT NULL,
    [id_req_state] SMALLINT         NOT NULL,
    [dattim1]      DATETIME         NOT NULL,
    [creator_guid] UNIQUEIDENTIFIER NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
PRINT N'Выполняется создание [dbo].[doc_req_state_history].[IX_DocReqStateHistory_id_request]...';


GO
CREATE NONCLUSTERED INDEX [IX_DocReqStateHistory_id_request]
    ON [dbo].[doc_req_state_history]([id_request] ASC);


GO
PRINT N'Выполняется создание [dbo].[doc_requests]...';


GO
CREATE TABLE [dbo].[doc_requests] (
    [id]           INT              IDENTITY (1, 1) NOT NULL,
    [user_guid]    UNIQUEIDENTIFIER NOT NULL,
    [id_document]  BIGINT           NOT NULL,
    [id_req_state] SMALLINT         NOT NULL,
    [dattim1]      DATETIME         NOT NULL,
    [dattim2]      DATETIME         NOT NULL,
    [enabled]      BIT              NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
PRINT N'Выполняется создание [dbo].[doc_requests].[IX_DocRequests_id_document]...';


GO
CREATE NONCLUSTERED INDEX [IX_DocRequests_id_document]
    ON [dbo].[doc_requests]([id_document] ASC);


GO
PRINT N'Выполняется создание [dbo].[doc_requests].[IX_DocRequests_user_guid]...';


GO
CREATE NONCLUSTERED INDEX [IX_DocRequests_user_guid]
    ON [dbo].[doc_requests]([user_guid] ASC);


GO
PRINT N'Выполняется создание [dbo].[doc_scans]...';


GO
CREATE TABLE [dbo].[doc_scans] (
    [id]           BIGINT           IDENTITY (1, 1) NOT NULL,
    [file_name]    NVARCHAR (150)   NOT NULL,
    [path]         NVARCHAR (500)   NOT NULL,
    [id_document]  BIGINT           NOT NULL,
    [creator_guid] UNIQUEIDENTIFIER NOT NULL,
    [dattim1]      DATETIME         NOT NULL,
    [dattim2]      DATETIME         NOT NULL,
    [enabled]      BIT              NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
PRINT N'Выполняется создание [dbo].[doc_scans].[IX_DocScans_id_document]...';


GO
CREATE NONCLUSTERED INDEX [IX_DocScans_id_document]
    ON [dbo].[doc_scans]([id_document] ASC);


GO
PRINT N'Выполняется создание [dbo].[doc_state_history]...';


GO
CREATE TABLE [dbo].[doc_state_history] (
    [id]           BIGINT           IDENTITY (1, 1) NOT NULL,
    [id_document]  BIGINT           NOT NULL,
    [id_doc_state] SMALLINT         NOT NULL,
    [dattim1]      DATETIME         NOT NULL,
    [creator_guid] UNIQUEIDENTIFIER NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
PRINT N'Выполняется создание [dbo].[doc_state_history].[IX_DocStateHistory_id_document]...';


GO
CREATE NONCLUSTERED INDEX [IX_DocStateHistory_id_document]
    ON [dbo].[doc_state_history]([id_document] ASC);


GO
PRINT N'Выполняется создание ограничение без названия для [dbo].[doc_req_state_history]...';


GO
ALTER TABLE [dbo].[doc_req_state_history]
    ADD DEFAULT getdate() FOR [dattim1];


GO
PRINT N'Выполняется создание ограничение без названия для [dbo].[doc_requests]...';


GO
ALTER TABLE [dbo].[doc_requests]
    ADD DEFAULT getdate() FOR [dattim1];


GO
PRINT N'Выполняется создание ограничение без названия для [dbo].[doc_requests]...';


GO
ALTER TABLE [dbo].[doc_requests]
    ADD DEFAULT '3.3.3333' FOR [dattim2];


GO
PRINT N'Выполняется создание ограничение без названия для [dbo].[doc_requests]...';


GO
ALTER TABLE [dbo].[doc_requests]
    ADD DEFAULT 1 FOR [enabled];


GO
PRINT N'Выполняется создание ограничение без названия для [dbo].[doc_scans]...';


GO
ALTER TABLE [dbo].[doc_scans]
    ADD DEFAULT getdate() FOR [dattim1];


GO
PRINT N'Выполняется создание ограничение без названия для [dbo].[doc_scans]...';


GO
ALTER TABLE [dbo].[doc_scans]
    ADD DEFAULT '3.3.3333' FOR [dattim2];


GO
PRINT N'Выполняется создание ограничение без названия для [dbo].[doc_scans]...';


GO
ALTER TABLE [dbo].[doc_scans]
    ADD DEFAULT 1 FOR [enabled];


GO
PRINT N'Выполняется создание ограничение без названия для [dbo].[doc_state_history]...';


GO
ALTER TABLE [dbo].[doc_state_history]
    ADD DEFAULT getdate() FOR [dattim1];


GO
PRINT N'Обновление завершено.';


GO
