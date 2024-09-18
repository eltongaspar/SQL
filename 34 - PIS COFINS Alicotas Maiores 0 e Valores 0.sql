Select 
		D2_FILIAL,D2_CLIENTE,D2_LOJA,D2_DOC,D2_SERIE,D2_COD,D2_ITEM,
		D2_TES, A1_MUN, A1_EST, F2_EST,
		D2_ALQIMP5,D2_ALQIMP6,D2_BASIMP5,D2_BASIMP6,D2_VALIMP5,D2_VALIMP6,
		D2_BASIMP5,F2_BASIMP6,F2_VALIMP5,F2_VALIMP6,
		FT_ALIQPIS,FT_ALIQCOF,FT_BASECOF,FT_VALCOF,FT_BASEPIS,FT_VALPIS,
		F3_ALQIMP5,F3_ALQIMP6,F3_BASIMP5,F3_BASIMP6,F3_VALIMP5,F3_VALIMP6,
		D2_TES,F4_TEXTO,F4_PISCOF,F4_SITTRIB,F4_PISCRED,
		D2_CLIENTE,D2_LOJA,A1_NOME, A1_CGC,A1_TIPO,
		F2_ESPECIE,X5_DESCRI,F2_TIPO,
		A1_GRPTRIB,B1_GRTRIB,
		F7_GRTRIB,F7_GRPCLI,F7_ALIQPIS,F7_ALIQCOF,F7_ORIGEM,F7_TIPOCLI,
		B1_TIPO,B1_COD,B1_DESC,B1_GRUPO,

	Case 
	When F2_TIPO = 'N' Then 'NF Normal'
	When F2_TIPO = 'C' Then 'Compl. Preco'
	When F2_TIPO = 'D' Then 'Devolucao'
	When F2_TIPO = 'I' Then ' NF Compl. ICMS'
	When F2_TIPO = 'P' Then 'NF Compl. IPI'
	When F2_TIPO = 'B' Then 'NF Beneficiamento'
	End as TIPO
		
From SD2010 SD2 With(Nolock) -- NF Saida Itens 

	Inner Join SF2010 SF2 With(Nolock) --NF Saida Cab.
	On F2_FILIAL = D2_FILIAL
	And F2_CLIENTE = D2_CLIENTE
	And F2_LOJA = D2_LOJA
	And F2_DOC = D2_DOC
	And F2_SERIE = D2_SERIE
	And SF2.D_E_L_E_T_ = ''

	Inner Join SX5010 SX5 With(Nolock) -- Genericas 
	On X5_FILIAL = F2_FILIAL
	And X5_TABELA = '42' --ESPECIES DE DOCUMENTOS FISCAIS                         
	And X5_CHAVE = F2_ESPECIE
	And SX5.D_E_L_E_T_ = ''	
	
	Inner Join SB1010 SB1 With(Nolock) --Produtos
	On B1_COD = D2_COD
	And SB1.D_E_L_E_T_ =''
	
	Inner Join SA1010 SA1 With(Nolock) --Clientes
	On A1_COD = D2_CLIENTE
	And A1_LOJA = D2_LOJA
	And SA1.D_E_L_E_T_ =''
	
	Left Join SF7010 SF7 With(Nolock) -- Excessao Fiscal
	On F7_FILIAL = D2_FILIAL
	And A1_GRPTRIB = F7_GRPCLI
	And  B1_GRTRIB = F7_GRTRIB
	And F7_GRPCLI <> ''
	And F7_DTFIMNT >= '20240101'
	And SF7.D_E_L_E_T_ = ''
	
	Inner Join SF4010 SF4 With(Nolock) --TES
	On D2_TES = F4_CODIGO
	And SF4.D_E_L_E_T_ = ''

	Left Join SF3010 SF3 With(Nolock) -- Livros Fiscais 
	On F3_CHVNFE = F2_CHVNFE
	And F3_FILIAL = F2_FILIAL
	And F3_CLIEFOR = F2_CLIENTE
	And F3_LOJA = F2_LOJA
	And SF3.D_E_L_E_T_ = ''

	Left Join SFT010 SFT With(Nolock) -- Livros Fiscais 
	On FT_CHVNFE = F2_CHVNFE
	And FT_ITEM = D2_ITEM
	And FT_FILIAL = D2_FILIAL
	And FT_CLIEFOR = D2_CLIENTE
	And FT_LOJA = D2_LOJA
	And SFT.D_E_L_E_T_ = ''

Where (D2_ALQIMP5 > '0' and D2_ALQIMP6 > '0'
And D2_VALIMP5 = 0 And D2_VALIMP6 = 0
And D2_EMISSAO >= '20240101')
--Or D2_TES In ('600','612')
And SD2.D_E_L_E_T_ = ''
Order By 1,2,3,4,5,6,7


--Select * From SF3010