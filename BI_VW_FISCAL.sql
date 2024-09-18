-- NF Entrada Cab. 
Select Distinct
	Isnull(F1_DTLANC,'')					As F1_DTLANC,
	Isnull(F1_ORIGEM,'')					As F1_ORIGEM,
	Isnull(F1_DOC,'')						As F1_DOC,
	Isnull(A2_COD,'')						As A2_COD,
	ISNULL(A2_LOJA,'')						As A2_LOJA,
	Isnull(A2_NOME,'')						As A2_NOME,
	Isnull(A2_CGC,'')						As A2_CGC,
	Isnull(D1_COD,'')						As D1_COD,
	Isnull(D1_DESCRI,'')					As D1_DESCRI,
	Isnull(D1_ITEM,'')						As D1_ITEM,
	Isnull(B1_TIPO,'')						As B1_TIPO, 
	Isnull(F1_ESPECIE,'')					As F1_ESPECIE,
	Isnull(SX5_TP.X5_DESCRI,'')				As SX5_TP_X5_DESCRI,
	Isnull(F1_TIPO,'')						As F1_TIPO,
	Isnull(C00_STATUS,'')					As C00_STATUS,
	Isnull(D1_VALIMP5,'')					As D1_VALIMP5,
	Isnull(D1_VALIMP6,'')					As D1_VALIMP6,
	Isnull(F1_VALIMP5,'')					As F1_VALIMP5,
	Isnull(F1_VALIMP6,'')					As F1_VALIMP6,
	Isnull(E2_TIPO,'')						As E2_TIPO,
	IsNull(SX5E2.X5_DESCRI,'')				As DESC_TIPO,
	Isnull(E2_FORNECE,'')					As E2_FORNECE ,
	Isnull(E2_NOMFOR,'')					As E2_NOMFOR,
	Isnull(E2_VALOR,'')						As E2_VALOR,
	Isnull(E2_SALDO,'')						As E2_SALDO,
	Isnull(E2_VALLIQ,'')					As E2_VALLIQ,
	Isnull(E2_BAIXA,'')						As E2_BAIXA,
	Isnull((E2_PIS+E2_COFINS+E2_CSLL),'')	As IMP_BASE,
	Isnull(E2_VRETPIS,'')					As E2_VRETPIS,
	Isnull(E2_VRETCOF,'')					As E2_VRETCOF,
	Isnull(E2_VRETCSL,'')					As E2_VRETCSL,
	Isnull(E2_VRETISS,'')					As E2_VRETISS,
	Isnull(E2_VRETIRF,'')					As E2_VRETIRF,
	Isnull(E2_VRETINS,'')					As E2_VRETINS,
	Isnull(D1_TES,'')						As D1_TES,
	Isnull(F4_TEXTO,'')						As F4_TEXT,
	Isnull(D1_CF,'')						As D1_CF,
	Isnull(SX5_CFOP.X5_DESCRI,'')			As SX5_CFOP_X5_DESCRI,
	Isnull(SubString(CT2.CT2_ITEMC,2,6),'')	AS FORNEC_CONTAB,
	Isnull(SubString(CT2.CT2_ITEMC,8,2),'')As LOJA_CONTAB,
	Isnull(SubString(CT2_ITEM.CT2_ITEMC,2,6),'')		AS FORNEC_CONTAB_ITEM,
	Isnull(SubString(CT2_ITEM.CT2_ITEMC,8,2),'')	    As LOJA_CONTAB_ITEM,
	
	D1_VALIMP5_PIS = (Select SUM(D1_VALIMP5) From SD1010 With (Nolock)
						Where   D1_FILIAL = F1_FILIAL
								And D1_FORNECE = F1_FORNECE
								And D1_LOJA = F1_LOJA  
								And D1_DOC = F1_DOC
								And D1_SERIE = F1_SERIE
								And SD1.D_E_L_E_T_ = '' ), 


	D1_VALIMP6_COFINS = (Select SUM(D1_VALIMP6) From SD1010 With (Nolock)
						Where   D1_FILIAL = F1_FILIAL
								And D1_FORNECE = F1_FORNECE
								And D1_LOJA = F1_LOJA  
								And D1_DOC = F1_DOC
								And D1_SERIE = F1_SERIE
								And SD1.D_E_L_E_T_ = '' ), 


	Case 
	When F1_ORIGEM = 'COMXCOL' Then 'AUTO_IMPORT'
	When F1_ORIGEM = 'AtuDocFr' Then 'AUTO_CTE'
	When F1_ORIGEM = 'cbcInTrC' Then 'AUTO_IND'
	Else 'MANUAL'
	End AS Status_,


	Case 
	When F1_TIPO = 'N' Then 'NF Normal'
	When F1_TIPO = 'C' Then 'Compl. Preco'
	When F1_TIPO = 'D' Then 'Devolucao'
	When F1_TIPO = 'I' Then ' NF Compl. ICMS'
	When F1_TIPO = 'P' Then 'NF Compl. IPI'
	When F1_TIPO = 'B' Then 'NF Beneficiamento'
	End as TIPO,

	Case 
	When DS_CHAVENF <> '' 
	Then 'PRE_NOTA'
	Else 'SEM_PRE_NOTA'
	End as STATUS_PRE_NOTA,
	
	Case 
		When C00_CHVNFE = '' Then 'Manifesto não Processado'
		When  C00_CHVNFE <> '' and C00_STATUS = '0' Then 'Desconhecido'
		When  C00_CHVNFE <> '' and C00_STATUS = '1' Then 'Confirmação da Operação'
		When  C00_CHVNFE <> '' and C00_STATUS = '2' Then 'Ciencia da Operação'
		When  C00_CHVNFE <> '' and C00_STATUS = '3' Then 'Desconhecimento da Operação'
		When  C00_CHVNFE <> '' and C00_STATUS = '4' Then 'Operação não Recebida'
		Else 'Verifivcar'
	End As STATUS_MANIFESTO,



	Case 
		When F3_CHVNFE <> '' Then 'Livro Fiscal'
		Else 'Sem Livro Fiscal'
	End as STATUS_FISCAL,

	Case 
		When F3_CHVNFE <> '' Then 'Livro Fiscal Itens'
		Else 'Sem Livro Fiscal Itens'
	End as STATUS_FISCAL_ITENS,

	Case
		When F1_STATUS = 'A' Then 'Classificada'
		When F1_STATUS = '' Then 'Sem Classificação'
		Else ''
	End As NF_STATUS,

	Case When CTK.CTK_SEQUEN <> '' Then 'Com Contra Prova Contab'
	Else 'Sem Contra Prova Contab'
	End as STATUS_FISCAL_ITENS,

	Case When CT2.CT2_SEQUEN <> '' Then 'Com Lanc. Contabil'
	Else 'Sem Lanc.Contabil'
	End as STATUS_FISCAL_ITENS,

	Case When CV3.CV3_SEQUEN <> '' Then 'Com Rastreamento Contab.'
	Else 'Sem Rastreamento Contab'
	End as STATUS_FISCAL_ITENS,

	Case When CTK_ITEM.CTK_SEQUEN <> '' Then 'Com Contra Prova Contab'
	Else 'Sem Contra Prova Contab_ITEM'
	End as STATUS_FISCAL_ITENS,

	Case When CT2_ITEM.CT2_SEQUEN <> '' Then 'Com Lanc. Contabil'
	Else 'Sem Lanc.Contabil_ITEM'
	End as STATUS_FISCAL_ITENS,

	Case When CV3_ITEM.CV3_SEQUEN <> '' Then 'Com Rastreamento Contab.'
	Else 'Sem Rastreamento Contab_ITEM'
	End as STATUS_FISCAL_ITENS,


