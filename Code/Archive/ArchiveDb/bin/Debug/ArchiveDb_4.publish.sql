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
PRINT N'Операция рефакторинга Rename с помощью ключа 305cbd51-8bc2-409a-ba35-f945d57810f8 пропущена, элемент [dbo].[doc_places].[Id] (SqlSimpleColumn) не будет переименован в id';


GO
PRINT N'Указанная ниже операция создана из файла журнала рефакторинга c496c28d-8651-49f6-8331-46687327393b';

PRINT N'Переименование [dbo].[documents].[manager_guid] в manager_sid';


GO
EXECUTE sp_rename @objname = N'[dbo].[documents].[manager_guid]', @newname = N'manager_sid', @objtype = N'COLUMN';


GO
PRINT N'Указанная ниже операция создана из файла журнала рефакторинга 148b8091-9ab7-4c98-945a-9600b11fe176';

PRINT N'Переименование [dbo].[doc_state_history].[creator_guid] в creator_sid';


GO
EXECUTE sp_rename @objname = N'[dbo].[doc_state_history].[creator_guid]', @newname = N'creator_sid', @objtype = N'COLUMN';


GO
PRINT N'Указанная ниже операция создана из файла журнала рефакторинга 82986525-216d-4479-a677-bef7fc2763a1';

PRINT N'Переименование [dbo].[doc_scans].[creator_guid] в creator_sid';


GO
EXECUTE sp_rename @objname = N'[dbo].[doc_scans].[creator_guid]', @newname = N'creator_sid', @objtype = N'COLUMN';


GO
PRINT N'Указанная ниже операция создана из файла журнала рефакторинга 409c07ef-d31a-436c-b1bd-1f3d2db24bee';

PRINT N'Переименование [dbo].[doc_requests].[user_guid] в user_sid';


GO
EXECUTE sp_rename @objname = N'[dbo].[doc_requests].[user_guid]', @newname = N'user_sid', @objtype = N'COLUMN';


GO
PRINT N'Указанная ниже операция создана из файла журнала рефакторинга 30082632-5b6f-483f-ba18-e9339598f973';

PRINT N'Переименование [dbo].[doc_req_state_history].[creator_guid] в creator_sid';


GO
EXECUTE sp_rename @objname = N'[dbo].[doc_req_state_history].[creator_guid]', @newname = N'creator_sid', @objtype = N'COLUMN';


GO
PRINT N'Операция рефакторинга Rename с помощью ключа cad0660a-ff26-4f44-ba07-44c74d380e5b пропущена, элемент [dbo].[organizations].[Id] (SqlSimpleColumn) не будет переименован в id';


GO
PRINT N'Операция рефакторинга Rename с помощью ключа d9efc383-0f81-49ae-8fa0-ae9cb98c5cfe пропущена, элемент [dbo].[doc_types].[Id] (SqlSimpleColumn) не будет переименован в id';


GO
PRINT N'Выполняется удаление [dbo].[doc_requests].[IX_DocRequests_user_guid]...';


GO
DROP INDEX [IX_DocRequests_user_guid]
    ON [dbo].[doc_requests];


GO
PRINT N'Выполняется удаление [dbo].[documents].[IX_Documents_manager_guid]...';


GO
DROP INDEX [IX_Documents_manager_guid]
    ON [dbo].[documents];


GO
PRINT N'Выполняется удаление ограничение без названия для [dbo].[doc_states]...';


GO
ALTER TABLE [dbo].[doc_states] DROP CONSTRAINT [DF__doc_state__datti__5165187F];


GO
PRINT N'Выполняется удаление ограничение без названия для [dbo].[doc_states]...';


GO
ALTER TABLE [dbo].[doc_states] DROP CONSTRAINT [DF__doc_state__enabl__52593CB8];


GO
PRINT N'Выполняется удаление ограничение без названия для [dbo].[request_states]...';


GO
ALTER TABLE [dbo].[request_states] DROP CONSTRAINT [DF__request_s__datti__534D60F1];


GO
PRINT N'Выполняется удаление ограничение без названия для [dbo].[request_states]...';


GO
ALTER TABLE [dbo].[request_states] DROP CONSTRAINT [DF__request_s__enabl__5441852A];


GO
PRINT N'Выполняется изменение [dbo].[doc_req_state_history]...';


GO
ALTER TABLE [dbo].[doc_req_state_history] ALTER COLUMN [creator_sid] VARCHAR (36) NOT NULL;


GO
PRINT N'Выполняется изменение [dbo].[doc_requests]...';


GO
ALTER TABLE [dbo].[doc_requests] ALTER COLUMN [user_sid] VARCHAR (36) NOT NULL;


GO
PRINT N'Выполняется создание [dbo].[doc_requests].[IX_DocRequests_user_guid]...';


GO
CREATE NONCLUSTERED INDEX [IX_DocRequests_user_guid]
    ON [dbo].[doc_requests]([user_sid] ASC);


GO
PRINT N'Выполняется изменение [dbo].[doc_scans]...';


GO
ALTER TABLE [dbo].[doc_scans] ALTER COLUMN [creator_sid] VARCHAR (36) NOT NULL;


GO
PRINT N'Выполняется изменение [dbo].[doc_state_history]...';


GO
ALTER TABLE [dbo].[doc_state_history] ALTER COLUMN [creator_sid] VARCHAR (36) NOT NULL;


