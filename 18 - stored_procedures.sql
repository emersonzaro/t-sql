
/**
Stored Procedure � uma cole��o de comandos SQL criada para ser utilizada de forma permanente ou tempor�ria, pode ser local
ou global.
N�o retornam um valor como as fun��es, tem retorno tipo Status para indicar uma falha ou sucesso.
Vantagens:
	1 - Execu��o r�pida do que um comando SQL (fica am cache ap�s a execu��o da mesma)
	2 - Diminiu tr�fego na rede
	3 - Seguran�a
	4 - Programa��o Modular - podem ser chamadas de qualquer aplica��o.
**/
IN
CREATE PROCEDURE PROC_A
AS
BEGIN
	PRINT 'PROC_A' + CAST(@@NESTLEVEL AS VARCHAR(2));
	EXEC PROC_B;
	PRINT 'VOLTEI PARA PROC_A';
END

CREATE PROCEDURE PROC_B
AS
BEGIN
	PRINT 'PROC_B' + CAST(@@NESTLEVEL AS VARCHAR(2));
	EXEC PROC_C;
	PRINT 'VOLTEI PARA PROC_B';
END
	
CREATE PROCEDURE PROC_C
AS
BEGIN
	PRINT 'PROC_A' + CAST(@@NESTLEVEL AS VARCHAR(2));
END

EXEC PROC_A

DROP PROCEDURE PROC_C

-- PASSAR PARR�METROS

ALTER PROCEDURE BuscarEnderecoPorEntidade @ENTIDADE AS VARCHAR(30)
AS
BEGIN 
	IF @ENTIDADE = 'CLIENTE'
		SELECT Logradouro, Cidade, CEP, Pais FROM TB_ENDERECO WHERE ClienteId IS NOT NULL
	ELSE IF @ENTIDADE = 'FUNCIONARIO'
		SELECT Logradouro, Cidade, CEP, Pais FROM TB_ENDERECO WHERE FuncionarioId IS NOT NULL
	ELSE IF @ENTIDADE = 'FORNECEDOR'
		SELECT Logradouro, Cidade, CEP, Pais FROM TB_ENDERECO WHERE FornecedorId IS NOT NULL
	ELSE
		SELECT 'OPC�O INV�LIDA, SELECIONE AS OP��ES: CLIENTE, FUNCION�RIO OU FORNECEDOR'
END

EXEC BuscarEnderecoPorEntidade @ENTIDADE = 'CLIENTE\'


--OUTPUT

CREATE PROCEDURE CalcularIdade @IDADE AS INT OUTPUT, @DATA_NASCIMENTO AS DATETIME2
AS
BEGIN
	SET @IDADE = DATEDIFF(YEAR, @DATA_NASCIMENTO, GETDATE())
END


DECLARE @IDADE_OUT AS INT = 0;

PRINT 'IDADE ANTES: ' + CAST(@IDADE_OUT AS VARCHAR(2))

EXEC CalcularIdade @IDADE_OUT OUTPUT, @DATA_NASCIMENTO = '1974-01-07';

PRINT 'IDADE DEPOIS: ' + CAST(@IDADE_OUT AS VARCHAR(2))



















































 
  