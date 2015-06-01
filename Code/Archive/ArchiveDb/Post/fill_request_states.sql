DELETE FROM dbo.doc_requests

INSERT INTO dbo.request_states (id, name, sys_name)
VALUES  (1, N'Новый', N'NEW')

INSERT INTO dbo.request_states (id, name, sys_name)
VALUES  (2, N'Обработка', N'EXECUTE')

INSERT INTO dbo.request_states (id, name, sys_name)
VALUES  (3, N'Выполнен', N'PROCESSED')