F1_EMISSAO,F1_DTDIGIT,DATEDIFF(Day,F1_EMISSAO,F1_DTDIGIT) As DATA_DIF,
CT2.CT2_HIST As CT2_HIS,
CT2_ITEM.CT2_HIST as CT2_HIST_ITEM,
CT2.CT2_VALOR As CT2_VALOR,
CT2_ITEM.CT2_VALOR As CT2_VALOR_ITEM,
D1_VALICM,D1_VALIMP5,D1_VALIMP6,D1_VALIPI,D1_VALISS,D1_VALINS,F1_VALBRUT,
CT2.CT2_SEQUEN As CT2_SEQUEN,CT2_ITEM.CT2_SEQUEN As CT2_SEQUEN_ITEM

From SF1010 SF1 With(Nolock)


	Left Join SA2010 SA2 With(Nolock) -- Fornecedores 
	On A2_COD = F1_FORNECE
	And A2_LOJA = F1_LOJA
	And SA2.D_E_L_E_T_ = ''

	Left Join SX5010 SX5 With(Nolock)
	On X5_FILIAL = F1_FILIAL
	And X5_TABELA = '42' --ESPECIES DE DOCUMENTOS FISCAIS                         
	And X5_CHAVE = F1_ESPECIE
	And SX5.D_E_L_E_T_ = ''

	Left Join SYS_COMPANY COMP_FOR With(Nolock) -- Filiais 
	On COMP_FOR.M0_CGC = A2_CGC
	And COMP_FOR.D_E_L_E_T_ = ''

	Left Join SD1010 SD1 With(Nolock) -- NF Sadia Itens
	On D1_FILIAL = F1_FILIAL
	And D1_FORNECE = F1_FORNECE
	And D1_LOJA = F1_LOJA  
	And D1_DOC = F1_DOC
	And D1_SERIE = F1_SERIE
	And SD1.D_E_L_E_T_ = ''

	Left Join SB1010 SB1 With(Nolock) --Produtos 
	On D1_COD = B1_COD
	And SB1.D_E_L_E_T_ = ''

	Left Join SX5010 SX5_TP With(Nolock) -- Generica Tipo Produto 
	On SX5_TP.X5_TABELA = '02'
	And SX5_TP.X5_CHAVE = B1_TIPO
	And SX5_TP.D_E_L_E_T_ = ''
	And SX5_TP.X5_FILIAL = F1_FILIAL

	Left Join SDS010 SDS With(Nolock) -- Cabecalho importacao XML NF-e
	On DS_CHAVENF = F1_CHVNFE
	And DS_CHAVENF <> ''
	And DS_FILIAL = F1_FILIAL
	And DS_FORNEC = F1_FORNECE
	And DS_LOJA = F1_LOJA
	And DS_DOC = F1_DOC
	And DS_SERIE = F1_SERIE
	And SDS.D_E_L_E_T_ = ''

	Left Join SDT010 SDT With(Nolock) --Itens importacao XML NF-e
	On DT_FILIAL = DS_FILIAL
	And DT_DOC = DS_DOC
	And DT_FORNEC = DS_FORNEC
	And DT_LOJA = DS_LOJA
	And DT_ITEM = D1_ITEM
	And DT_COD = D1_COD
	And SDT.D_E_L_E_T_ = ''

	Left Join C00010 C00 With(Nolock) -- Manifesto do destinatario
	On C00_CHVNFE = F1_CHVNFE
	And C00_CHVNFE <> ''
	And C00.D_E_L_E_T_ = ''

	
	Left Join SF3010 SF3 With(Nolock) -- Livros Fiscais 
	On F3_CHVNFE = F1_CHVNFE
	And F3_CHVNFE <> ''
	And F3_FILIAL = F1_FILIAL
	And SF3.D_E_L_E_T_ = ''

	Left Join SFT010 SFT With(Nolock) -- Livros Fiscais 
	On FT_CHVNFE = F1_CHVNFE
	And FT_CHVNFE <> ''
	And FT_ITEM = D1_ITEM
	And FT_FILIAL = F1_FILIAL
	And FT_CLIEFOR = D1_FORNECE
	And FT_LOJA = D1_LOJA
	And SFT.D_E_L_E_T_ = ''

	-- Contas a Pagar
	Left Join SE2010 SE2 With (Nolock)
	On F1_FILIAL = E2_FILIAL
	And F1_FORNECE = E2_FORNECE 
	--Or E2_FORNECE In ('UNIAO')
	And F1_LOJA = E2_LOJA
	And F1_DOC = E2_NUM
	And SE2.D_E_L_E_T_ = ''

	-- Genericas 
	Left Join SX5010 SX5E2 With (Nolock)
	On SX5E2.X5_TABELA = '05'
	And SX5E2.X5_FILIAL = E2_FILIAL
	And SX5E2.X5_CHAVE = E2_TIPO
	And SX5E2.D_E_L_E_T_ = ''

	-- TES
	Left Join SF4010 SF4 
	On F4_CODIGO = D1_COD
	and SF4.D_E_L_E_T_ =''
	
	Left Join SX5010 SX5_CFOP With(Nolock) -- Generica Tipo Produto 
	On SX5_CFOP.X5_TABELA = '13'
	And SX5_CFOP.X5_CHAVE = D1_CF
	And SX5_CFOP.D_E_L_E_T_ = ''
	And SX5_CFOP.X5_FILIAL = D1_FILIAL

	Left Join CT2010 CT2 With(Nolock) -- Lanc. Contabeis Cab. 
	On CT2_FILIAL = F1_FILIAL
	And SubString(CT2_ITEMC,2,6) = F1_FORNECE
	And SubString(CT2_ITEMC,8,2) = F1_LOJA
	--And CT2_LOTE = '008810'
	--And CT2_SBLOTE = '001'
	--And CT2_HIST Like ('FRETE%')
	And CT2_VALOR = F1_VALBRUT
	And SubString(CT2_KEY,3,9) = REPLICATE('0', 9 - LEN(F1_DOC)) + RTrim(F1_DOC)
	And CT2.D_E_L_E_T_ = ''

	Left Join CT2010 CT2_ITEM With(Nolock) -- Lanc. Contabeis Cab. 
	On CT2.CT2_SEQUEN = CT2_ITEM.CT2_SEQUEN
	And SubString(CT2_ITEM.CT2_KEY,15,6) = F1_FORNECE
	And SubString(CT2_ITEM.CT2_KEY,21,2) = F1_LOJA
	And SubString(CT2_ITEM.CT2_KEY,23,10) = D1_COD
	And (CT2_ITEM.CT2_VALOR = D1_VALICM 
	Or CT2_ITEM.CT2_VALOR = D1_VALIMP5 
	Or CT2_ITEM.CT2_VALOR = D1_VALIMP6
	Or CT2_ITEM.CT2_VALOR = D1_VALIPI
	Or CT2_ITEM.CT2_VALOR = D1_VALISS
	Or CT2_ITEM.CT2_VALOR = D1_VALINS
	Or CT2_ITEM.CT2_VALOR = F1_VALBRUT )
	And SubString(CT2_ITEM.CT2_KEY,3,9) = REPLICATE('0', 9 - LEN(F1_DOC)) + RTrim(F1_DOC)
	And CT2.D_E_L_E_T_ = ''


	Left Join CTK010 CTK With(Nolock) -- Lanc. Contabeis
	On CTK_SEQUEN = CT2.CT2_SEQUEN
	And CTK.D_E_L_E_T_ = ''

	Left Join CV3010 CV3 With(Nolock) --CV3 - Rastreamento Lancamento
	On CV3_SEQUEN =CT2.CT2_SEQUEN
	And CV3.D_E_L_E_T_ = ''

	
	Left Join CTK010 CTK_ITEM With(Nolock) -- Lanc. Contabeis
	On CTK_ITEM.CTK_SEQUEN = CT2_ITEM.CT2_SEQUEN
	And CTK.D_E_L_E_T_ = ''

	Left Join CV3010 CV3_ITEM With(Nolock) --CV3 - Rastreamento Lancamento
	On CV3_ITEM.CV3_SEQUEN = CT2_ITEM.CT2_SEQUEN
	And CV3.D_E_L_E_T_ = ''

Where F1_EMISSAO Between '20240701' and '20240731'
And F1_FILIAL In ('01','02','03')
--And F1_FORNECE = 'V0091S' and F1_DOC = '000112066'
And (CT2.CT2_HIST Like ('%[MOV.INTERNA]%') or CT2_ITEM.CT2_HIST Like ('%[MOV.INTERNA]%'))
and SF1.D_E_L_E_T_ = ''
Order By 1,4,5,3,10


