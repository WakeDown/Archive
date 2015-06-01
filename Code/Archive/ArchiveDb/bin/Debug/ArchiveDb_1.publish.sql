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
/*
Необходимо добавить столбец [dbo].[DocReqStateHistory].[creator_guid] таблицы [dbo].[DocReqStateHistory], но он не содержит значения по умолчанию и не допускает значения NULL. Если таблица содержит данные, скрипт ALTER окажется неработоспособным. Чтобы избежать возникновения этой проблемы, необходимо выполнить одно из следующих действий: добавить в столбец значение по умолчанию, пометить его как допускающий значения NULL или разрешить формирование интеллектуальных умолчаний в параметрах развертывания.

Необходимо добавить столбец [dbo].[DocReqStateHistory].[id_req_state] таблицы [dbo].[DocReqStateHistory], но он не содержит значения по умолчанию и не допускает значения NULL. Если таблица содержит данные, скрипт ALTER окажется неработоспособным. Чтобы избежать возникновения этой проблемы, необходимо выполнить одно из следующих действий: добавить в столбец значение по умолчанию, пометить его как допускающий значения NULL или разрешить формирование интеллектуальных умолчаний в параметрах развертывания.

Необходимо добавить столбец [dbo].[DocReqStateHistory].[id_request] таблицы [dbo].[DocReqStateHistory], но он не содержит значения по умолчанию и не допускает значения NULL. Если таблица содержит данные, скрипт ALTER окажется неработоспособным. Чтобы избежать возникновения этой проблемы, необходимо выполнить одно из следующих действий: добавить в столбец значение по умолчанию, пометить его как допускающий значения NULL или разрешить формирование интеллектуальных умолчаний в параметрах развертывания.
*/

IF EXISTS (select top 1 1 from [dbo].[DocReqStateHistory])
    RAISERROR (N'Обнаружены строки. Обновление схемы завершено из-за возможной потери данных.', 16, 127) WITH NOWAIT

GO
/*
Необходимо добавить столбец [dbo].[DocRequests].[id_document] таблицы [dbo].[DocRequests], но он не содержит значения по умолчанию и не допускает значения NULL. Если таблица содержит данные, скрипт ALTER окажется неработоспособным. Чтобы избежать возникновения этой проблемы, необходимо выполнить одно из следующих действий: добавить в столбец значение по умолчанию, пометить его как допускающий значения NULL или разрешить формирование интеллектуальных умолчаний в параметрах развертывания.

Необходимо добавить столбец [dbo].[DocRequests].[id_req_state] таблицы [dbo].[DocRequests], но он не содержит значения по умолчанию и не допускает значения NULL. Если таблица содержит данные, скрипт ALTER окажется неработоспособным. Чтобы избежать возникновения этой проблемы, необходимо выполнить одно из следующих действий: добавить в столбец значение по умолчанию, пометить его как допускающий значения NULL или разрешить формирование интеллектуальных умолчаний в параметрах развертывания.

Необходимо добавить столбец [dbo].[DocRequests].[user_guid] таблицы [dbo].[DocRequests], но он не содержит значения по умолчанию и не допускает значения NULL. Если таблица содержит данные, скрипт ALTER окажется неработоспособным. Чтобы избежать возникновения этой проблемы, необходимо выполнить одно из следующих действий: добавить в столбец значение по умолчанию, пометить его как допускающий значения NULL или разрешить формирование интеллектуальных умолчаний в параметрах развертывания.
*/

IF EXISTS (select top 1 1 from [dbo].[DocRequests])
    RAISERROR (N'Обнаружены строки. Обновление схемы завершено из-за возможной потери данных.', 16, 127) WITH NOWAIT

GO
/*
Необходимо добавить столбец [dbo].[DocScans].[creator_guid] таблицы [dbo].[DocScans], но он не содержит значения по умолчанию и не допускает значения NULL. Если таблица содержит данные, скрипт ALTER окажется неработоспособным. Чтобы избежать возникновения этой проблемы, необходимо выполнить одно из следующих действий: добавить в столбец значение по умолчанию, пометить его как допускающий значения NULL или разрешить формирование интеллектуальных умолчаний в параметрах развертывания.

Необходимо добавить столбец [dbo].[DocScans].[file_name] таблицы [dbo].[DocScans], но он не содержит значения по умолчанию и не допускает значения NULL. Если таблица содержит данные, скрипт ALTER окажется неработоспособным. Чтобы избежать возникновения этой проблемы, необходимо выполнить одно из следующих действий: добавить в столбец значение по умолчанию, пометить его как допускающий значения NULL или разрешить формирование интеллектуальных умолчаний в параметрах развертывания.

Необходимо добавить столбец [dbo].[DocScans].[id_document] таблицы [dbo].[DocScans], но он не содержит значения по умолчанию и не допускает значения NULL. Если таблица содержит данные, скрипт ALTER окажется неработоспособным. Чтобы избежать возникновения этой проблемы, необходимо выполнить одно из следующих действий: добавить в столбец значение по умолчанию, пометить его как допускающий значения NULL или разрешить формирование интеллектуальных умолчаний в параметрах развертывания.

Необходимо добавить столбец [dbo].[DocScans].[path] таблицы [dbo].[DocScans], но он не содержит значения по умолчанию и не допускает значения NULL. Если таблица содержит данные, скрипт ALTER окажется неработоспособным. Чтобы избежать возникновения этой проблемы, необходимо выполнить одно из следующих действий: добавить в столбец значение по умолчанию, пометить его как допускающий значения NULL или разрешить формирование интеллектуальных умолчаний в параметрах развертывания.
*/

