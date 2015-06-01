DELETE FROM dbo.doc_types

INSERT INTO dbo.doc_types (id, name, sys_name)
VALUES (1, N'Договор', 'CTRT')

INSERT INTO dbo.doc_types (id, name, sys_name)
VALUES (2, N'Приложение к договору', 'CTRTADD')

INSERT INTO dbo.doc_types (id, name, sys_name)
VALUES (3, N'Спецификация', 'SPEC')

INSERT INTO dbo.doc_types (id, name, sys_name)
VALUES (4, N'Акт выполненных работ', 'AKT')

INSERT INTO dbo.doc_types (id, name, sys_name)
VALUES (5, N'Товарная накладная', 'NAKL')