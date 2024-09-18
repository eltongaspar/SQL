----SDS - Cabecalho importacao XML NF-e
Select DS_CHAVENF,* From SDS010 With(NoLock)
Where DS_CHAVENF = '31240703981899000169550010002398381101757748'
And D_E_L_E_T_ = ''

--SDT - Itens importacao XML NF-e
Select DT_DOC,DT_XALQICM,* From SDT010
Where DT_FILIAL = '01' and DT_DOC In ('000239838') 
and D_E_L_E_T_ = ''
And DT_FORNEC In ('V009R4')

---- NF Entrada Itens 
Select F1_ORIGEM,F1_FORNECE,F1_EST,F1_DOC,F1_EMISSAO,
D1_VALICM,D1_PICM,D1_BASEICM,* From SD1010 SD1

	Inner Join SF1010 SF1
	On F1_FILIAL = D1_FILIAL
	And F1_DOC = D1_DOC
	And F1_LOJA = D1_LOJA
	And F1_FORNECE = D1_FORNECE
	And F1_LOJA = D1_LOJA
	And SF1.D_E_L_E_T_ =''

	Inner Join SA2010 SA2
	On A2_COD = D1_FORNECE
	And A2_LOJA = D1_LOJA
	And SA2.D_E_L_E_T_ =''
	
	Inner Join SB1010 SB1
	On B1_COD = D1_COD
	And SB1. D_E_L_E_T_ = ''

	Left Join SF4010 SF4 With(Nolock) --TES
	On D1_TES = F4_CODIGO
	And SF4.D_E_L_E_T_ = ''

Where D1_FORNECE = 'V009R4'
And D1_FILIAL = '01'
And D1_EMISSAO >= '20240101'
And D1_COD = 'PF1820A'
And F1_EST = 'MG'
And D1_DOC = '000239838'
And SD1.D_E_L_E_T_ = ''
Order By D1_EMISSAO Desc

