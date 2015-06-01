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
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET PAGE_VERIFY NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'Операция рефакторинга Rename с помощью ключа 19b745c9-9a55-49be-8329-8f006c4577ec пропущена, элемент [dbo].[StockImports].[FileInfo] (SqlSimpleColumn) не будет переименован в Descr';


GO
PRINT N'Операция рефакторинга Rename с помощью ключа ca379c67-71c8-4948-938f-98780ec1c751 пропущена, элемент [dbo].[Stock].[Dattim2] (SqlSimpleColumn) не будет переименован в DateProcess';


GO
PRINT N'Выполняется создание [dbo].[DocCells]...';


GO
CREATE TABLE [dbo].[DocCells] (
    [Id] INT NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Выполняется создание [dbo].[DocReqStateHistory]...';


GO
CREATE TABLE [dbo].[DocReqStateHistory] (
    [Id] INT NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Выполняется создание [dbo].[DocRequests]...';


GO
CREATE TABLE [dbo].[DocRequests] (
    [Id] INT NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Выполняется создание [dbo].[DocScans]...';


GO
CREATE TABLE [dbo].[DocScans] (
    [Id] INT NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Выполняется создание [dbo].[DocStateHistory]...';


GO
CREATE TABLE [dbo].[DocStateHistory] (
    [Id] INT NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Выполняется создание [dbo].[Documents]...';


GO
CREATE TABLE [dbo].[Documents] (
    [Id] INT NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Выполняется создание [dbo].[Stock]...';


GO
CREATE TABLE [dbo].[Stock] (
    [Id]            INT            IDENTITY (1, 1) NOT NULL,
    [IdStockImport] INT            NOT NULL,
    [IdRec]         NVARCHAR (20)  NULL,
    [DocType]       NVARCHAR (150) NULL,
    [DocNumber]     NVARCHAR (50)  NULL,
    [DocDate]       NVARCHAR (20)  NULL,
    [Contractor]    NVARCHAR (250) NULL,
    [Manager]       NVARCHAR (150) NULL,
    [Organization]  NVARCHAR (150) NULL,
    [Processed]     BIT            NOT NULL,
    [DateCreate]    DATETIME       NOT NULL,
    [DateProcess]   DATETIME       NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Выполняется создание [dbo].[StockImports]...';


GO
CREATE TABLE [dbo].[StockImports] (
    [Id]       INT            IDENTITY (1, 1) NOT NULL,
    [DateLoad] DATETIME       NULL,
    [Descr]    NVARCHAR (MAX) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Выполняется создание ограничение без названия для [dbo].[Stock]...';


GO
ALTER TABLE [dbo].[Stock]
    ADD DEFAULT 1 FOR [Processed];


GO
PRINT N'Выполняется создание ограничение без названия для [dbo].[Stock]...';


GO
ALTER TABLE [dbo].[Stock]
    ADD DEFAULT getdate() FOR [DateCreate];


GO
-- Выполняется этап рефакторинга для обновления развернутых журналов транзакций на целевом сервере

IF OBJECT_ID(N'dbo.__RefactorLog') IS NULL
BEGIN
    CREATE TABLE [dbo].[__RefactorLog] (OperationKey UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)
    EXEC sp_addextendedproperty N'microsoft_database_tools_support', N'refactoring log', N'schema', N'dbo', N'table', N'__RefactorLog'
END
GO
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '19b745c9-9a55-49be-8329-8f006c4577ec')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('19b745c9-9a55-49be-8329-8f006c4577ec')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'a2c50e22-ba25-4cfc-a81d-86364f5150a8')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('a2c50e22-ba25-4cfc-a81d-86364f5150a8')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '6bd3cd5a-c696-4257-a2bd-7bcc2ccf8699')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('6bd3cd5a-c696-4257-a2bd-7bcc2ccf8699')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'ca379c67-71c8-4948-938f-98780ec1c751')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('ca379c67-71c8-4948-938f-98780ec1c751')

GO

GO
PRINT N'Обновление завершено.';


GO