IF EXISTS (select top 1 1 from [dbo].[DocScans])
    RAISERROR (N'Обнаружены строки. Обновление схемы завершено из-за возможной потери данных.', 16, 127) WITH NOWAIT

GO
/*
Необходимо добавить столбец [dbo].[DocStateHistory].[creator_guid] таблицы [dbo].[DocStateHistory], но он не содержит значения по умолчанию и не допускает значения NULL. Если таблица содержит данные, скрипт ALTER окажется неработоспособным. Чтобы избежать возникновения этой проблемы, необходимо выполнить одно из следующих действий: добавить в столбец значение по умолчанию, пометить его как допускающий значения NULL или разрешить формирование интеллектуальных умолчаний в параметрах развертывания.

Необходимо добавить столбец [dbo].[DocStateHistory].[id_doc_state] таблицы [dbo].[DocStateHistory], но он не содержит значения по умолчанию и не допускает значения NULL. Если таблица содержит данные, скрипт ALTER окажется неработоспособным. Чтобы избежать возникновения этой проблемы, необходимо выполнить одно из следующих действий: добавить в столбец значение по умолчанию, пометить его как допускающий значения NULL или разрешить формирование интеллектуальных умолчаний в параметрах развертывания.

Необходимо добавить столбец [dbo].[DocStateHistory].[id_document] таблицы [dbo].[DocStateHistory], но он не содержит значения по умолчанию и не допускает значения NULL. Если таблица содержит данные, скрипт ALTER окажется неработоспособным. Чтобы избежать возникновения этой проблемы, необходимо выполнить одно из следующих действий: добавить в столбец значение по умолчанию, пометить его как допускающий значения NULL или разрешить формирование интеллектуальных умолчаний в параметрах развертывания.
*/

IF EXISTS (select top 1 1 from [dbo].[DocStateHistory])
    RAISERROR (N'Обнаружены строки. Обновление схемы завершено из-за возможной потери данных.', 16, 127) WITH NOWAIT

GO
/*
Необходимо добавить столбец [dbo].[Documents].[doc_date] таблицы [dbo].[Documents], но он не содержит значения по умолчанию и не допускает значения NULL. Если таблица содержит данные, скрипт ALTER окажется неработоспособным. Чтобы избежать возникновения этой проблемы, необходимо выполнить одно из следующих действий: добавить в столбец значение по умолчанию, пометить его как допускающий значения NULL или разрешить формирование интеллектуальных умолчаний в параметрах развертывания.

Необходимо добавить столбец [dbo].[Documents].[doc_number] таблицы [dbo].[Documents], но он не содержит значения по умолчанию и не допускает значения NULL. Если таблица содержит данные, скрипт ALTER окажется неработоспособным. Чтобы избежать возникновения этой проблемы, необходимо выполнить одно из следующих действий: добавить в столбец значение по умолчанию, пометить его как допускающий значения NULL или разрешить формирование интеллектуальных умолчаний в параметрах развертывания.

Необходимо добавить столбец [dbo].[Documents].[id_contractor] таблицы [dbo].[Documents], но он не содержит значения по умолчанию и не допускает значения NULL. Если таблица содержит данные, скрипт ALTER окажется неработоспособным. Чтобы избежать возникновения этой проблемы, необходимо выполнить одно из следующих действий: добавить в столбец значение по умолчанию, пометить его как допускающий значения NULL или разрешить формирование интеллектуальных умолчаний в параметрах развертывания.

Необходимо добавить столбец [dbo].[Documents].[id_doc_state] таблицы [dbo].[Documents], но он не содержит значения по умолчанию и не допускает значения NULL. Если таблица содержит данные, скрипт ALTER окажется неработоспособным. Чтобы избежать возникновения этой проблемы, необходимо выполнить одно из следующих действий: добавить в столбец значение по умолчанию, пометить его как допускающий значения NULL или разрешить формирование интеллектуальных умолчаний в параметрах развертывания.

Необходимо добавить столбец [dbo].[Documents].[id_doc_type] таблицы [dbo].[Documents], но он не содержит значения по умолчанию и не допускает значения NULL. Если таблица содержит данные, скрипт ALTER окажется неработоспособным. Чтобы избежать возникновения этой проблемы, необходимо выполнить одно из следующих действий: добавить в столбец значение по умолчанию, пометить его как допускающий значения NULL или разрешить формирование интеллектуальных умолчаний в параметрах развертывания.

Необходимо добавить столбец [dbo].[Documents].[id_organization] таблицы [dbo].[Documents], но он не содержит значения по умолчанию и не допускает значения NULL. Если таблица содержит данные, скрипт ALTER окажется неработоспособным. Чтобы избежать возникновения этой проблемы, необходимо выполнить одно из следующих действий: добавить в столбец значение по умолчанию, пометить его как допускающий значения NULL или разрешить формирование интеллектуальных умолчаний в параметрах развертывания.

Необходимо добавить столбец [dbo].[Documents].[id_stock] таблицы [dbo].[Documents], но он не содержит значения по умолчанию и не допускает значения NULL. Если таблица содержит данные, скрипт ALTER окажется неработоспособным. Чтобы избежать возникновения этой проблемы, необходимо выполнить одно из следующих действий: добавить в столбец значение по умолчанию, пометить его как допускающий значения NULL или разрешить формирование интеллектуальных умолчаний в параметрах развертывания.

Необходимо добавить столбец [dbo].[Documents].[manager_guid] таблицы [dbo].[Documents], но он не содержит значения по умолчанию и не допускает значения NULL. Если таблица содержит данные, скрипт ALTER окажется неработоспособным. Чтобы избежать возникновения этой проблемы, необходимо выполнить одно из следующих действий: добавить в столбец значение по умолчанию, пометить его как допускающий значения NULL или разрешить формирование интеллектуальных умолчаний в параметрах развертывания.
*/

