
-- Traga a descrição dos produtos que possuem o preço maior que a média de todos os produtos

SELECT P.Descricao FROM TB_PRODUTO P
WHERE P.Preco > (SELECT AVG(P2.Preco) FROM TB_PRODUTO P2)


-- Traga todos os clientes que possuem pedidos no mês 07 de 1996

SELECT C.* FROM TB_CLIENTE C
WHERE EXISTS (SELECT * FROM TB_PEDIDO P
				WHERE C.ClienteId = P.ClienteId
				AND P.DataPedido BETWEEN '1996-07-01' AND '1996-07-31')


-- Traga o nome e o total de pedidos de cada cliente

SELECT C.NomeCompleto, 
	(SELECT COUNT(*) FROM TB_PEDIDO P WHERE P.ClienteId = C.ClienteId) [TOTAL PEDIDOS]
FROM TB_CLIENTE C
ORDER BY [TOTAL PEDIDOS] 


-- Update e Delete com subqueries

UPDATE TB_PRODUTO
SET Preco -= 7
WHERE CategoriaId = (SELECT CategoriaId FROM TB_CATEGORIA 
						WHERE Descricao = 'Bebidas')

SELECT preco FROM TB_PRODUTO
WHERE CategoriaId = (SELECT CategoriaId FROM TB_CATEGORIA 
						WHERE Descricao = 'Bebidas')

DELETE FROM TB_PEDIDO
WHERE FuncionarioId = (SELECT FuncionarioId FROM TB_FUNCIONARIO
						WHERE Cargo = 'Vice-Presidente de Vendas')
						AND NumeroPedido = '10277' 