GO
PRINT N'Выполняется запуск перестройки таблицы [dbo].[doc_states]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_doc_states] (
    [id]       SMALLINT      NOT NULL,
    [name]     NVARCHAR (50) NOT NULL,
    [dattim1]  DATETIME      DEFAULT getdate() NOT NULL,
    [enabled]  BIT           DEFAULT 1 NOT NULL,
    [sys_name] NVARCHAR (10) NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[doc_states])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_doc_states] ([id], [name], [dattim1], [enabled], [sys_name])
        SELECT   [id],
                 [name],
                 [dattim1],
                 [enabled],
                 [sys_name]
        FROM     [dbo].[doc_states]
        ORDER BY [id] ASC;
    END

DROP TABLE [dbo].[doc_states];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_doc_states]', N'doc_states';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Выполняется изменение [dbo].[documents]...';


GO
ALTER TABLE [dbo].[documents] ALTER COLUMN [manager_sid] VARCHAR (36) NOT NULL;


GO
PRINT N'Выполняется создание [dbo].[documents].[IX_Documents_manager_guid]...';


GO
CREATE NONCLUSTERED INDEX [IX_Documents_manager_guid]
    ON [dbo].[documents]([manager_sid] ASC);


GO
PRINT N'Выполняется запуск перестройки таблицы [dbo].[request_states]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_request_states] (
    [id]       SMALLINT      NOT NULL,
    [name]     NVARCHAR (50) NOT NULL,
    [dattim1]  DATETIME      DEFAULT getdate() NOT NULL,
    [enabled]  BIT           DEFAULT 1 NOT NULL,
    [sys_name] NVARCHAR (10) NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[request_states])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_request_states] ([id], [name], [dattim1], [enabled], [sys_name])
        SELECT   [id],
                 [name],
                 [dattim1],
                 [enabled],
                 [sys_name]
        FROM     [dbo].[request_states]
        ORDER BY [id] ASC;
    END

DROP TABLE [dbo].[request_states];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_request_states]', N'request_states';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Выполняется создание [dbo].[doc_places]...';


GO
CREATE TABLE [dbo].[doc_places] (
    [id] INT NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
PRINT N'Выполняется создание [dbo].[doc_types]...';


GO
CREATE TABLE [dbo].[doc_types] (
    [id]       SMALLINT       NOT NULL,
    [name]     NVARCHAR (150) NOT NULL,
    [sys_name] NVARCHAR (20)  NOT NULL,
    [dattim1]  DATETIME       NOT NULL,
    [enabled]  BIT            NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
PRINT N'Выполняется создание [dbo].[organizations]...';


GO
CREATE TABLE [dbo].[organizations] (
    [id]       SMALLINT      NOT NULL,
    [name]     NVARCHAR (50) NOT NULL,
    [sys_name] NVARCHAR (20) NOT NULL,
    [dattim1]  DATETIME      NOT NULL,
    [enabled]  BIT           NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
PRINT N'Выполняется создание ограничение без названия для [dbo].[doc_types]...';


GO
ALTER TABLE [dbo].[doc_types]
    ADD DEFAULT getdate() FOR [dattim1];


GO
PRINT N'Выполняется создание ограничение без названия для [dbo].[doc_types]...';


GO
ALTER TABLE [dbo].[doc_types]
    ADD DEFAULT 1 FOR [enabled];


GO
PRINT N'Выполняется создание ограничение без названия для [dbo].[organizations]...';


GO
ALTER TABLE [dbo].[organizations]
    ADD DEFAULT getdate() FOR [dattim1];


GO
PRINT N'Выполняется создание ограничение без названия для [dbo].[organizations]...';


GO
ALTER TABLE [dbo].[organizations]
    ADD DEFAULT 1 FOR [enabled];


GO
-- Выполняется этап рефакторинга для обновления развернутых журналов транзакций на целевом сервере
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '305cbd51-8bc2-409a-ba35-f945d57810f8')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('305cbd51-8bc2-409a-ba35-f945d57810f8')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'c496c28d-8651-49f6-8331-46687327393b')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('c496c28d-8651-49f6-8331-46687327393b')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '148b8091-9ab7-4c98-945a-9600b11fe176')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('148b8091-9ab7-4c98-945a-9600b11fe176')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '82986525-216d-4479-a677-bef7fc2763a1')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('82986525-216d-4479-a677-bef7fc2763a1')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '409c07ef-d31a-436c-b1bd-1f3d2db24bee')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('409c07ef-d31a-436c-b1bd-1f3d2db24bee')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '30082632-5b6f-483f-ba18-e9339598f973')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('30082632-5b6f-483f-ba18-e9339598f973')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'cad0660a-ff26-4f44-ba07-44c74d380e5b')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('cad0660a-ff26-4f44-ba07-44c74d380e5b')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'd9efc383-0f81-49ae-8fa0-ae9cb98c5cfe')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('d9efc383-0f81-49ae-8fa0-ae9cb98c5cfe')

GO

GO
/*
Шаблон скрипта после развертывания							
--------------------------------------------------------------------------------------
 В данном файле содержатся инструкции SQL, которые будут добавлены в скрипт построения.		
 Используйте синтаксис SQLCMD для включения файла в скрипт после развертывания.			
 Пример:      :r .\myfile.sql								
 Используйте синтаксис SQLCMD для создания ссылки на переменную в скрипте после развертывания.		
 Пример:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
DELETE FROM doc_types

INSERT INTO doc_types (id, name, sys_name)
VALUES (1, 'Договор', 'CTRT')

INSERT INTO doc_types (id, name, sys_name)
VALUES (2, 'Приложение к договору', 'CTRTADD')

INSERT INTO doc_types (id, name, sys_name)
VALUES (3, 'Спецификация', 'SPEC')

INSERT INTO doc_types (id, name, sys_name)
VALUES (4, 'Акт выполненных работ', 'AKT')

INSERT INTO doc_types (id, name, sys_name)
VALUES (5, 'Товарная накладная', 'NAKL')
GO

GO
PRINT N'Обновление завершено.';


GO