IF EXISTS (select top 1 1 from [dbo].[Documents])
    RAISERROR (N'Обнаружены строки. Обновление схемы завершено из-за возможной потери данных.', 16, 127) WITH NOWAIT

GO
/*
Столбец date_load таблицы [dbo].[StockImports] необходимо изменить с NULL на NOT NULL. Если таблица содержит данные, скрипт ALTER может оказаться неработоспособным. Чтобы избежать возникновения этой проблемы, необходимо добавить значения этого столбца во все строки, пометить его как допускающий значения NULL или разрешить формирование интеллектуальных умолчаний в параметрах развертывания.
*/

IF EXISTS (select top 1 1 from [dbo].[StockImports])
    RAISERROR (N'Обнаружены строки. Обновление схемы завершено из-за возможной потери данных.', 16, 127) WITH NOWAIT

GO
PRINT N'Операция рефакторинга Rename с помощью ключа 8b47b76d-af9a-4b24-978d-d395ea3fb2b9 пропущена, элемент [dbo].[doc_states].[Id] (SqlSimpleColumn) не будет переименован в id';


GO
PRINT N'Операция рефакторинга Rename с помощью ключа 1d699322-e1b8-42ff-b35f-a2c380be777f пропущена, элемент [dbo].[Documents].[IdStock] (SqlSimpleColumn) не будет переименован в id_stock';


GO
PRINT N'Операция рефакторинга Rename с помощью ключа e2d79244-3e82-46f0-a02e-11429b2a6b95 пропущена, элемент [dbo].[Documents].[Id] (SqlSimpleColumn) не будет переименован в id';


GO
PRINT N'Операция рефакторинга Rename с помощью ключа 91639827-57e4-4533-a77b-71b5f41bd3b7 пропущена, элемент [dbo].[StockImports].[Id] (SqlSimpleColumn) не будет переименован в id';


GO
PRINT N'Указанная ниже операция создана из файла журнала рефакторинга 19db2ca2-7aa2-4276-a132-1881680eb3bf';

PRINT N'Переименование [dbo].[StockImports].[DateLoad] в date_load';


GO
EXECUTE sp_rename @objname = N'[dbo].[StockImports].[DateLoad]', @newname = N'date_load', @objtype = N'COLUMN';


GO
PRINT N'Операция рефакторинга Rename с помощью ключа 6a13a14c-0e56-4306-9708-97779789c21f пропущена, элемент [dbo].[StockImports].[Descr] (SqlSimpleColumn) не будет переименован в descr';


GO
PRINT N'Операция рефакторинга Rename с помощью ключа 95aba64f-b0cf-4d75-81d6-ee107710495c пропущена, элемент [dbo].[Stock].[Id] (SqlSimpleColumn) не будет переименован в id';


GO
PRINT N'Указанная ниже операция создана из файла журнала рефакторинга 538d5e91-a593-4ce9-a6e3-b7962567aa32';

PRINT N'Переименование [dbo].[Stock].[IdStockImport] в id_stock_import';


GO
EXECUTE sp_rename @objname = N'[dbo].[Stock].[IdStockImport]', @newname = N'id_stock_import', @objtype = N'COLUMN';


GO
PRINT N'Указанная ниже операция создана из файла журнала рефакторинга 8425ab28-b1ce-4970-84a2-d42b5b24e9f8';

PRINT N'Переименование [dbo].[Stock].[IdRec] в id_rec';


GO
EXECUTE sp_rename @objname = N'[dbo].[Stock].[IdRec]', @newname = N'id_rec', @objtype = N'COLUMN';


