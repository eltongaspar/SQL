SELECT 
	rtrim(ltrim(SD1.D1_FILIAL))									as filial, 
		
		SF1.F1_FILIAL + 
		SF1.F1_PREFIXO + 
		SF1.F1_DOC + 
		SF1.F1_FORNECE + 
		SF1.F1_LOJA AS chave_titulo,
		
	rtrim(ltrim(SD1.D1_FILIAL)) + '_' +
	rtrim(ltrim(SD1.D1_DOC)) + '_' + rtrim(ltrim(SA2.A2_COD))	as cenario, 
	rtrim(ltrim(SF1.F1_ESPECIE))								as especie_nota,
	rtrim(ltrim(SB1.B1_COD))									as codigo_produto, 
	rtrim(ltrim(SB1.B1_POSIPI))									as ncm_produto, 
	rtrim(ltrim(SB1.B1_DESC))									as descricao_produto,
	rtrim(ltrim(SA2.A2_CGC))									as cnpj_fornecedor, 
	rtrim(ltrim(SA2.A2_NOME))									as nome_fornecedor,
	SUM(SD1.D1_QUANT * SD1.D1_VUNIT)							as total_valor,
	COUNT(*)													as qtd_documento

FROM SD1010  SD1 WITH (NOLOCK) 

INNER JOIN SF4010  SF4 WITH (NOLOCK)
			ON ''				= SF4.F4_FILIAL
			AND SD1.D1_TES		= SF4.F4_CODIGO
			AND SD1.D_E_L_E_T_	= SF4.D_E_L_E_T_

INNER JOIN SF1010 SF1 WITH (NOLOCK)
			ON SD1.D1_FILIAL	= SF1.F1_FILIAL
			AND SD1.D1_DOC		= SF1.F1_DOC
			AND SD1.D1_SERIE	= SF1.F1_SERIE
			AND SD1.D1_FORNECE	= SF1.F1_FORNECE
			AND SD1.D1_LOJA		= SF1.F1_LOJA
			AND SD1.D1_TIPO		= SF1.F1_TIPO
			AND SF1.R_E_C_N_O_	= SF1.R_E_C_N_O_
			AND SD1.D_E_L_E_T_	= SF1.D_E_L_E_T_

INNER JOIN SB1010 SB1 WITH (NOLOCK)
			ON ''				= SB1.B1_FILIAL
			AND SD1.D1_COD		= SB1.B1_COD
			AND SD1.D_E_L_E_T_	= SB1.D_E_L_E_T_

INNER JOIN SA2010 SA2 WITH (NOLOCK)
			ON ''				= SA2.A2_FILIAL
			AND SD1.D1_FORNECE	= SA2.A2_COD
			AND SD1.D1_LOJA		= SA2.A2_LOJA
			AND SD1.D_E_L_E_T_	= SA2.D_E_L_E_T_

WHERE 
		SF1.F1_CHVNFE       = '35240851254159000173550010011491481638665622'
		AND SF4.F4_DUPLIC	= 'S'
		AND SD1.D_E_L_E_T_	= ''

GROUP BY  
	SD1.D1_FILIAL, 
	rtrim(ltrim(SD1.D1_FILIAL)) + '_' + + rtrim(ltrim(SD1.D1_DOC)) + '_' + rtrim(ltrim(SA2.A2_COD)),
	SF1.F1_ESPECIE,
	SD1.D1_DOC, 
	SB1.B1_COD, 
	SB1.B1_POSIPI, 
	SB1.B1_DESC, 
	SA2.A2_CGC, 
	SA2.A2_NOME,
	SF1.F1_FILIAL,
	SF1.F1_PREFIXO, 
	SF1.F1_DOC, 
	SF1.F1_FORNECE, 
	SF1.F1_LOJA
