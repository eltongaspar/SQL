-- NF Entrada Itens
-- Validador 2 UM 
Select Distinct D1_COD CODIGO,B1_DESC PROD_DESC,B1_UM UM_PRODUTO,SAH.AH_DESCES UM_DESC,B1_SEGUM SEG_UM_PROD,SAH2.AH_DESCES SEG_UM_DESC,B1_CONV FATOR_CONVERT,

B1_TIPCONV,D1_UM UM_NF,D1_SEGUM SEG_UM_NF,D1_QTSEGUM QTDE_2UM_NF,B1_TIPO,X5_DESCRI TIPO, D1_DOC,D1_FORNECE, A2_NOME,D1_FILIAL,
B1_TIPCONV,B1_CONV,D1_UM,D1_SEGUM,C7_UM,C7_SEGUM,D1_QUANT,C7_QUANT,D1_QTSEGUM,C7_QTSEGUM,



    Case 

    When D1_SEGUM <> '' and D1_QTSEGUM = '0' Then '#######'

    Else '*******'

    End AS Status_,

	Case 
	When F1_ORIGEM = 'COMXCOL' Then 'AUTO_IMPORT'
	When F1_ORIGEM = 'AtuDocFr' Then 'AUTO_CTE'
	When F1_ORIGEM = 'cbcInTrC' Then 'AUTO_IND'
	Else 'MANUAL'
	End AS Status_NFe,


	
	Case 
	When (C7_QUANT-C7_QUJE-C7_QTDACLA) = 0 And ((C7_QUJE > 0) Or (C7_QTDACLA > 0))  Then 'ATENDIDO'
	When (C7_QUANT-C7_QUJE-C7_QTDACLA) > 0 And ((C7_QUJE > 0) Or (C7_QTDACLA > 0))  Then 'PARCIAL'
	When C7_QUJE = 0 and C7_QTDACLA = 0   Then 'Em Aberto'
	Else 'Verificar'
	End AS Status_,

	Case 
	When C7_ENCER = 'E'  Then 'Encerrado'
	When C7_ENCER = ' '  Then 'Nao Encerrado'
	Else 'Verificar'
	End AS Status_,

	Case 
	When C7_RESIDUO = 'S'  Then 'Eliminado'
	When C7_RESIDUO = ' '  Then 'Nao Eliminado'
	Else 'Verificar'
	End AS Status_,
	   
	Case 
	When C7_CONAPRO = 'B' Then 'BLOQ'
	When C7_CONAPRO = 'L' Then 'LIB'
	When C7_CONAPRO = 'R' Then 'REJ'
	Else 'VERIFICAR'
	End As STATUS_LIB



From SD1010 SD1

    Inner Join SB1010 SB1

    On B1_COD = D1_COD

    And SB1. D_E_L_E_T_ = ''



    Inner Join SAH010 SAH

    On SAH.AH_UNIMED = B1_UM

    And SAH.D_E_L_E_T_ = ''



    Inner Join SAH010 SAH2

    On SAH2.AH_UNIMED = B1_SEGUM

    And SAH2.D_E_L_E_T_ = ''



    Inner Join SX5010 SX5

    On X5_TABELA = '02' 

    And X5_CHAVE = B1_TIPO

    And SX5.D_E_L_E_T_ = ''



    Inner Join SA2010 SA2

    On D1_FORNECE = A2_COD

    And SA2.D_E_L_E_T_ = ''

	Inner Join SF1010 SF1
	On F1_FILIAL = D1_FILIAL
	And F1_DOC = D1_DOC
	And F1_LOJA = D1_LOJA
	And F1_FORNECE = D1_FORNECE
	And F1_LOJA = D1_LOJA
	And SF1.D_E_L_E_T_ =''


	
	LEFT Join SC7010 SC7 With(Nolock)
	ON SD1.D1_FILIAL = C7_FILIAL
	And SD1.D1_PEDIDO = C7_NUM
	And SD1.D1_ITEMPC = C7_ITEM
	And SD1.D_E_L_E_T_ = ''
	
Where D1_FILIAL In ('01','02','03') --and D1_EMISSAO Between '20240101' and '20240431'
--And B1_SEGUM <> '' and B1_CONV = '0'
and D1_SEGUM <> '' and D1_QTSEGUM > '0'
And C7_NUM = '019677'
--And F1_ORIGEM = 'COMXCOL'
And SD1.D_E_L_E_T_ = ''
Order By D1_FILIAL,D1_COD



--35240550296896000508550550000817841604512430