GO
PRINT N'Указанная ниже операция создана из файла журнала рефакторинга ae3082a6-9f28-4d39-8a6b-3aa8b47e7c11';

PRINT N'Переименование [dbo].[Stock].[DocType] в doc_type';


GO
EXECUTE sp_rename @objname = N'[dbo].[Stock].[DocType]', @newname = N'doc_type', @objtype = N'COLUMN';


GO
PRINT N'Указанная ниже операция создана из файла журнала рефакторинга 36909ae7-3bdd-4f40-92b3-96b0b9071b48, 28777e58-2657-467b-823a-6b3d4b12c101';

PRINT N'Переименование [dbo].[Stock].[DocNumber] в doc_number';


GO
EXECUTE sp_rename @objname = N'[dbo].[Stock].[DocNumber]', @newname = N'doc_number', @objtype = N'COLUMN';


GO
PRINT N'Указанная ниже операция создана из файла журнала рефакторинга badfb879-2651-41f2-aa26-ce69cdf42748';

PRINT N'Переименование [dbo].[Stock].[DocDate] в doc_date';


GO
EXECUTE sp_rename @objname = N'[dbo].[Stock].[DocDate]', @newname = N'doc_date', @objtype = N'COLUMN';


GO
PRINT N'Операция рефакторинга Rename с помощью ключа 193322aa-f901-42a8-b2a3-56365a8c96e2 пропущена, элемент [dbo].[Stock].[Contractor] (SqlSimpleColumn) не будет переименован в contractor';


GO
PRINT N'Операция рефакторинга Rename с помощью ключа 9d2250c6-f065-452a-8c2a-cb02de28c5a5 пропущена, элемент [dbo].[Stock].[Manager] (SqlSimpleColumn) не будет переименован в manager';


GO
PRINT N'Операция рефакторинга Rename с помощью ключа 70315626-e2e5-4e8a-b058-3ee83c54739e пропущена, элемент [dbo].[Stock].[Organization] (SqlSimpleColumn) не будет переименован в organization';


GO
PRINT N'Указанная ниже операция создана из файла журнала рефакторинга 5b937ec8-d281-4db2-a4c7-c164e3670e2e';

PRINT N'Переименование [dbo].[Stock].[Processed] в is_processed';


GO
EXECUTE sp_rename @objname = N'[dbo].[Stock].[Processed]', @newname = N'is_processed', @objtype = N'COLUMN';


GO
PRINT N'Указанная ниже операция создана из файла журнала рефакторинга fc51269d-0162-4983-81e7-9f47093bb1dd, 5d590708-3afb-4b43-b318-1a847808c67f';

PRINT N'Переименование [dbo].[Stock].[DateCreate] в dattim1';


GO
EXECUTE sp_rename @objname = N'[dbo].[Stock].[DateCreate]', @newname = N'dattim1', @objtype = N'COLUMN';


GO
PRINT N'Указанная ниже операция создана из файла журнала рефакторинга c9c8bf6c-f233-4c8e-8c60-d79d827fa78c';

PRINT N'Переименование [dbo].[Stock].[DateProcess] в date_process';


GO
EXECUTE sp_rename @objname = N'[dbo].[Stock].[DateProcess]', @newname = N'date_process', @objtype = N'COLUMN';


GO
PRINT N'Операция рефакторинга Rename с помощью ключа 5029f799-ca25-4c81-a3d3-0562e7e4f61d пропущена, элемент [dbo].[Documents].[date_del] (SqlSimpleColumn) не будет переименован в dat_del';


GO
PRINT N'Операция рефакторинга Rename с помощью ключа 1e794c70-0252-4e92-b59a-d573e3ddd715, 3fff2133-65ea-4a69-8188-dbf748ebd383 пропущена, элемент [dbo].[Documents].[id_state] (SqlSimpleColumn) не будет переименован в id_doc_state';


GO
PRINT N'Операция рефакторинга Rename с помощью ключа ddbbe9af-6d2f-48f3-8a07-b00c5e445bda, 7853a6a9-6edb-4ab7-9a41-9171730d9b3b, 4ab6723d-c2c8-4a42-ac57-e897a1d2ff36 пропущена, элемент [dbo].[Documents].[id_address] (SqlSimpleColumn) не будет переименован в id_doc_place';


GO
PRINT N'Операция рефакторинга Rename с помощью ключа ad5a2263-0f4c-45d7-93c0-b0db415416a1 пропущена, элемент [dbo].[Documents].[date_create] (SqlSimpleColumn) не будет переименован в dattim1';


GO
PRINT N'Операция рефакторинга Rename с помощью ключа c335ffea-5589-4ec4-bc7a-1bcc3955d189 пропущена, элемент [dbo].[DocStateHistory].[Id] (SqlSimpleColumn) не будет переименован в id';


GO
PRINT N'Операция рефакторинга Rename с помощью ключа 259c5779-1e67-4c70-ae67-616f8b7d1464 пропущена, элемент [dbo].[Documents].[id_manager] (SqlSimpleColumn) не будет переименован в manager_guid';


