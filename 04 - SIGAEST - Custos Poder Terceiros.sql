SELECT	SSB6.B6_FILIAL, 
		SSB6.B6_PRODUTO, 
		SSB6.B6_CLIFOR, 
		SSB6.B6_LOJA, 
		SSB6.B6_IDENT, 
		SSB6.B6_TIPO,
		ROUND(SUM(SSB6.QTD_DEV)  , 6)		AS QTD_DEV, 
		ROUND(SUM(SSB6.QTD_REM)	   , 6)		AS QTD_REM, 
		ROUND(SUM(SSB6.QTD_DEV) - SUM(SSB6.QTD_REM),6) AS QTD_SALDO,
		ROUND(SUM(SSB6.CUSTO_DEV), 6)		AS CUSTO_DEV, 
		ROUND(SUM(SSB6.CUSTO_REM)  , 6)		AS CUSTO_REM, 
		ROUND(SUM(SSB6.CUSTO_DEV) - SUM(SSB6.CUSTO_REM),6) AS CUSTO_DIFERENCA, 
		ROUND(SUM(SSB6.CUSTO_M_DEV), 6)		AS CUSTO_M_DEV,
		ROUND(SUM(SSB6.CUSTO_M_REM), 6)		AS CUSTO_M_REM,
		ROUND(SUM(SSB6.CUSTO_M_DEV)-SUM(SSB6.CUSTO_M_REM),4) AS CUSTO_M_DIFERENCA
