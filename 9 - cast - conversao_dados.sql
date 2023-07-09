
--CAST
--CONVERT

SELECT CAST(GETDATE() AS varchar)
SELECT GETDATE()

SELECT CONVERT(VARCHAR, GETDATE(), 102)

SELECT CONVERT(DECIMAL(10, 2), '3456.44556666')

SELECT CONVERT(BIGINT, '3456454454566777')


SELECT 
	'Produto - '+ P.Descricao + ', tem o pre�o de ' + CONVERT(VARCHAR, (D.Preco))
	FROM TB_PRODUTO P
		JOIN TB_DETALHE_PEDIDO D 
	ON P.ProdutoId = D.ProdutoId