GO
PRINT N'Операция рефакторинга Rename с помощью ключа 091e5a3f-6869-441d-a10c-4fcbb4660df2 пропущена, элемент [dbo].[DocStateHistory].[id_creator] (SqlSimpleColumn) не будет переименован в creator_guid';


GO
PRINT N'Операция рефакторинга Rename с помощью ключа 6f01b126-5161-47ee-92c5-96b55fef8de7 пропущена, элемент [dbo].[DocScans].[Id] (SqlSimpleColumn) не будет переименован в id';


GO
PRINT N'Операция рефакторинга Rename с помощью ключа 71a3d0f2-f5fe-4603-85a2-a8fad1e061f9 пропущена, элемент [dbo].[DocRequests].[Id] (SqlSimpleColumn) не будет переименован в id';


GO
PRINT N'Операция рефакторинга Rename с помощью ключа 94c64c26-c032-403a-b614-3849cc851a7f пропущена, элемент [dbo].[request_states].[Id] (SqlSimpleColumn) не будет переименован в id';


GO
PRINT N'Операция рефакторинга Rename с помощью ключа 2597499f-eb8f-4176-a80b-050f1c860627 пропущена, элемент [dbo].[DocReqStateHistory].[Id] (SqlSimpleColumn) не будет переименован в id';


GO
PRINT N'Выполняется удаление ограничение без названия для [dbo].[Stock]...';


GO
ALTER TABLE [dbo].[Stock] DROP CONSTRAINT [DF__Stock__Processed__1BFD2C07];


GO
PRINT N'Выполняется удаление ограничение без названия для [dbo].[Stock]...';


GO
ALTER TABLE [dbo].[Stock] DROP CONSTRAINT [DF__Stock__DateCreat__1CF15040];


GO
PRINT N'Выполняется запуск перестройки таблицы [dbo].[DocReqStateHistory]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_DocReqStateHistory] (
    [id]           INT              IDENTITY (1, 1) NOT NULL,
    [id_request]   INT              NOT NULL,
    [id_req_state] SMALLINT         NOT NULL,
    [dattim1]      DATETIME         DEFAULT getdate() NOT NULL,
    [creator_guid] UNIQUEIDENTIFIER NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[DocReqStateHistory])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_DocReqStateHistory] ON;
        INSERT INTO [dbo].[tmp_ms_xx_DocReqStateHistory] ([id])
        SELECT   [id]
        FROM     [dbo].[DocReqStateHistory]
        ORDER BY [id] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_DocReqStateHistory] OFF;
    END

DROP TABLE [dbo].[DocReqStateHistory];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_DocReqStateHistory]', N'DocReqStateHistory';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Выполняется создание [dbo].[DocReqStateHistory].[IX_DocReqStateHistory_id_request]...';


GO
CREATE NONCLUSTERED INDEX [IX_DocReqStateHistory_id_request]
    ON [dbo].[DocReqStateHistory]([id_request] ASC);


GO
PRINT N'Выполняется запуск перестройки таблицы [dbo].[DocRequests]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_DocRequests] (
    [id]           INT              IDENTITY (1, 1) NOT NULL,
    [user_guid]    UNIQUEIDENTIFIER NOT NULL,
    [id_document]  BIGINT           NOT NULL,
    [id_req_state] SMALLINT         NOT NULL,
    [dattim1]      DATETIME         DEFAULT getdate() NOT NULL,
    [dattim2]      DATETIME         DEFAULT '3.3.3333' NOT NULL,
    [enabled]      BIT              DEFAULT 1 NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[DocRequests])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_DocRequests] ON;
        INSERT INTO [dbo].[tmp_ms_xx_DocRequests] ([id])
        SELECT   [id]
        FROM     [dbo].[DocRequests]
        ORDER BY [id] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_DocRequests] OFF;
    END

DROP TABLE [dbo].[DocRequests];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_DocRequests]', N'DocRequests';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Выполняется создание [dbo].[DocRequests].[IX_DocRequests_id_document]...';


GO
CREATE NONCLUSTERED INDEX [IX_DocRequests_id_document]
    ON [dbo].[DocRequests]([id_document] ASC);


GO
PRINT N'Выполняется создание [dbo].[DocRequests].[IX_DocRequests_user_guid]...';


GO
CREATE NONCLUSTERED INDEX [IX_DocRequests_user_guid]
    ON [dbo].[DocRequests]([user_guid] ASC);


GO
PRINT N'Выполняется запуск перестройки таблицы [dbo].[DocScans]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_DocScans] (
    [id]           BIGINT           IDENTITY (1, 1) NOT NULL,
    [file_name]    NVARCHAR (150)   NOT NULL,
    [path]         NVARCHAR (500)   NOT NULL,
    [id_document]  BIGINT           NOT NULL,
    [creator_guid] UNIQUEIDENTIFIER NOT NULL,
    [dattim1]      DATETIME         DEFAULT getdate() NOT NULL,
    [dattim2]      DATETIME         DEFAULT '3.3.3333' NOT NULL,
    [enabled]      BIT              DEFAULT 1 NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[DocScans])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_DocScans] ON;
        INSERT INTO [dbo].[tmp_ms_xx_DocScans] ([id])
        SELECT   [id]
        FROM     [dbo].[DocScans]
        ORDER BY [id] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_DocScans] OFF;
    END

