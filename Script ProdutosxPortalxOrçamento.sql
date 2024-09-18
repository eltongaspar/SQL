 --Produtos
Select B1_COD,
B1_NOME,Z1_APELIDO,B1_BITOLA,Z2_DESC,B1_CLASENC,SX5_CLASSE.X5_DESCRI,B1_COR,Z3_DESC,B1_ESPECIA,Z4_DESC,Z4_DETALHE,
Z1_NOME,Z1_PROCESS,Z1_VIAS,Z1_DESC2,Z4_DETALHE,
B1_XPORTAL,Z1_XPORTAL,
B1_COD,B1_DESC,B1_ROLO,B1_BOBINA,B1_XPORTAL,((NULLIF(ZP9_TOTAL,0)/NULLIF(ZP9_QUANT,0))) As ZP9_ORC,

	Case 
		When B1_XPORTAL In ('S','E') and B1_TIPO = 'PA'
		Then 'OK'
		Else 'Error'
	End as 'Portal Produto',

	Case 
		When Z1_XPORTAL In ('S','E')
		Then 'OK'
		Else 'Error'
	End as 'Portal Nome-Familia',

	Case 
		When Z2_XPORTAL In ('S','E')
		Then 'OK'
		Else 'Error'
	End as 'Portal Bitola',
	
	Case 
		When Z3_XPORTAL In ('S','E')
		Then 'OK'
		Else 'Error'
	End as 'Cores Bitola',

	Case 
		When ZZZ_FILIAL = '' 
		And ZZZ_PROD = B1_NOME
		And ZZZ_BITOLA = B1_BITOLA
		And ZZZ_ACOND In ('B')
		And Convert(varchar,ZZZ_VLRMTR) <= Convert(varchar,B1_BOBINA)
		Then 'OK'
		Else 'Error'
	End as 'LancesxAcondicionamento',

	Case 
		When B1_XPORTAL In ('S','E') and B1_TIPO = 'PA'
		And Z1_XPORTAL In ('S','E')
		And Z2_XPORTAL In ('S','E')
		And Z3_XPORTAL In ('S','E')
		And ZZZ_FILIAL = '' 
		And ZZZ_PROD = B1_NOME
		And ZZZ_BITOLA = B1_BITOLA
		And ZZZ_ACOND In ('B')
		And Convert(varchar,ZZZ_VLRMTR) <= Convert(varchar,B1_BOBINA)
		Then 'OK'
		Else 'Produtos não ativo no Portal
			Motivo Verificar demais cadastros estão Ativos no Portal:
			Produto,Nome/Familia,Bitola, Cores'
	End as 'Produto Ativo Portal',


	--Verifica Tipo de Acondicionamento 
	Case 
	When ZP6_ACOND = 'B' Then 'BOBINA'
	When ZP6_ACOND = 'R' Then 'ROLO'
	Else 'VERIFICAR'
	End AS ACONDICIONAMENTO,

	-- ANALISA METRAGEM BOBINA MÁXIMA ROLO OU BOBIBA
	Case 
	When ZP6_ACOND = 'B' and Isnull((NULLIF(ZP9_TOTAL,0)/NULLIF(ZP9_QUANT,0)),'') > B1_BOBINA Then '*******ANALISAR METRAGEM MÁXIMA BOBINA*******'
	When ZP6_ACOND = 'R' and (NULLIF(ZP9_TOTAL,0)/NULLIF(ZP9_QUANT,0)) > B1_ROLO Then '*******ANALISAR METRAGEM MÁXIMA ROLO*******'
	When ZP6_ACOND = 'B' and (NULLIF(ZP9_TOTAL,0)/NULLIF(ZP9_QUANT,0)) <= B1_BOBINA Then 'METRAGEM MÁXIMA BOBINA VÁLIDA'
	When ZP6_ACOND = 'R' and (NULLIF(ZP9_TOTAL,0)/NULLIF(ZP9_QUANT,0)) <= B1_ROLO Then 'METRAGEM MÁXIMA ROLO VÁLIDA'
	Else 'VERIFICAR'
	End AS Status_,

	-- ANALISA METRAGEM BOBINA MÁXIMA ROLO OU BOBIBA - Recomendações 
	Case 
	When ZP6_ACOND = 'B' and Isnull((NULLIF(ZP9_TOTAL,0)/NULLIF(ZP9_QUANT,0)),'') > B1_BOBINA 
	Then '*******VERIFICAR CADASTRO PRODUTO BOBINA MÁXIMA ESTA CONFORME METRAGEM DO PV*******'
	When ZP6_ACOND = 'R' and (NULLIF(ZP9_TOTAL,0)/NULLIF(ZP9_QUANT,0)) > B1_ROLO 
	Then '*******VERIFICAR CADASTRO PRODUTO ROLO MÁXIMA ESTA CONFORME METRAGEM DO PV*******'
	When ZP6_ACOND = 'B' and (NULLIF(ZP9_TOTAL,0)/NULLIF(ZP9_QUANT,0)) <= B1_BOBINA 
	Then 'METRAGEM MÁXIMA NO CADASTRO DO PRODUTO ESTA DE ACORDO COM O PV'
	When ZP6_ACOND = 'R' and (NULLIF(ZP9_TOTAL,0)/NULLIF(ZP9_QUANT,0)) <= B1_ROLO 
	Then 'METRAGEM MÁXIMA ROLO VÁLIDA'
	Else 'VERIFICAR'
	End AS RECOMENDACAO


