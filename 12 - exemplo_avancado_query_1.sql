
SELECT  C2.NomeCompleto,
		C2.Cargo,
		C2.[Mês e Ano],
		C2.[Somatória da Quantidade],
		C2.[Somatória do Preço],
		C2.[Valor Total],
		CASE
			WHEN C2.[Valor Total] >= 5000 
				THEN 'META ATINGIDA'
			ELSE
				'NÃO BATEU A META'
		END AS 'Status
		'
FROM
	(SELECT C.NomeCompleto,
			C.Cargo,
			C1.[Mês e Ano],
			C1.[Somatória da Quantidade],
			C1.[Somatória do Preço],
			C1.[Valor Total]
	FROM

	(SELECT  P.ClienteId, 
			SUBSTRING(CONVERT(VARCHAR, P.DataPedido, 120), 1, 7) 'Mês e Ano',
			SUM(D.Quantidade)  'Somatória da Quantidade',
			SUM(D.Preco) 'Somatória do Preço', 
			SUM(D.Quantidade * D.Preco) 'Valor Total'
			FROM TB_DETALHE_PEDIDO D
	JOIN TB_PEDIDO P ON D.NumeroPedido = P.NumeroPedido
	GROUP BY P.ClienteId, SUBSTRING(CONVERT(VARCHAR, P.DataPedido, 120), 1, 7)) 
	AS C1

	JOIN TB_CLIENTE C ON C1.ClienteId = C.ClienteId) AS C2
	--ORDER BY P.ClienteId