DROP TABLE [dbo].[DocScans];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_DocScans]', N'DocScans';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Выполняется создание [dbo].[DocScans].[IX_DocScans_id_document]...';


GO
CREATE NONCLUSTERED INDEX [IX_DocScans_id_document]
    ON [dbo].[DocScans]([id_document] ASC);


GO
PRINT N'Выполняется запуск перестройки таблицы [dbo].[DocStateHistory]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_DocStateHistory] (
    [id]           BIGINT           IDENTITY (1, 1) NOT NULL,
    [id_document]  BIGINT           NOT NULL,
    [id_doc_state] SMALLINT         NOT NULL,
    [dattim1]      DATETIME         DEFAULT getdate() NOT NULL,
    [creator_guid] UNIQUEIDENTIFIER NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[DocStateHistory])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_DocStateHistory] ON;
        INSERT INTO [dbo].[tmp_ms_xx_DocStateHistory] ([id])
        SELECT   [id]
        FROM     [dbo].[DocStateHistory]
        ORDER BY [id] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_DocStateHistory] OFF;
    END

DROP TABLE [dbo].[DocStateHistory];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_DocStateHistory]', N'DocStateHistory';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Выполняется создание [dbo].[DocStateHistory].[IX_DocStateHistory_id_document]...';


GO
CREATE NONCLUSTERED INDEX [IX_DocStateHistory_id_document]
    ON [dbo].[DocStateHistory]([id_document] ASC);


GO
PRINT N'Выполняется запуск перестройки таблицы [dbo].[Documents]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Documents] (
    [id]              BIGINT           IDENTITY (1, 1) NOT NULL,
    [id_stock]        BIGINT           NOT NULL,
    [id_contractor]   INT              NOT NULL,
    [manager_guid]    UNIQUEIDENTIFIER NOT NULL,
    [id_doc_type]     SMALLINT         NOT NULL,
    [doc_date]        DATETIME         NOT NULL,
    [id_organization] SMALLINT         NOT NULL,
    [doc_number]      NVARCHAR (50)    NOT NULL,
    [id_doc_state]    SMALLINT         NOT NULL,
    [dattim1]         DATETIME         DEFAULT getdate() NOT NULL,
    [dattim2]         DATETIME         DEFAULT '3.3.3333' NOT NULL,
    [enabled]         BIT              DEFAULT 1 NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Documents])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Documents] ON;
        INSERT INTO [dbo].[tmp_ms_xx_Documents] ([id])
        SELECT   [id]
        FROM     [dbo].[Documents]
        ORDER BY [id] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Documents] OFF;
    END

DROP TABLE [dbo].[Documents];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Documents]', N'Documents';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Выполняется создание [dbo].[Documents].[IX_Documents_id_doc_state]...';


GO
CREATE NONCLUSTERED INDEX [IX_Documents_id_doc_state]
    ON [dbo].[Documents]([id_doc_state] ASC);


GO
PRINT N'Выполняется создание [dbo].[Documents].[IX_Documents_manager_guid]...';


GO
CREATE NONCLUSTERED INDEX [IX_Documents_manager_guid]
    ON [dbo].[Documents]([manager_guid] ASC);


GO
PRINT N'Выполняется запуск перестройки таблицы [dbo].[Stock]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Stock] (
    [id]              BIGINT         IDENTITY (1, 1) NOT NULL,
    [id_stock_import] INT            NOT NULL,
    [id_rec]          NVARCHAR (20)  NULL,
    [doc_type]        NVARCHAR (150) NULL,
    [doc_number]      NVARCHAR (50)  NULL,
    [doc_date]        NVARCHAR (20)  NULL,
    [contractor]      NVARCHAR (250) NULL,
    [manager]         NVARCHAR (150) NULL,
    [organization]    NVARCHAR (150) NULL,
    [is_processed]    BIT            DEFAULT 1 NOT NULL,
    [dattim1]         DATETIME       DEFAULT getdate() NOT NULL,
    [date_process]    DATETIME       NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Stock])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Stock] ON;
        INSERT INTO [dbo].[tmp_ms_xx_Stock] ([id], [id_stock_import], [id_rec], [doc_type], [doc_number], [doc_date], [Contractor], [Manager], [Organization], [is_processed], [dattim1], [date_process])
        SELECT   [id],
                 [id_stock_import],
                 [id_rec],
                 [doc_type],
                 [doc_number],
                 [doc_date],
                 [Contractor],
                 [Manager],
                 [Organization],
                 [is_processed],
                 [dattim1],
                 [date_process]
        FROM     [dbo].[Stock]
        ORDER BY [id] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Stock] OFF;
    END

DROP TABLE [dbo].[Stock];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Stock]', N'Stock';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Выполняется создание [dbo].[Stock].[IX_Stock_id_stock_import]...';


