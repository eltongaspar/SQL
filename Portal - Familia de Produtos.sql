SELECT 
		PEDIDO,
		PRODUTO,
		FAMILIA_PRODUTO,
		BITOLA_PRODUTO,
		PRECO_TABELA,
		PRECO_SUGERIDO,
		PRECO_APROVADO,
		DIF_SUG_APROVADO,
		RG_SUGERIDO,
		RG_APROVADO,
		TOTAL_SUGERIDO,
		TOTAL_APROVADO,
		PESO_COBRE,
		ZP9_TOTAL												AS QTD_VENDIDA,
		SB1.PESO_COBRE * ZP9_TOTAL								AS TOTAL_COBRE  
	FROM
	(
				SELECT 
				ZP6.ZP6_NUM + (ZP6.ZP6_NOME + ZP6.ZP6_BITOLA)	AS CHAVE,
				'  + cPedido +  '								AS PEDIDO, 
				(ZP6.ZP6_NOME + ZP6.ZP6_BITOLA)					AS PRODUTO,
				SZ1.Z1_DESC										AS FAMILIA_PRODUTO,  
				SZ2.Z2_DESC										AS BITOLA_PRODUTO,  
				SUM(ZP6.ZP6_PRCTAB)								AS PRECO_TABELA,  
				SUM(ZP6.ZP6_PRCSUG)								AS PRECO_SUGERIDO,  
				SUM(ZP6.ZP6_PRCAPR)								AS PRECO_APROVADO,  
				SUM(ZP6.ZP6_QTACON)								AS ZP6_QTACON,
				SUM(ZP6.ZP6_PRCSUG) - SUM(ZP6_PRCAPR)			AS DIF_SUG_APROVADO,
				CASE  
				 WHEN SUM(ZP6.ZP6_TOTSUG) > 0  
				 THEN  
					((SUM(ZP6.ZP6_TOTSUG * 100) /  SUM(((ZP6.ZP6_TOTSUG * 100) / (ZP6.ZP6_RGSUG + 100)))  ) - 100)  
				  ELSE 0  
				 END AS RG_SUGERIDO,  
				   CASE  
					 WHEN SUM(ZP6.ZP6_TOTAPR) > 0  
					 THEN 
						((SUM(ZP6.ZP6_TOTAPR * 100) /  SUM(((ZP6.ZP6_TOTAPR * 100) / (ZP6.ZP6_RGAPR + 100)))  ) - 100)   
				   ELSE 0  
				END AS RG_APROVADO,
				SUM(ZP6.ZP6_TOTSUG)							AS TOTAL_SUGERIDO,  
				SUM(ZP6.ZP6_TOTAPR)							AS TOTAL_APROVADO

			FROM ZP6010 ZP6

			INNER JOIN SZ1010 SZ1 
				ON	''				= SZ1.Z1_FILIAL 
				AND ZP6.ZP6_NOME	= SZ1.Z1_COD 
				AND ZP6.D_E_L_E_T_	= SZ1.D_E_L_E_T_  
			INNER JOIN SZ2010 SZ2 
				ON	''				= SZ2.Z2_FILIAL 
				AND ZP6.ZP6_BITOLA	= SZ2.Z2_COD 
				AND ZP6.D_E_L_E_T_	= SZ2.D_E_L_E_T_  
			WHERE 
				ZP6.ZP6_NUM IN ('358260')
				AND ZP6.D_E_L_E_T_ = ''
			GROUP BY ZP6.ZP6_NUM, (ZP6_NOME + ZP6.ZP6_BITOLA), SZ1.Z1_DESC, SZ2.Z2_DESC
	) AS ZP6
		INNER JOIN
	(
		SELECT 
		ZP9.ZP9_NUM + SUBSTRING(ZP9_CODPRO, 1,5)	AS CHAVE,
		SUM(ZP9_QUANT * ZP6.ZP6_QTACON)			    AS ZP9_TOTAL
		FROM ZP9010 ZP9
		INNER JOIN ZP6010 ZP6
			ON ZP9.ZP9_FILIAL = ZP6.ZP6_FILIAL
			AND ZP9.ZP9_NUM    = ZP6.ZP6_NUM
			AND ZP9.ZP9_ITEM   = ZP6.ZP6_ITEM
			AND ZP9.D_E_L_E_T_ = ZP6.D_E_L_E_T_
		WHERE
		ZP9.D_E_L_E_T_ = ''
		GROUP BY ZP9.ZP9_NUM, SUBSTRING(ZP9_CODPRO, 1,5)
	) AS ZP9
	ON ZP6.CHAVE = ZP9.CHAVE
	INNER JOIN 
	(
		SELECT 
			LEFT(SB1.B1_COD, 5) AS CHAVE,
			AVG(SB1.B1_PESCOB)  AS PESO_COBRE
		FROM SB1010  SB1 WITH(NOLOCK)
		WHERE 
			'' = SB1.B1_FILIAL
			AND SB1.B1_TIPO		= 'PA'
			AND SB1.B1_PESCOB   > 0
			AND SB1.D_E_L_E_T_	= ''
		GROUP BY LEFT(SB1.B1_COD, 5)
	) SB1
	ON ZP6.PRODUTO = SB1.CHAVE
