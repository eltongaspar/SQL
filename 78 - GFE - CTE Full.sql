-- Verificador CTEx NF Entrada x NF Saida x Financeiro x TES x Fornecedor x Transportadora x Ordem de Carga 
 -- NF Entrada Cab
Select Distinct  GXG_FILIAL,F1_FILIAL,F1_ESPECIE,F1_DOC,F1_DUPL,E2_NUM,F2_DOC,ZZ9_DOC,
E2_VALOR,F1_VALBRUT,F1_VALMERC, F1_VALPEDG,GXG_PEDAG,(F1_VALBRUT-F1_VALMERC) As DIF,
D1_TES,F4_TEXTO, F4_AGRPEDG,
(F1_VALPEDG-GXG_PEDAG) As DIF_PEDG,
F1_VALICM,F1_VALIMP5,F1_VALIMP6,D1_COD,
F1_FORNECE,F2_TRANSP,ZZ9_TRANSP,A2_CGC,A2_NOME,A4_CGC,A4_NOME,E2_FORNECE,E2_NOMFOR,
GXG_CTE,GXH_NRIMP,GXG.GXG_NRIMP,F2_CHVNFE,GXH_DANFE,GXG_EDISIT,
CC0_STATUS,CC0_STATEV,CC0_CODRET,CC0_MSGRET,
ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), ZZ9_JSCTE)),'') AS [CTE],
ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), ZZ9_JSVOLU)),'') AS [VOL],
ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), ZZ9_JSINFO)),'') AS [INFO],

ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), GXG_OBS)),'') AS [OBS],
ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), GXG_EDIMSG)),'') AS [MGS],
ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), GXG_ZZMSG)),'') AS [ZZMGS],

F1_DOC,Isnull(A2_COD,'') A2_COD,Isnull(A2_NOME,'') A2_NOME,Isnull(A2_CGC,'') A2_CGC,
F1_ESPECIE,SX5_TP.X5_DESCRI,F1_TIPO,D1_COD,D1_DESCRI,B1_TIPO, C00_STATUS,
D1_PEDIDO,B2_QATU,
	
	Case 
	When F1_VALMERC <> E2_VALOR Then 'CALC C/ PEDAGIO'
	When F1_VALMERC = E2_VALOR Then 'CALC S/ PEDAGIO'
	Else 'ANALISAR'
	End AS Status_,


	Case 
	When F1_CHVNFE <> '' Then 'FISCAL GERADO'
	When F1_CHVNFE = ''  Then 'SEM FISCAL'
	Else 'ANALISAR'
	End AS Status_FISCAL,

	Case 
	When ZZ9_JSCTE = ''  Then 'S/ ROTA'
	When ZZ9_JSCTE <> '' Then 'C/ ROTA'
	Else 'ANALISAR'
	End AS Status_ZZ9,

	
	Case 
	When GXG_EDISIT = '1'  Then 'Importado'
	When GXG_EDISIT = '2'  Then 'Importado com Erro'
	When GXG_EDISIT = '3'  Then 'Rejeitado'
	When GXG_EDISIT = '4'  Then 'Processado'
	When GXG_EDISIT = '5'  Then 'Erro Impeditivo'
	Else 'ANALISAR'
	End AS Status_EDI,
	--1=Importado;2=Importado com erro;3=Rejeitado;4=Processado;5=Erro Impeditivo
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
	When  C00_CHVNFE = '' Then 'Manifesto não Processado'
	When  C00_CHVNFE <> '' and C00_STATUS = '0' Then 'Desconhecido'
	When  C00_CHVNFE <> '' and C00_STATUS = '1' Then 'Confirmação da Operação'
	When  C00_CHVNFE <> '' and C00_STATUS = '2' Then 'Ciencia da Operação'
	When  C00_CHVNFE <> '' and C00_STATUS = '3' Then 'Desconhecimento da Operação'
	When  C00_CHVNFE <> '' and C00_STATUS = '4' Then 'Operação não Recebida'
	Else 'Verifivcar'
	End As STATUS_MANIFESTO,

	Case When F3_CHVNFE <> '' Then 'Livro Fiscal'
	Else 'Sem Livro Fiscal'
	End as STATUS_FISCAL,

	Case When F3_CHVNFE <> '' Then 'Livro Fiscal Itens'
	Else 'Sem Livro Fiscal Itens'
	End as STATUS_FISCAL_ITENS,

	Case 
	When CC0_STATUS = '1' Then 'Transmitido'
	When CC0_STATUS = '2' Then 'Nao Transmitido'
	When CC0_STATUS = '3' Then 'Autorizado'
	When CC0_STATUS = '4' Then 'Nao Autorizado'
	When CC0_STATUS = '5' Then 'Cancalado'
	When CC0_STATUS = '6' Then 'Encerrado'
	Else 'Analisar'
	End as STATUS_MDFe,

	Case 
	When CC0_STATEV = '1' Then 'Evento Não Realizado'
	When CC0_STATEV = '2' Then 'Evento Realizado'
	When CC0_STATEV = '3' Then 'Evento Vinculado'
	When CC0_STATEV = '4' Then 'Evento Não Vinculado'
	Else 'Analisar'
	End as STATUS_MDFe_Evento