GO
CREATE NONCLUSTERED INDEX [IX_Stock_id_stock_import]
    ON [dbo].[Stock]([id_stock_import] ASC);


GO
PRINT N'Выполняется запуск перестройки таблицы [dbo].[StockImports]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_StockImports] (
    [id]        INT            IDENTITY (1, 1) NOT NULL,
    [date_load] DATETIME       DEFAULT getdate() NOT NULL,
    [descr]     NVARCHAR (500) NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[StockImports])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_StockImports] ON;
        INSERT INTO [dbo].[tmp_ms_xx_StockImports] ([id], [date_load], [Descr])
        SELECT   [id],
                 [date_load],
                 [Descr]
        FROM     [dbo].[StockImports]
        ORDER BY [id] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_StockImports] OFF;
    END

DROP TABLE [dbo].[StockImports];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_StockImports]', N'StockImports';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Выполняется создание [dbo].[doc_states]...';


GO
CREATE TABLE [dbo].[doc_states] (
    [id]       SMALLINT      IDENTITY (1, 1) NOT NULL,
    [name]     NVARCHAR (50) NOT NULL,
    [dattim1]  DATETIME      NOT NULL,
    [enabled]  BIT           NOT NULL,
    [sys_name] NVARCHAR (10) NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
PRINT N'Выполняется создание [dbo].[request_states]...';


GO
CREATE TABLE [dbo].[request_states] (
    [id]       SMALLINT      IDENTITY (1, 1) NOT NULL,
    [name]     NVARCHAR (50) NOT NULL,
    [dattim1]  DATETIME      NOT NULL,
    [enabled]  BIT           NOT NULL,
    [sys_name] NVARCHAR (10) NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
PRINT N'Выполняется создание ограничение без названия для [dbo].[doc_states]...';


GO
ALTER TABLE [dbo].[doc_states]
    ADD DEFAULT getdate() FOR [dattim1];


GO
PRINT N'Выполняется создание ограничение без названия для [dbo].[doc_states]...';


GO
ALTER TABLE [dbo].[doc_states]
    ADD DEFAULT 1 FOR [enabled];


GO
PRINT N'Выполняется создание ограничение без названия для [dbo].[request_states]...';


GO
ALTER TABLE [dbo].[request_states]
    ADD DEFAULT getdate() FOR [dattim1];


GO
PRINT N'Выполняется создание ограничение без названия для [dbo].[request_states]...';


GO
ALTER TABLE [dbo].[request_states]
    ADD DEFAULT 1 FOR [enabled];


GO
PRINT N'Выполняется создание [dbo].[Documents].[id_contractor].[MS_Description]...';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Контрагент', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Documents', @level2type = N'COLUMN', @level2name = N'id_contractor';


GO
PRINT N'Выполняется создание [dbo].[Documents].[doc_date].[MS_Description]...';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Дата создания/проведения (начала) документа', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Documents', @level2type = N'COLUMN', @level2name = N'doc_date';


GO
PRINT N'Выполняется создание [dbo].[Documents].[id_organization].[MS_Description]...';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Юр. лицо ЮНИТ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Documents', @level2type = N'COLUMN', @level2name = N'id_organization';


GO
PRINT N'Выполняется создание [dbo].[Documents].[doc_number].[MS_Description]...';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Номер документа', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Documents', @level2type = N'COLUMN', @level2name = N'doc_number';


GO
PRINT N'Выполняется создание [dbo].[Documents].[id_doc_state].[MS_Description]...';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Текущий статус документа', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Documents', @level2type = N'COLUMN', @level2name = N'id_doc_state';


GO
PRINT N'Выполняется создание [dbo].[Stock].[id_rec].[MS_Description]...';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'ID записи из источника (1С)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Stock', @level2type = N'COLUMN', @level2name = N'id_rec';


GO
PRINT N'Выполняется создание [dbo].[Stock].[organization].[MS_Description]...';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Юр. лицо ЮНИТ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Stock', @level2type = N'COLUMN', @level2name = N'organization';


GO
PRINT N'Выполняется создание [dbo].[Stock].[date_process].[MS_Description]...';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Дата обработки', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Stock', @level2type = N'COLUMN', @level2name = N'date_process';


GO
-- Выполняется этап рефакторинга для обновления развернутых журналов транзакций на целевом сервере
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '1d699322-e1b8-42ff-b35f-a2c380be777f')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('1d699322-e1b8-42ff-b35f-a2c380be777f')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'e2d79244-3e82-46f0-a02e-11429b2a6b95')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('e2d79244-3e82-46f0-a02e-11429b2a6b95')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '91639827-57e4-4533-a77b-71b5f41bd3b7')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('91639827-57e4-4533-a77b-71b5f41bd3b7')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '19db2ca2-7aa2-4276-a132-1881680eb3bf')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('19db2ca2-7aa2-4276-a132-1881680eb3bf')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '6a13a14c-0e56-4306-9708-97779789c21f')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('6a13a14c-0e56-4306-9708-97779789c21f')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '95aba64f-b0cf-4d75-81d6-ee107710495c')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('95aba64f-b0cf-4d75-81d6-ee107710495c')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '538d5e91-a593-4ce9-a6e3-b7962567aa32')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('538d5e91-a593-4ce9-a6e3-b7962567aa32')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '8425ab28-b1ce-4970-84a2-d42b5b24e9f8')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('8425ab28-b1ce-4970-84a2-d42b5b24e9f8')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'ae3082a6-9f28-4d39-8a6b-3aa8b47e7c11')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('ae3082a6-9f28-4d39-8a6b-3aa8b47e7c11')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '36909ae7-3bdd-4f40-92b3-96b0b9071b48')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('36909ae7-3bdd-4f40-92b3-96b0b9071b48')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '28777e58-2657-467b-823a-6b3d4b12c101')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('28777e58-2657-467b-823a-6b3d4b12c101')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'badfb879-2651-41f2-aa26-ce69cdf42748')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('badfb879-2651-41f2-aa26-ce69cdf42748')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '193322aa-f901-42a8-b2a3-56365a8c96e2')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('193322aa-f901-42a8-b2a3-56365a8c96e2')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '9d2250c6-f065-452a-8c2a-cb02de28c5a5')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('9d2250c6-f065-452a-8c2a-cb02de28c5a5')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '70315626-e2e5-4e8a-b058-3ee83c54739e')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('70315626-e2e5-4e8a-b058-3ee83c54739e')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '5b937ec8-d281-4db2-a4c7-c164e3670e2e')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('5b937ec8-d281-4db2-a4c7-c164e3670e2e')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'fc51269d-0162-4983-81e7-9f47093bb1dd')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('fc51269d-0162-4983-81e7-9f47093bb1dd')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'c9c8bf6c-f233-4c8e-8c60-d79d827fa78c')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('c9c8bf6c-f233-4c8e-8c60-d79d827fa78c')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '81aaba02-30b4-462b-bb1e-ec937251db6d')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('81aaba02-30b4-462b-bb1e-ec937251db6d')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '5029f799-ca25-4c81-a3d3-0562e7e4f61d')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('5029f799-ca25-4c81-a3d3-0562e7e4f61d')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '77ece6b5-a9e7-40f3-8fc5-9001ea7deda4')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('77ece6b5-a9e7-40f3-8fc5-9001ea7deda4')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'c274db57-369f-417b-9fef-a01064967592')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('c274db57-369f-417b-9fef-a01064967592')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '1e794c70-0252-4e92-b59a-d573e3ddd715')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('1e794c70-0252-4e92-b59a-d573e3ddd715')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '3fff2133-65ea-4a69-8188-dbf748ebd383')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('3fff2133-65ea-4a69-8188-dbf748ebd383')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'ddbbe9af-6d2f-48f3-8a07-b00c5e445bda')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('ddbbe9af-6d2f-48f3-8a07-b00c5e445bda')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '7853a6a9-6edb-4ab7-9a41-9171730d9b3b')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('7853a6a9-6edb-4ab7-9a41-9171730d9b3b')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '4ab6723d-c2c8-4a42-ac57-e897a1d2ff36')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('4ab6723d-c2c8-4a42-ac57-e897a1d2ff36')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'ad5a2263-0f4c-45d7-93c0-b0db415416a1')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('ad5a2263-0f4c-45d7-93c0-b0db415416a1')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '5d590708-3afb-4b43-b318-1a847808c67f')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('5d590708-3afb-4b43-b318-1a847808c67f')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'c335ffea-5589-4ec4-bc7a-1bcc3955d189')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('c335ffea-5589-4ec4-bc7a-1bcc3955d189')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '259c5779-1e67-4c70-ae67-616f8b7d1464')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('259c5779-1e67-4c70-ae67-616f8b7d1464')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '091e5a3f-6869-441d-a10c-4fcbb4660df2')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('091e5a3f-6869-441d-a10c-4fcbb4660df2')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '8b47b76d-af9a-4b24-978d-d395ea3fb2b9')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('8b47b76d-af9a-4b24-978d-d395ea3fb2b9')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '31b7081b-42bc-44a2-8331-cfaedfaa7913')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('31b7081b-42bc-44a2-8331-cfaedfaa7913')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '49d7366c-eaba-4181-98f7-8752837d8eaf')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('49d7366c-eaba-4181-98f7-8752837d8eaf')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '6f01b126-5161-47ee-92c5-96b55fef8de7')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('6f01b126-5161-47ee-92c5-96b55fef8de7')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '71a3d0f2-f5fe-4603-85a2-a8fad1e061f9')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('71a3d0f2-f5fe-4603-85a2-a8fad1e061f9')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '94c64c26-c032-403a-b614-3849cc851a7f')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('94c64c26-c032-403a-b614-3849cc851a7f')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '2597499f-eb8f-4176-a80b-050f1c860627')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('2597499f-eb8f-4176-a80b-050f1c860627')

GO

GO
PRINT N'Обновление завершено.';


GO
