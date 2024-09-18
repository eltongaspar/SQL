SELECT 
	rtrim(ltrim(SC7.C7_FILIAL))									as filial, 
		
		SC7.C7_FILIAL + 
		SC7.C7_NUM AS chave_titulo,
		
	rtrim(ltrim(SC7.C7_FILIAL)) + '_' +
	rtrim(ltrim(SC7.C7_NUM)) + '_' + rtrim(ltrim(SA2.A2_COD))	as cenario, 
	rtrim(ltrim('PC'))											as especie_nota,
	rtrim(ltrim(SB1.B1_COD))									as codigo_produto, 
	rtrim(ltrim(SB1.B1_POSIPI))									as ncm_produto, 
	rtrim(ltrim(SB1.B1_DESC))									as descricao_produto,
	rtrim(ltrim(SA2.A2_CGC))									as cnpj_fornecedor, 
	rtrim(ltrim(SA2.A2_NOME))									as nome_fornecedor,
	SUM(SC7.C7_QUANT * SC7.C7_PRECO)							as total_valor,
	COUNT(*)													as qtd_documento

FROM SC7010  SC7 WITH (NOLOCK) 


INNER JOIN SB1010 SB1 WITH (NOLOCK)
			ON ''				= SB1.B1_FILIAL
			AND SC7.C7_PRODUTO		= SB1.B1_COD
			AND SC7.D_E_L_E_T_	= SB1.D_E_L_E_T_

INNER JOIN SA2010 SA2 WITH (NOLOCK)
			ON ''				= SA2.A2_FILIAL
			AND SC7.C7_FORNECE	= SA2.A2_COD
			AND SC7.C7_LOJA		= SA2.A2_LOJA
			AND SC7.D_E_L_E_T_	= SA2.D_E_L_E_T_

WHERE 
		rtrim(ltrim(SC7.C7_FILIAL))+rtrim(ltrim(SC7.C7_NUM ))      = '01009743'
		--AND SF4.F4_DUPLIC	= 'S'
		AND SC7.D_E_L_E_T_	= ''

GROUP BY  
	SC7.C7_FILIAL, 
	rtrim(ltrim(SC7.C7_FILIAL)) + '_' + + rtrim(ltrim(SC7.C7_NUM)) + '_' + rtrim(ltrim(SA2.A2_COD)),
	SC7.C7_NUM, 
	SB1.B1_COD, 
	SB1.B1_POSIPI, 
	SB1.B1_DESC, 
	SA2.A2_CGC, 
	SA2.A2_NOME,
	SC7.C7_FILIAL,
	SC7.C7_FORNECE, 
	SC7.C7_LOJA
