/*--NF Itens 
Select Distinct D1_COD,B1_DESC,D1_TP,X5_DESCRI,
F1_FORNECE,F1_LOJA,
F1_DOC,F1_SERIE,
E2_NUM,E2_PARCELA, E4_COND,
DATEPART(MONTH, D1_EMISSAO) As MES,DATEPART(YEAR, D1_EMISSAO) As Ano,
DATEPART(MONTH, SE2.E2_VENCTO) As MES_Fin,DATEPART(YEAR, SE2.E2_VENCTO) As Ano_Fin,
FORMAT(SUM(E2_VALOR),'#,0.0000', 'pt-BR') AS Valor_Titulo,
FORMAT(SUM(F1_VALBRUT),'#,0.0000', 'pt-BR') AS Val_NF,
E2_CCUSTO,D1_CC,E2_NATUREZ,ED_DESCRIC,CTT.CTT_DESC01,C7_CC,CTTSC7.CTT_DESC01
Sum(E2_VALOR) As Valor_Titulo,  
Sum(F1_VALBRUT) As Val_NF,
STUFF((
        SELECT ',' + D1_COD
        FROM SD1010 SD1_Inner
        WHERE SD1_Inner.D1_COD = SD1.D1_COD
        FOR XML PATH(''), TYPE
    ).value('.', 'NVARCHAR(MAX)'), 1, 1, '') AS Codigos

From SD1010 SD1

	Inner Join SB1010 SB1
	On B1_COD = D1_COD
	And SB1.D_E_L_E_T_ =''

	Inner Join SX5010 SX5
	On X5_TABELA = '02' 
	And X5_CHAVE = B1_TIPO
	And SX5.D_E_L_E_T_ = ''

	Inner Join SF1010 SF1
	On F1_FILIAL = D1_FILIAL
	And F1_DOC = D1_DOC
	And F1_LOJA = D1_LOJA
	And F1_FORNECE = D1_FORNECE
	And F1_LOJA = D1_LOJA
	And SF1.D_E_L_E_T_ =''	
	
	Left Join SE2010 SE2
	On SE2.E2_FILIAL = F1_FILIAL
	And SE2.E2_FORNECE = F1_FORNECE
	And SE2.E2_LOJA = F1_LOJA
	And SE2.E2_NUM = F1_DOC 
	And SE2.E2_TIPO = 'NF'
	And SE2.D_E_L_E_T_ =''	

	Inner Join SE4010 SE4
	On E4_CODIGO = F1_COND
	And SE4.D_E_L_E_T_ =''	

	Inner Join SED010 SED -- Natureza Financeira
	On ED_FILIAL = ''
	And ED_CODIGO = E2_NATUREZ
	And SED.D_E_L_E_T_ = ''

	Inner Join CTT010 CTT -- Centro de custo
	On CTT_FILIAL = ''
	And CTT_CUSTO = D1_CC
	And CTT.D_E_L_E_T_ = ''

	Left Join SC7010 SC7 -- PC
	On D1_FILIAL = C7_FILIAL
	And D1_FORNECE = C7_FORNECE
	And D1_LOJA = C7_LOJA
	And D1_COD = C7_PRODUTO
	And D1_PEDIDO = C7_NUM
	And D1_ITEMPC = C7_ITEM
	And SC7.D_E_L_E_T_ = ''

	Inner Join CTT010 CTTSC7 -- Centro de custo
	On CTTSC7.CTT_FILIAL = ''
	And CTTSC7.CTT_CUSTO = C7_CC
	And CTTSC7.D_E_L_E_T_ = ''
	
Where (E2_CCUSTO In ('100112') or D1_CC In ('100112'))
--And F1_DOC = '000000175' and F1_SERIE = '0'
--And F1_FORNECE = 'VOOZOK'
And SD1.D_E_L_E_T_ = ''
Group By 
D1_COD,B1_DESC,D1_TP,X5_DESCRI,
F1_FORNECE,F1_LOJA,
F1_DOC,F1_SERIE,
E2_VALOR,F1_VALBRUT,
E2_NUM,E2_PARCELA, E4_COND,
E2_NUM,E4_COND,
--DATEPART(MONTH, D1_EMISSAO),DATEPART(YEAR, D1_EMISSAO),--E2_VALOR
DATEPART(MONTH, SE2.E2_VENCTO),DATEPART(YEAR, SE2.E2_VENCTO),
E2_CCUSTO,D1_CC,E2_NATUREZ,ED_DESCRIC,CTT.CTT_DESC01,
C7_CC,CTTSC7.CTT_DESC01
Order By 19*/


