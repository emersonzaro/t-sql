
SELECT  C1.Categoria,
		C1.Ano,
		CONVERT(DECIMAL(15, 2),C1.Faturamento) AS 'Faturamento',
		--C2.Faturamento AS 'Faturamento Total',
		(C1.Faturamento/C2.Faturamento) * 100 AS 'Percentual (%)'	
FROM 
(SELECT CA.Descricao 'Categoria',
		YEAR(PE.DataPedido) AS 'Ano',
		SUM(DE.Quantidade * DE.Preco) AS 'Faturamento'
	FROM TB_DETALHE_PEDIDO DE
	JOIN TB_PRODUTO PR
		ON DE.ProdutoId = PR.ProdutoId
	JOIN TB_CATEGORIA CA
		ON PR.CategoriaId = CA.CategoriaId
	JOIN TB_PEDIDO PE
		ON PE.NumeroPedido = DE.NumeroPedido
	WHERE YEAR(PE.DataPedido) = 1996
	GROUP BY CA.Descricao, YEAR(PE.DataPedido))
	AS C1
INNER JOIN
-- FATURAMENTO TOTAL DE 1996
(SELECT	YEAR(PE.DataPedido) AS 'Ano',
		SUM(DE.Quantidade * DE.Preco) AS 'Faturamento'
	FROM TB_DETALHE_PEDIDO DE
	JOIN TB_PRODUTO PR
		ON DE.ProdutoId = PR.ProdutoId
	JOIN TB_CATEGORIA CA
		ON PR.CategoriaId = CA.CategoriaId
	JOIN TB_PEDIDO PE
		ON PE.NumeroPedido = DE.NumeroPedido
	WHERE YEAR(PE.DataPedido) = 1996
	GROUP BY YEAR(PE.DataPedido))
AS C2 ON C1.Ano = C2.Ano
ORDER BY C1.Faturamento DESC

