/**
Uma trigger � um tipo de stored procedure que � automaticamente disparada quam h� um evento, como uma altera��o nos dados de uma tabela por exemplo.

Tem 3 tipos: Triggers DML (Data Manipulation Language) - INSERT, DELETE, UPDATE
			 Triggers DDL (Data Definition Language) - ALTER, DROP, CREAT
			 Triggers de Logon
**/

CREATE TRIGGER TRG_LOG_BANCO
ON DATABASE
FOR DDL_DATABASE_LEVEL_EVENTS
AS BEGIN
	DECLARE @DATA XML, @MSG VARCHAR(5000);

	SET @DATA = EVENTDATA();

	SET @MSG = @DATA.value('(/EVENT_INSTANCE/EventType)[1]','varchar(100)');
	PRINT @MSG;

	SET @MSG = @DATA.value('(/EVENT_INSTANCE/ObjectType)[1]','varchar(100)');
	PRINT @MSG;

	SET @MSG = @DATA.value('(/EVENT_INSTANCE/ObjectName)[1]','varchar(100)');
	PRINT @MSG;

	SET @MSG = @DATA.value('(/EVENT_INSTANCE/TSQLCommand/CommandText)[1]','varchar(5000)');
	PRINT @MSG;
END

DROP TRIGGER TRG_LOG_BANCO

DROP TABLE TESTE

CREATE TABLE TESTE (ID INT, NOME VARCHAR (25))

ALTER TABLE TESTE
ADD EMAIL VARCHAR (20)


-- EXEMPLO 2 - BLOQUEAR CRIACAO DE TABELAS

GO
CREATE TRIGGER TRG_BLOCK_CREATE_TABLE
ON DATABASE
FOR CREATE_TABLE
AS BEGIN
	SELECT EVENTDATA().value('(/EVENT_INSTANCE/TSQLCommand/CommandText)[1]','varchar(max)');
	RAISERROR('SEM PERMISS�O, VERIFICAR COM O SYSADMIN.', 16, 1);
	ROLLBACK;
END

CREATE TABLE TESTE2 (ID INT)


-- EXEMPLO 3

CREATE TABLE TB_DDL_LOG
(
	DataCriacao DATETIME2,
	DB_User VARCHAR(100),
	EVENTO VARCHAR(100),
	TSQL_COMMAND VARCHAR(5000),
);

SELECT * FROM TB_DDL_LOG


CREATE TRIGGER TRG_LOG_DATABASE
ON DATABASE
FOR DDL_DATABASE_LEVEL_EVENTS
AS BEGIN
	DECLARE @DATA XML;
	SET @DATA = EVENTDATA();

	INSERT INTO TB_DDL_LOG
	(DataCriacao, DB_User, EVENTO, TSQL_COMMAND)
	VALUES 
	(GETDATE(), CONVERT(VARCHAR(100), CURRENT_USER), 
	@DATA.value('(/EVENT_INSTANCE/EventType)[1]', 'varchar(100)'),
	@DATA.value('(/EVENT_INSTANCE/TSQLCommand/CommandText)[1]', 'varchar(5000)'))
END

CREATE TABLE TESTE_00000000 (ID INT);
DROP TABLE TESTE_00000000;
SELECT * FROM TB_DDL_LOG





































































