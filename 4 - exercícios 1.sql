
-- Qual produto teve maior quantidade de vendas no mês 7 de 1996

SELECT TOP 5 PR.Descricao, SUM(D.Quantidade) TOTAL FROM TB_PRODUTO PR
JOIN TB_DETALHE_PEDIDO D ON PR.ProdutoId = D.ProdutoId
JOIN TB_PEDIDO P ON D.NumeroPedido = P.NumeroPedido
WHERE P.DataPedido BETWEEN '1996-07-01' AND '1996-07-31'
GROUP BY PR.Descricao
ORDER BY SUM(D.Quantidade) DESC


-- Qual cliente teve o maior gasto no mês 7 de 1996

SELECT TOP 5 C.NomeCompleto, SUM(D.Preco) TOTAL FROM TB_CLIENTE C
JOIN TB_PEDIDO P ON C.ClienteId = P.ClienteId
JOIN TB_DETALHE_PEDIDO D ON P.NumeroPedido = D.NumeroPedido
WHERE P.DataPedido BETWEEN '1996-07-01' AND '1996-07-31'
GROUP BY C.NomeCompleto
ORDER BY SUM(D.Preco) DESC


-- Listar todos os clientes que moram na Alemanha

SELECT C.NomeCompleto, E.Pais  FROM TB_CLIENTE C
JOIN TB_ENDERECO E ON C.ClienteId = E.ClienteId
WHERE E.Pais = 'ALEMANHA'


-- Listar todos os clientes que compraram produtos da categoria 'bebida'

SELECT C.NomeCompleto, CA.Descricao FROM TB_CLIENTE C
JOIN TB_PEDIDO P ON C.ClienteId = P.ClienteId
JOIN TB_DETALHE_PEDIDO D ON P.NumeroPedido = D.NumeroPedido
JOIN TB_PRODUTO PR ON D.ProdutoId = PR.ProdutoId
JOIN TB_CATEGORIA CA ON PR.CategoriaId = CA.CategoriaId
WHERE CA.Descricao = 'Bebidas'












