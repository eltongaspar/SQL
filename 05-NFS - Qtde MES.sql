-- SF1 - NF Entrada - Indicador 
Select Count(Distinct R_E_C_N_O_) As QTDE,Left(F1_DTDIGIT,6)	
	
From SF1010 SF1

Where F1_DTDIGIT >= '20230101'  and F1_FILIAL In('01','02','03') and SF1.D_E_L_E_T_ ='' 
And F1_ESPECIE = 'NFS'
Group By Left(F1_DTDIGIT,6)
Order By 2



-- SF1 - NF Entrada - Indicador 
Select Left(F1_DTDIGIT,6) As AAAA_MM,F1_ESPECIE, X5_DESCRI,
Count(Distinct F1_DOC) QUANT

		
From SF1010 SF1

	Inner Join SX5010
	On X5_FILIAL = X5_FILIAL
	And X5_TABELA = '42' --ESPECIES DE DOCUMENTOS FISCAIS                         
	And X5_CHAVE = F1_ESPECIE

	Inner Join SA2010 SA2
	On A2_COD = F1_FORNECE 
	And A2_LOJA = F1_LOJA
	And SA2.D_E_L_E_T_ = ''

Where F1_DTDIGIT >= '20230101' and F1_FILIAL In('01','02','03') and SF1.D_E_L_E_T_ = ''  And F1_ESPECIE Like ('%NFS%')
Group By Left(F1_DTDIGIT,6),F1_ESPECIE,X5_DESCRI
Order By 2,1 Desc



-- SF1 - NF Entrada - Indicador 
Select F1_ESPECIE, X5_DESCRI, A2_MUN,A2_EST,A2_COD_MUN,
Count(Distinct F1_DOC) QUANT

		
From SF1010 SF1

	Inner Join SX5010
	On X5_FILIAL = X5_FILIAL
	And X5_TABELA = '42' --ESPECIES DE DOCUMENTOS FISCAIS                         
	And X5_CHAVE = F1_ESPECIE

	Inner Join SA2010 SA2
	On A2_COD = F1_FORNECE 
	And A2_LOJA = F1_LOJA
	And SA2.D_E_L_E_T_ = ''



Where F1_DTDIGIT >= '20230101' and F1_FILIAL In('01','02','03') and SF1.D_E_L_E_T_ = ''  And F1_ESPECIE Like ('%NFS%')
Group By F1_ESPECIE,X5_DESCRI,A2_MUN,A2_EST,A2_COD_MUN
Order By 4,3

Select * From CC2010

Select * From SA2010