From SB1010 SB1
	
		Inner Join SZ1010 SZ1 --Nome-Familia-Classe Portal 
		On B1_NOME = Z1_COD
		And SZ1.D_E_L_E_T_ = '' 

		Inner Join SX5010 SX5_TP -- Tipos de Produtos
		On SX5_TP.X5_FILIAL = ''
		And SX5_TP.X5_TABELA = '02'
		And SX5_TP.X5_CHAVE = B1_TIPO
		And SX5_TP.D_E_L_E_T_ = '' 
				
		Inner Join SZ2010 SZ2 -- Bitola Portal
		On B1_BITOLA = Z2_COD
		And SZ2.D_E_L_E_T_ = '' 
						
		Inner Join SZ3010 SZ3 -- Cores Portal
		On B1_COR = Z3_COD
		And SZ3.D_E_L_E_T_ = '' 

						
		Inner Join SZ4010 SZ4 -- Especialidades
		On B1_ESPECIA = Z4_COD
		And SZ4.D_E_L_E_T_ = '' 

		Inner Join SX5010 SX5_CLASSE -- Classes 
		ON SX5_CLASSE.X5_FILIAL = '01'
		And SX5_CLASSE.X5_TABELA = 'Z1'
		And SX5_CLASSE.X5_CHAVE = B1_CLASENC
		And SX5_CLASSE.D_E_L_E_T_ = '' 


		Left Join ZZZ010 ZZZ -- Lances x Acondicionamento 
		On ZZZ_FILIAL = ''
		And ZZZ_PROD = B1_NOME
		And ZZZ_BITOLA = B1_BITOLA
		And ZZZ_ACOND In ('B')
		And ZZZ.D_E_L_E_T_ = ''
		And Convert(varchar,ZZZ_VLRMTR) <= Convert(varchar,B1_BOBINA)

		
		Inner Join ZP9010 SZ9 --Orcamento Itens Cores 
		On B1_COD = ZP9_CODPRO
		And SB1.D_E_L_E_T_ = ''

		Inner Join ZP6010 ZP6 -- Orcamento Itens 
		On ZP6_NUM = ZP9_NUM
		And ZP6_ITEM = ZP9_ITEM
		And ZP6.D_E_L_E_T_ = ''

Where ZP9_NUM = '395086'
And SB1.D_E_L_E_T_ = ''
Order By 1

--Select * From ZZZ010