
-- Operadores Relacionais e Between

 SELECT * FROM TB_FUNCIONARIO
 -- WHERE Salario <= 5000
 WHERE Salario BETWEEN 5000 AND 9000



 -- IN, NOT IN, E NULL

 SELECT * FROM TB_ENDERECO
 --WHERE Pais NOT IN ('EUA', 'SUÉCIA')
 WHERE Regiao IS NOT NULL

 SELECT Logradouro, Cidade, Pais, ISNULL (Regiao, 'N/C') FROM TB_ENDERECO
 WHERE Regiao IS NULL


 -- ASSOCIAR TABELAS UNION

 SELECT NomeCompleto AS Empresa, Contato, Cargo FROM TB_CLIENTE
 UNION
 SELECT Empresa, Contato, Cargo  FROM TB_FORNECEDOR


 SELECT Pais, 'CLIENTE'  FROM TB_ENDERECO
 WHERE ClienteId IS NOT NULL
 UNION ALL -- com all retorna todos os registros duplicados
 SELECT Pais, 'FORNECEDOR' FROM TB_ENDERECO
 WHERE FornecedorId IS NOT NULL


-- group by e funções de agregação

SELECT NumeroPedido, SUM(Preco) FROM TB_DETALHE_PEDIDO
GROUP BY NumeroPedido

SELECT NumeroPedido, MAX(Preco) FROM TB_DETALHE_PEDIDO
GROUP BY NumeroPedido

SELECT NumeroPedido, COUNT(*) FROM TB_DETALHE_PEDIDO
WHERE NumeroPedido IN (10248, 10249, 10250, 10251)
GROUP BY NumeroPedido 
HAVING COUNT(*) = 3


-- Itens Duplicados

SELECT NomeCompleto, COUNT(NomeCompleto) FROM TB_CLIENTE
GROUP BY NomeCompleto
HAVING COUNT(NomeCompleto) > 1

SELECT * FROM TB_CLIENTE
WHERE NomeCompleto = 'MARCOS ALBERTO'

DELETE TB_CLIENTE
WHERE ClienteId = 'OPOPO'


INSERT INTO TB_CLIENTE
(ClienteId, NomeCompleto, Contato, Cargo)
VALUES
('OPOPO','MARCOS ALBERTO','MARIA JOAQUINA','VENDEDOR')





