From GXG010 GXG With(NoLock) -- GXG - EDI - Documento de Frete

	-- SF1 - NF Entrada Cab
	Left Join SF1010 SF1 With(NoLock)
	On GXG.GXG_FILIAL = F1_FILIAL
	And GXG.GXG_CTE = F1_CHVNFE
	And SF1.D_E_L_E_T_ = ''

	-- Contas a pagar
	Left Join SE2010 SE2 With(NoLock)
	On E2_FILIAL = F1_FILIAL
	And E2_LOJA = F1_LOJA
	And E2_NUM = F1_DOC
	And E2_FORNECE = F1_FORNECE
	And SE2.D_E_L_E_T_ = ''

	--NF Entrada Itens 
	Left Join SD1010 SD1 With(NoLock)
	On D1_FILIAL = F1_FILIAL
	And D1_LOJA = F1_LOJA
	And D1_DOC = F1_DOC
	And D1_FORNECE = F1_FORNECE
	And D1_LOJA = F1_LOJA
	And SD1.D_E_L_E_T_ = ''
	
	
	--GXH - EDI - DOC CARGA DO DOC FRETE
	Left Join GXH010 GXH With(NoLock)
	On GXH.GXH_FILIAL = GXG.GXG_FILIAL
	And GXH.GXH_NRIMP = GXG.GXG_NRIMP
	And GXH.D_E_L_E_T_ = ''
	--And GXH.GXH_SEQ = '00001'

	-- NF Saida - Cab.
	Left Join SF2010 SF2 With(NoLock)
	On SF2.F2_FILIAL = GXH.GXH_FILIAL
	And SF2.F2_CHVNFE = GXH.GXH_DANFE
--	And SF2.F2_TRANSP = GXG.GXG_EMISDF
	And SF2.D_E_L_E_T_ = ''

	-- NF Saida - Itens 
	Left Join SD2010 SD2 With(NoLock)
	On SD2.D2_FILIAL = SF2.F2_FILIAL
	And SD2.D2_DOC = SF2.F2_DOC
