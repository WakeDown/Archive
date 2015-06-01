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
VALUES (1, N'Договор', 'CTRT')

INSERT INTO doc_types (id, name, sys_name)
VALUES (2, N'Приложение к договору', 'CTRTADD')

INSERT INTO doc_types (id, name, sys_name)
VALUES (3, N'Спецификация', 'SPEC')

INSERT INTO doc_types (id, name, sys_name)
VALUES (4, N'Акт выполненных работ', 'AKT')

INSERT INTO doc_types (id, name, sys_name)
VALUES (5, N'Товарная накладная', 'NAKL')
GO