FROM 
(
	--EM TERCEIROS 
	SELECT	SB6_EM3.B6_FILIAL,
			SB6_EM3.B6_PRODUTO,
			SB6_EM3.B6_CLIFOR, 
			SB6_EM3.B6_LOJA, 
			SB6_EM3.B6_IDENT,
			CASE 
				WHEN SB6_EM3.B6_TIPO = 'E' THEN 'EM TERCEIROS'
				WHEN SB6_EM3.B6_TIPO = 'D' THEN 'DE TERCEIROS'
			END AS B6_TIPO,
			ROUND(SUM(SB6_EM3.QTD_DEVOLVIDA)  , 6)		AS QTD_DEV, 
			ROUND(SUM(SB6_EM3.QTD_REMESSA)	   , 6)		AS QTD_REM, 
			ROUND(SUM(SB6_EM3.QTD_DEVOLVIDA) - SUM(SB6_EM3.QTD_REMESSA),6) AS QTD_SALDO,
			ROUND(SUM(SB6_EM3.CUSTO_DEVOLVIDO), 6)		AS CUSTO_DEV, 
			ROUND(SUM(SB6_EM3.CUSTO_REMESSA)  , 6)		AS CUSTO_REM, 
			ROUND(SUM(SB6_EM3.CUSTO_DEVOLVIDO) - SUM(SB6_EM3.CUSTO_REMESSA),6) AS CUSTO_SALDO, 
			ROUND(SUM(SB6_EM3.CUSTO_MED_DEVOL), 6)		AS CUSTO_M_DEV,
			ROUND(SUM(SB6_EM3.CUSTO_MED_REMESSA), 6)	AS CUSTO_M_REM,
			ROUND(SUM(SB6_EM3.CUSTO_MED_DEVOL)-SUM(SB6_EM3.CUSTO_MED_REMESSA),4) AS CUSTO_M_SALDO
	FROM	
		(	
			--DEVOLUCAO EM TERCEIROS (B6_TIPO = 'E' , B6_PODER3 = 'D')
			SELECT	B6_FILIAL,
					B6_PRODUTO,
					B6_CLIFOR, 
					B6_LOJA, 
					B6_IDENT , 
					B6_PODER3,
					B6_TIPO,
					ROUND(SUM(B6_QUANT),6)	AS QTD_DEVOLVIDA, 
					' '						AS QTD_REMESSA, 
					ROUND(SUM(B6_CUSTO1),6)	AS CUSTO_DEVOLVIDO, 
					' '						AS CUSTO_REMESSA, 
					ROUND((SUM(B6_CUSTO1)/SUM(B6_QUANT)),4) AS CUSTO_MED_DEVOL,
					' '						AS CUSTO_MED_REMESSA
			FROM SB6010 SB6 
			WHERE SB6.D_E_L_E_T_ = ''
					AND B6_FILIAL = '01'
					AND B6_PODER3 = 'D'
					AND B6_TIPO	  = 'E'
					AND B6_DTDIGIT BETWEEN '20230901' AND '20230930'
			GROUP BY B6_FILIAL, B6_PRODUTO, B6_CLIFOR, B6_LOJA, B6_IDENT, B6_PODER3, B6_TIPO
		
			UNION
		
			--REMESSA EM TERCEIROS (B6_TIPO = 'E' , B6_PODER3 = 'R')
			SELECT	B6_FILIAL,
					B6_PRODUTO,
					B6_CLIFOR, 
					B6_LOJA, 
					B6_IDENT, 
					B6_PODER3 ,
					B6_TIPO,
					' '						AS QTD_DEVOLVIDA, 
					ROUND(SUM(B6_QUANT),6)	AS QTD_REMESSA, 
					' '						AS CUSTO_DEVOLVDO, 
					ROUND(SUM(B6_CUSTO1),6)	AS CUSTO_REMESSA, 
					' '						AS CUSTO_MED_DEVOL,
					ROUND((SUM(B6_CUSTO1)/SUM(B6_QUANT)),4) AS CUSTO_MED_REMESSA
			FROM SB6010 SB6 
			WHERE SB6.D_E_L_E_T_ = ''
					AND B6_FILIAL = '01'
					AND B6_PODER3 = 'R'
					AND B6_TIPO	  = 'E'
					AND B6_DTDIGIT BETWEEN '20230901' AND '20230930'
			GROUP BY B6_FILIAL, B6_PRODUTO, B6_CLIFOR, B6_LOJA, B6_IDENT, B6_PODER3, B6_TIPO
		) AS SB6_EM3
	GROUP BY SB6_EM3.B6_FILIAL, SB6_EM3.B6_PRODUTO, SB6_EM3.B6_CLIFOR, SB6_EM3.B6_LOJA, SB6_EM3.B6_IDENT, SB6_EM3.B6_TIPO
		
	UNION
		
	--DE TERCEIROS
	SELECT	SB6_DE3.B6_FILIAL,
			SB6_DE3.B6_PRODUTO,
			SB6_DE3.B6_CLIFOR, 
			SB6_DE3.B6_LOJA, 
			SB6_DE3.B6_IDENT,
			CASE 
				WHEN SB6_DE3.B6_TIPO = 'E' THEN 'EM TERCEIROS'
				WHEN SB6_DE3.B6_TIPO = 'D' THEN 'DE TERCEIROS'
			END AS B6_TIPO,
			ROUND(SUM(SB6_DE3.QTD_DEVOLVIDA)  , 6)		AS QTD_DEV, 
			ROUND(SUM(SB6_DE3.QTD_REMESSA)	   , 6)		AS QTD_REM, 
			ROUND(SUM(SB6_DE3.QTD_REMESSA) - SUM(SB6_DE3.QTD_DEVOLVIDA),6) AS QTD_SALDO,
			ROUND(SUM(SB6_DE3.CUSTO_DEVOLVIDO), 6)		AS CUSTO_DEV, 
			ROUND(SUM(SB6_DE3.CUSTO_REMESSA)  , 6)		AS CUSTO_REM, 
			ROUND(SUM(SB6_DE3.CUSTO_REMESSA) - SUM(SB6_DE3.CUSTO_DEVOLVIDO),6) AS CUSTO_SALDO, 
			ROUND(SUM(SB6_DE3.CUSTO_MED_DEVOL), 6)		AS CUSTO_M_DEV,
			ROUND(SUM(SB6_DE3.CUSTO_MED_REMESSA), 6)	AS CUSTO_M_REM,
			ROUND(SUM(SB6_DE3.CUSTO_MED_REMESSA) - SUM(SB6_DE3.CUSTO_MED_DEVOL),4) AS CUSTO_M_SALDO
	FROM 
		(
			--DEVOLUCAO DE TERCEIROS (B6_TIPO = D, B6_PODER3 = D)
			SELECT	B6_FILIAL,
					B6_PRODUTO,
					B6_CLIFOR, 
					B6_LOJA, 
					B6_IDENT , 
					B6_PODER3,
					B6_TIPO,
					ROUND(SUM(B6_QUANT),6)	AS QTD_DEVOLVIDA, 
					' '						AS QTD_REMESSA, 
					ROUND(SUM(B6_CUSTO1),6)	AS CUSTO_DEVOLVIDO, 
					' '						AS CUSTO_REMESSA, 
					ROUND((SUM(B6_CUSTO1)/SUM(B6_QUANT)),4) AS CUSTO_MED_DEVOL,
					' '						AS CUSTO_MED_REMESSA
			FROM SB6010 SB6 
			WHERE SB6.D_E_L_E_T_ = ''
					AND B6_FILIAL = '01'
					AND B6_PODER3 = 'D'
					AND B6_TIPO	  = 'D'
					AND B6_DTDIGIT BETWEEN '20230901' AND '20230930'
			GROUP BY B6_FILIAL, B6_PRODUTO, B6_CLIFOR, B6_LOJA, B6_IDENT, B6_PODER3, B6_TIPO
		
			UNION
		
			--REMESSA DE TERCEIROS (B6_TIPO = D, B6_PODER3 = R)
			SELECT	B6_FILIAL,
					B6_PRODUTO,
					B6_CLIFOR, 
					B6_LOJA, 
					B6_IDENT, 
					B6_PODER3 ,
					B6_TIPO,
					' '						AS QTD_DEVOLVIDA, 
					ROUND(SUM(B6_QUANT),6)	AS QTD_REMESSA, 
					' '						AS CUSTO_DEVOLVDO, 
					ROUND(SUM(B6_CUSTO1),6)	AS CUSTO_REMESSA, 
					' '						AS CUSTO_MED_DEVOL,
					ROUND((SUM(B6_CUSTO1)/SUM(B6_QUANT)),4) AS CUSTO_MED_REMESSA
			FROM SB6010 SB6 
			WHERE SB6.D_E_L_E_T_ = ''
					AND B6_FILIAL = '01'
					AND B6_PODER3 = 'R'
					AND B6_TIPO	  = 'D'
					AND B6_DTDIGIT BETWEEN '20230901' AND '20230930'
			GROUP BY B6_FILIAL, B6_PRODUTO, B6_CLIFOR, B6_LOJA, B6_IDENT, B6_PODER3, B6_TIPO
	) AS SB6_DE3
	GROUP BY SB6_DE3.B6_FILIAL, SB6_DE3.B6_PRODUTO, SB6_DE3.B6_CLIFOR, SB6_DE3.B6_LOJA, SB6_DE3.B6_IDENT, SB6_DE3.B6_TIPO
) SSB6
GROUP BY SSB6.B6_FILIAL, SSB6.B6_PRODUTO , SSB6.B6_CLIFOR , SSB6.B6_LOJA , SSB6.B6_LOJA , SSB6.B6_IDENT , SSB6.B6_TIPO
ORDER BY SSB6.B6_FILIAL, SSB6.B6_PRODUTO, SSB6.B6_CLIFOR , SSB6.B6_LOJA, SSB6.B6_IDENT, SSB6.B6_TIPO

