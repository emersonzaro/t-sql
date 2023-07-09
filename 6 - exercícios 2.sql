
-- Quais cargos possuem média salarial MAIOR que a média do cargo de coordenador de vendas internas.

SELECT F1.Cargo , AVG(F1.Salario)
FROM TB_FUNCIONARIO F1
GROUP BY F1.Cargo
HAVING AVG(F1.Salario) > (SELECT AVG(F2.Salario) FROM TB_FUNCIONARIO F2
							WHERE F2.Cargo = 'coordenador de vendas internas'



-- Qual produto teve mais vendas em Julho de 1996

SELECT
	C1.Descricao,
	C1.Quantidade
	FROM
	(
		SELECT TOP 5 PR.Descricao,  SUM(D.Quantidade) Quantidade FROM TB_PRODUTO PR
			JOIN TB_DETALHE_PEDIDO D ON PR.ProdutoId = D.ProdutoId
		WHERE D.NumeroPedido IN (
				SELECT PE.NumeroPedido FROM TB_PEDIDO PE
				WHERE PE.DataPedido BETWEEN '1996-07-01' AND '1996-07-31')
			GROUP BY PR.Descricao
			ORDER BY SUM(D.Quantidade) DESC
	
	) AS C1