-- NF Itens
SELECT DISTINCT 
	--F1_FILIAL+F1_FORNECE+F1_LOJA+F1_DOC+F1_SERIE+D1_ITEM,
	--D1_FILIAL,
	--E2_VENCTO,
    --D1_COD,
    --B1_DESC,
    --D1_TP,
    --X5_DESCRI,
	Rtrim(Ltrim(Isnull(F1_FILIAL,'')))											 As CH_FORNECEDOR,
	Rtrim(Ltrim(Isnull(F1_FORNECE,''))) + '-' + Rtrim(Ltrim(Isnull(F1_LOJA,''))) As CH_FORNECEDORLOJA,
	Rtrim(Ltrim(Isnull(D1_CC,'')))												 As CH_CC,
	Rtrim(Ltrim(Isnull(E2_NATUREZ,'')))											 As CH_NATUREZAFINANCEIRA,
	Rtrim(Ltrim(Isnull(F1_FILIAL,'')))	+ '-' + Rtrim(Ltrim(Isnull(F1_FORNECE,''))) + '-' + 
	Rtrim(Ltrim(Isnull(F1_LOJA,''))) + '-' + Rtrim(Ltrim(Isnull(F1_DOC,''))) + Rtrim(Ltrim(Isnull(F1_SERIE,'')))
																				As CH_NF,
	Rtrim(Ltrim(Isnull(E2_FILIAL,'')))	+ '-' + Rtrim(Ltrim(Isnull(E2_FORNECE,''))) + '-' + 
	Rtrim(Ltrim(Isnull(E2_LOJA,''))) + '-' + Rtrim(Ltrim(Isnull(E2_NUM,''))) + Rtrim(Ltrim(Isnull(E2_PARCELA,'')))
																				As CH_TITULO,
	


    Rtrim(Ltrim(Isnull(F1_FORNECE,'')))											As FORNECE_CODIGO,
    Rtrim(Ltrim(Isnull(F1_LOJA,'')))											As FORNECE_LOJA,
	Rtrim(Ltrim(Isnull(A2_NOME,'')))											As FORNECE_NOME,
    Rtrim(Ltrim(Isnull(F1_DOC,'')))												As NF_NUMERO,
    Rtrim(Ltrim(Isnull(F1_SERIE,'')))											As NF_SERIE,
	--D1_ITEM,
    Rtrim(Ltrim(Isnull(E2_NUM,'')))												As TITULO_NUMERO,
    Rtrim(Ltrim(Isnull(E2_PARCELA,'')))											As TITULO_PARCELA, 
    Rtrim(Ltrim(Isnull(E4_COND,'')))											As CONDICAO_PAGAMENTO,
   -- DATEPART(MONTH, D1_EMISSAO) AS MES,
    --DATEPART(YEAR, D1_EMISSAO) AS Ano,
    DATEPART(MONTH, SE2.E2_VENCTO)												AS TITULO_MES_VENCTO,
    DATEPART(YEAR, SE2.E2_VENCTO)												AS TITULO_ANO_VENCTO,
	Rtrim(Ltrim(Isnull(E2_VENCTO,'')))											As TITULO_VENCTO,
    Rtrim(Ltrim(Isnull(FORMAT(SUM(E2_VALOR), '#,0.0000', 'pt-BR'),0)))	    	AS TITULO_VALOR,
    Rtrim(Ltrim(Isnull(FORMAT(SUM(F1_VALBRUT), '#,0.0000', 'pt-BR'),0))) 		AS NF_VALOR_TOTAL,
    --E2_CCUSTO,
    Rtrim(Ltrim(Isnull(D1_CC,'')))												AS CENTRO_CUSTO,
    Rtrim(Ltrim(Isnull(E2_NATUREZ,'')))											As NATUREZA_FINANCEIRA_CODIGO,
    Rtrim(Ltrim(Isnull(ED_DESCRIC,'')))											As NATUREZA_FINANCEIRA_DESCRICAO,
    Rtrim(Ltrim(Isnull(CTT.CTT_DESC01,'')))										As CENTRO_CUSTO_DESCRICAO,
    --C7_CC,
   -- CTTSC7.CTT_DESC01,
     STUFF((
        SELECT ',' + CAST(Rtrim(Ltrim(D1_COD)) AS VARCHAR(100))
				  -- + CAST(Rtrim(Ltrim(B1_DESC)) AS VARCHAR(100))
        FROM SD1010 SD1_Inner
        WHERE SD1_Inner.D1_FORNECE = SD1.D1_FORNECE
          AND SD1_Inner.D1_LOJA = SD1.D1_LOJA
          AND SD1_Inner.D1_DOC = SD1.D1_DOC
          AND SD1_Inner.D1_SERIE = SD1.D1_SERIE
          AND SD1_Inner.D_E_L_E_T_ = ''
        FOR XML PATH(''), TYPE
    ).value('/', 'NVARCHAR(MAX)'), 1, 1, '')									AS PRODUTOS_CODIGOS,

	QTDE_TITULOS =   (Select Count(E2_NUM) From SE2010 SE2_FIN
						Where SE2_FIN.E2_FILIAL = SE2.E2_FILIAL
								And SE2_FIN.E2_FORNECE = SE2.E2_FORNECE
								And SE2_FIN.E2_LOJA = SE2.E2_LOJA
								And SE2_FIN.E2_NUM = SE2.E2_NUM
								And SE2_FIN.R_E_C_D_E_L_ = SE2.R_E_C_D_E_L_ 
								And SE2_FIN.D_E_L_E_T_ = ''
								And SE2.D_E_L_E_T_ = ''
					)


	--SD1.R_E_C_N_O_
