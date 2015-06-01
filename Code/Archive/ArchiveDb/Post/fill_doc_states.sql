DELETE FROM dbo.doc_states

INSERT INTO dbo.doc_states (id, name, sys_name)
VALUES (1, N'Добавлен', N'ADD')

INSERT INTO dbo.doc_states (id, name, sys_name)
VALUES (2, N'В архиве', N'ARCHIVE')

INSERT INTO dbo.doc_states (id, name, sys_name)
VALUES (3, N'Выдан', N'DELIVERY')
