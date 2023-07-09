
-- IIF CHOOSE


SELECT NomeCompleto, IIF(Salario >= 5000, 'PADRÃO', 'FORA DO PADRÃO' ) FROM TB_FUNCIONARIO

SELECT CHOOSE(3, 'PRIMEITO', 'SEGUNDO', 'TERCEIRO', 'QUARTO')


-- LAG LEAD

SELECT  NomeCompleto,
		Salario,
		LAG(Salario, 1,0) OVER(ORDER BY NomeCompleto) SALARIO_ANTERIOR,
		LEAD(Salario, 1,0) OVER(ORDER BY NomeCompleto) PROXIMO_SALARIO
FROM TB_FUNCIONARIO

SELECT  NomeCompleto,Salario FROM TB_FUNCIONARIO
ORDER BY NomeCompleto


-- FETCH  OFFSET

SELECT * FROM TB_PEDIDO
ORDER BY NumeroPedido
OFFSET 12 ROWS FETCH NEXT 20 ROWS ONLY


-- MERGE

 CREATE TABLE dbo.TB_FUNCIONARIO_TEMP
 (
	FuncionarioID INT NOT NULL PRIMARY KEY,
	NomeCompleto VARCHAR(70) NOT NULL,
	Cargo VARCHAR(50) NOT NULL,
	DataNascimento DATETIME2(7) NOT NULL,
	Salario MONEY NOT NULL,
 );

 INSERT INTO dbo.TB_FUNCIONARIO_TEMP (FuncionarioID, NomeCompleto, Cargo, DataNascimento, Salario)
 SELECT FuncionarioID, NomeCompleto, Cargo, DataNascimento, Salario FROM TB_FUNCIONARIO

 DELETE dbo.TB_FUNCIONARIO_TEMP WHERE FuncionarioID IN (1,2,3);

 UPDATE dbo.TB_FUNCIONARIO_TEMP SET Salario = 500 WHERE FuncionarioID IN (9,8,7);

 SELECT * FROM TB_FUNCIONARIO_TEMP
 SELECT * FROM TB_FUNCIONARIO

-- SET IDENTITY_INSERT dbo.TB_FUNCIONARCIO_TEMP ON;
MERGE dbo.TB_FUNCIONARIO_TEMP AS ALVO
USING TB_FUNCIONARIO AS ORIGEM
	ON ALVO.FuncionarioId = ORIGEM.FuncionarioId
WHEN MATCHED AND ALVO.Salario <> ORIGEM.Salario
	THEN UPDATE SET ALVO.Salario = ORIGEM.Salario
WHEN NOT MATCHED
	THEN
		INSERT (FuncionarioID, NomeCompleto, Cargo, DataNascimento, Salario)
		VALUES (FuncionarioID, NomeCompleto, Cargo, DataNascimento, Salario);

-- SET IDENTITY_INSERT dbo.TB_FUNCIONARCIO_TEMP OFF;


-- PIVOT / UNPIVOT

SELECT  NumeroPedido,
		MONTH(DataPedido) AS MES,				
		SUM(Frete) AS TOTAL_FRETE
FROM TB_PEDIDO
WHERE YEAR(DataPedido) = 1998
GROUP BY NumeroPedido, MONTH(DataPedido), YEAR(DataPedido)
ORDER BY 1,2,3

SELECT NumeroPedido, ISNULL([1],0) AS 'MÊS 1', ISNULL([2],0) AS 'MÊS 2', ISNULL([3],0) AS 'MÊS 3', ISNULL([4],0) AS 'MÊS 4',
		ISNULL([5],0) AS 'MÊS 5', ISNULL([6],0) AS 'MÊS 6', ISNULL([7],0) AS 'MÊS 7', ISNULL([8],0) AS 'MÊS 8',
		ISNULL([9],0) AS 'MÊS 9', ISNULL([10],0) AS 'MÊS 10', ISNULL([11],0) AS 'MÊS 11', ISNULL([12],0) AS 'MÊS 12'
	 FROM (SELECT   NumeroPedido,
					MONTH(DataPedido) AS MES,				
					SUM(Frete) AS TOTAL_FRETE
			 FROM TB_PEDIDO
			 WHERE YEAR(DataPedido) = 1998
			 GROUP BY NumeroPedido, MONTH(DataPedido)) P

	 PIVOT (SUM(P.TOTAL_FRETE) FOR P.MES IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])) AS PVT
	 ORDER BY 1
























