FROM SD1010 SD1
INNER JOIN SB1010 SB1 ON B1_COD = D1_COD AND SB1.D_E_L_E_T_ = ''
INNER JOIN SX5010 SX5 ON X5_FILIAL = D1_FILIAL And X5_TABELA = '02' AND X5_CHAVE = B1_TIPO AND SX5.D_E_L_E_T_ = ''
INNER JOIN SF1010 SF1 ON F1_FILIAL = D1_FILIAL AND F1_DOC = D1_DOC AND F1_LOJA = D1_LOJA AND F1_FORNECE = F1_FORNECE AND F1_LOJA = D1_LOJA AND SF1.D_E_L_E_T_ = ''
LEFT JOIN SE2010 SE2 ON SE2.E2_FILIAL = F1_FILIAL AND SE2.E2_FORNECE = F1_FORNECE AND SE2.E2_LOJA = F1_LOJA AND SE2.E2_NUM = F1_DOC AND SE2.E2_TIPO = 'NF' AND SE2.D_E_L_E_T_ = ''
INNER JOIN SE4010 SE4 ON E4_CODIGO = F1_COND AND SE4.D_E_L_E_T_ = ''
INNER JOIN SED010 SED ON ED_FILIAL = '' AND ED_CODIGO = E2_NATUREZ AND SED.D_E_L_E_T_ = ''
INNER JOIN CTT010 CTT ON CTT_FILIAL = '' AND CTT_CUSTO = D1_CC AND CTT.D_E_L_E_T_ = ''
LEFT JOIN SC7010 SC7 ON D1_FILIAL = C7_FILIAL AND D1_FORNECE = C7_FORNECE AND D1_LOJA = C7_LOJA AND D1_COD = C7_PRODUTO AND D1_PEDIDO = C7_NUM AND D1_ITEMPC = C7_ITEM AND SC7.D_E_L_E_T_ = ''
INNER JOIN CTT010 CTTSC7 ON CTTSC7.CTT_FILIAL = '' AND CTTSC7.CTT_CUSTO = C7_CC AND CTTSC7.D_E_L_E_T_ = ''
Inner Join SA2010 SA2 On A2_COD = D1_FORNECE And A2_LOJA = D1_LOJA And SA2.D_E_L_E_T_ = ''
WHERE (E2_CCUSTO IN ('100112') OR D1_CC IN ('100112'))
--And F1_FORNECE = 'V009S1' and F1_LOJA = '01' and F1_DOC = '00255566' and F1_SERIE = '005'
And E2_VENCTO Between ('20240801') and ('20240831')
AND SD1.D_E_L_E_T_ = ''
GROUP BY 
	F1_FILIAL,
	--D1_FILIAL,
	--D1_ITEM,
	E2_VENCTO,
    D1_COD,
    --B1_DESC,
    --D1_TP,
    --X5_DESCRI,
    F1_FORNECE,
    F1_LOJA,
    F1_DOC,
    F1_SERIE,
    E2_VALOR,
    F1_VALBRUT,
    E2_NUM,
    E2_PARCELA,
    E4_COND,
	D1_FORNECE,
	D1_LOJA,
	D1_DOC,
	D1_SERIE,
    --DATEPART(MONTH, D1_EMISSAO),
    --DATEPART(YEAR, D1_EMISSAO),
    DATEPART(MONTH, SE2.E2_VENCTO),
    DATEPART(YEAR, SE2.E2_VENCTO),
    --E2_CCUSTO,
    D1_CC,
    E2_NATUREZ,
    ED_DESCRIC,
    CTT.CTT_DESC01,
	A2_NOME,
	E2_FILIAL,
	E2_FORNECE,
	E2_LOJA,
	E2_TIPO,
	SE2.D_E_L_E_T_,
	SE2.R_E_C_D_E_L_ 
Order By 10,9

    --C7_CC,
    --CTTSC7.CTT_DESC01,
	--SD1.R_E_C_N_O_
--ORDER BY SD1.R_E_C_N_O_;
--Having COUNT(F1_FORNECE+F1_LOJA+F1_DOC+F1_SERIE+D1_ITEM) > 1 


/*

--NF Entrada
Select * From SF1010
Where F1_DOC = '47387' and F1_SERIE = ''
And F1_FORNECE = 'V009DU'
And D_E_L_E_T_ = ''

Select D1_CC,* From SD1010
Where D1_DOC = '000000175' and D1_SERIE = '0'
And D1_FORNECE = 'VOOZOK'
And D_E_L_E_T_ = ''

--Genericas
Select * FRom SX5010
Where X5_TABELA = '02' AND D_E_L_E_T_ = ''

-- Contas a pagar
Select * From SE2010
Where E2_NUM = '000000175' and E2_FORNECE = 'VOOZOK'
And D_E_L_E_T_ =''

-- PC
Select C7_NATUREZ,* From SC7010
Where C7_NATUREZ <> '' and D_E_L_E_T_ = ''

*/