--	And SF2.F2_TRANSP = GXG.GXG_EMISDF
	And SD2.D_E_L_E_T_ = ''

		
	-- Ordem de Carga 
	Left Join ZZ9010 ZZ9 With(NoLock)
	On ZZ9_FILIAL = F2_FILIAL
	And ZZ9_DOC = F2_DOC
	And ZZ9_TRANSP = F2_TRANSP
	And ZZ9.D_E_L_E_T_ =''

	-- Transpotadora
	Left Join SA4010 SA4 With(NoLock)
	On SA4.A4_COD = F2_TRANSP
	And SA4.D_E_L_E_T_ = ''

		-- Fornecedor
	Left Join SA2010 SA2 With(NoLock)
	On SA2.A2_COD = F1_FORNECE
	And SA2.A2_LOJA = F1_LOJA
	And SA2.D_E_L_E_T_ = ''


	-- TES
	Left Join SF4010 SF4 With(NoLock)
	On F4_CODIGO = D1_TES
	And SF4.D_E_L_E_T_ =''

	Left Join C00010 C00 With(Nolock) -- Manifesto do destinatario
	On C00_CHVNFE = F1_CHVNFE
	Or C00_CHVNFE = GXG.GXG_CTE
	And C00.D_E_L_E_T_ = ''

	Left Join SX5010 SX5 With(Nolock)
	On X5_FILIAL = F1_FILIAL
	And X5_TABELA = '42' --ESPECIES DE DOCUMENTOS FISCAIS                         
	And X5_CHAVE = F1_ESPECIE
	And SX5.D_E_L_E_T_ = ''

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
	And SDS.D_E_L_E_T_ = ''

	Left Join SDT010 SDT With(Nolock) --Itens importacao XML NF-e
	On DT_FILIAL = DS_FILIAL
	And DT_DOC = DS_DOC
	And DT_FORNEC = DS_FORNEC
	And DT_LOJA = DS_LOJA
	And DT_ITEM = D1_ITEM
	And SDT.D_E_L_E_T_ = ''

	Left Join SF3010 SF3 With(Nolock) -- Livros Fiscais 
	On F3_CHVNFE = F1_CHVNFE
	And F3_FILIAL = F1_FILIAL
	And SF3.D_E_L_E_T_ = ''

	Left Join SFT010 SFT With(Nolock) -- Livros Fiscais 
	On FT_CHVNFE = F1_CHVNFE
	And FT_ITEM = D1_ITEM
	And FT_FILIAL = F1_FILIAL
	And FT_CLIEFOR = D1_FORNECE
	And FT_LOJA = D1_LOJA
	And SFT.D_E_L_E_T_ = ''

	Left Join SB2010 SB2 With(Nolock) -- Estoque 
	On B2_FILIAL = D1_FILIAL
	And B2_COD = D1_COD 
	And SB2.D_E_L_E_T_ = ''

	Left Join CC0010 CC0 With(NoLock)
	On CC0_FILIAL = GXG_FILIAL
	And CC0_CHVMDF = GXG_CTE
	And CC0.D_E_L_E_T_ = ''
	
Where GXG_FILIAL In ('01','02','03') --and F1_CHVNFE In ('','')--or GXG.GXG_CTE In ('')
And GXG_DTEMIS Between '20240101' and '20240131'
And GXG_EDISIT In ('2','3','5')
--And SF1.F1_EMISSAO Between '20240101' and '20240131'
--And GXG.GXG_CTE In ('35240120900554000152570010000160311000160317')
--And (F1_VALPEDG-GXG_PEDAG) > 0
--And SF1.F1_VALMERC <> SE2.E2_VALOR 
--And SE2.E2_BAIXA = '' and SE2.E2_SALDO > 0
--AND GXG.GXG_NRIMP IN ('4A095576264D4E11') 
--And F1_ESPECIE = 'CTE'
And GXG.D_E_L_E_T_ =''
Order By  1,2

/*
Select * From SF2010 SF2

	Inner Join SD2010 SD2
	On D2_DOC = F2_DOC
	And F2_FILIAL = F2_FILIAL
	and SD2.D_E_L_E_T_ =''

	Left Join ZZ9010 ZZ9 With(NoLock)
	On ZZ9_FILIAL = F2_FILIAL
	And ZZ9_DOC = F2_DOC
	And ZZ9_TRANSP = F2_TRANSP
	And ZZ9.D_E_L_E_T_ =''

Where F2_CHVNFE In ('50231102544042000208550010001420161322541756')
and SF2.D_E_L_E_T_ =''
*/

/*
Select * From GXH010 GXH
Where GXH_DANFE In ('50231102544042000208550010001420161322541756')
and GXH.D_E_L_E_T_ =''
*/

/*
Select * From ZZ9010 ZZ9

	Left Join SF2010 SF2 With(NoLock)
	On ZZ9_FILIAL = F2_FILIAL
	And ZZ9_DOC = F2_DOC
	And ZZ9_TRANSP = F2_TRANSP
	And ZZ9.D_E_L_E_T_ =''

	Left Join SD2010 SD2
	On D2_DOC = F2_DOC
	And F2_FILIAL = F2_FILIAL
	and SD2.D_E_L_E_T_ =''

	Where F2_CHVNFE In ('50231102544042000208550010001420161322541756')
and ZZ9.D_E_L_E_T_ =''
*/

/*
Select GXG_EDISIT ,* From GXG010 GXH
Where GXG_CTE In ('35231236291207000100570020000029761000750894')
--1=Importado;2=Importado com erro;3=Rejeitado;4=Processado;5=Erro Impeditivo
*/
