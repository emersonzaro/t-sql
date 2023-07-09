
SELECT  C2.NomeCompleto,
		C2.Cargo,
		C2.[M�s e Ano],
		C2.[Somat�ria da Quantidade],
		C2.[Somat�ria do Pre�o],
		C2.[Valor Total],
		CASE
			WHEN C2.[Valor Total] >= 5000 
				THEN 'META ATINGIDA'
			ELSE
				'N�O BATEU A META'
		END AS 'Status
		'
FROM
	(SELECT C.NomeCompleto,
			C.Cargo,
			C1.[M�s e Ano],
			C1.[Somat�ria da Quantidade],
			C1.[Somat�ria do Pre�o],
			C1.[Valor Total]
	FROM

	(SELECT  P.ClienteId, 
			SUBSTRING(CONVERT(VARCHAR, P.DataPedido, 120), 1, 7) 'M�s e Ano',
			SUM(D.Quantidade)  'Somat�ria da Quantidade',
			SUM(D.Preco) 'Somat�ria do Pre�o', 
			SUM(D.Quantidade * D.Preco) 'Valor Total'
			FROM TB_DETALHE_PEDIDO D
	JOIN TB_PEDIDO P ON D.NumeroPedido = P.NumeroPedido
	GROUP BY P.ClienteId, SUBSTRING(CONVERT(VARCHAR, P.DataPedido, 120), 1, 7)) 
	AS C1

	JOIN TB_CLIENTE C ON C1.ClienteId = C.ClienteId) AS C2
	--ORDER BY P.ClienteId