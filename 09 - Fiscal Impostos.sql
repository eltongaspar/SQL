--PIS Confins

Declare @FILDE Char(2), @FILATE Char(2), @DATADE Char(8), @DATAFIM Char(8), @CODFORNECDE Char(6), @CODFORNECFIM Char(6),
@NFNUMINI Char(6),@NFNUMFIM Char(6), @LOJADE Char(2), @LOJAATE Char(2)
Set @FILDE = '01' 
Set @FILATE = '03'
Set @DATADE = '20231201'
Set @DATAFIM = '20231231'
Set @CODFORNECDE = '000000'
Set @CODFORNECFIM  = '999999'
Set @NFNUMINI = '00000000'
Set @NFNUMFIM = '999999999'
Set @LOJADE = '00'
Set @LOJAATE = '99'


Select Distinct F1_FILIAL, F1_DOC,D1_ITEM,F1_FORNECE,F1_LOJA,A2_NOME,D1_COD,B1_DESC,B1_TIPO,SX5_TP.X5_DESCRI,B2_QATU,
F1_IRRF,F1_VALIRF,F1_VALPIS,F1_VALCOFI,F1_VALIMP5,F1_VALIMP6,F1_BASIMP5,F1_BASIMP6,F1_BASPIS,F1_BASCOFI, F1_CHVNFE,
D1_VALIMP5,D1_VALIMP6,D1_BASIMP5,D1_BASIMP6,D1_ALQIMP5,D1_ALQIMP6,D1_BASEIRR,D1_ALIQIRR,D1_VALIRR,D1_TES,D1_BASEPIS,D1_BASECOF,D1_VALPIS,D1_VALCOF,D1_ALQCOF,D1_ALQPIS
FT_BASEPIS,FT_BASECOF,FT_ALIQPIS,FT_ALIQCOF,FT_VALPIS,FT_VALCOF,
F1_ESPECIE,SX5_TP.X5_DESCRI,F1_TIPO,
D1_TES, F4_TEXTO,F4_ESTOQUE,
Isnull(A2_GRPTRIB,'') As A2_GRPTRIB , Isnull(B1_GRTRIB,'') As B1_GRTRIB,
Isnull(SF7_FORNEC.F7_GRPCLI,'') As F7_GRPCLI , Isnull(SF7_FORNEC.F7_GRTRIB,'') As F7_GRTRIB, Isnull(SX5_GRPTRIB.X5_DESCRI,'') As GRPTRIB_X5_DESCRI,
C7_NUM,C7_ITEM,C8_NUM,C8_ITEM,C1_NUM,C1_ITEM,
--CT2_HIST,CTK_HIST,CV3_HIST,

	Case 
		When F1_TIPO = 'N' Then 'NF Normal'
		When F1_TIPO = 'C' Then 'Compl. Preco'
		When F1_TIPO = 'D' Then 'Devolucao'
		When F1_TIPO = 'I' Then ' NF Compl. ICMS'
		When F1_TIPO = 'P' Then 'NF Compl. IPI'
		When F1_TIPO = 'B' Then 'NF Beneficiamento'
	End as TIPO,

	Case 
		When F1_ORIGEM = 'COMXCOL' Then 'AUTO_IMPORT'
		When F1_ORIGEM = 'AtuDocFr' Then 'AUTO_CTE'
		When F1_ORIGEM = 'cbcInTrC' Then 'AUTO_IND'
		Else 'MANUAL'
	End AS Status_ ,


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
		When C00_CHVNFE = '' Then 'Manifesto não Processado'
		When  C00_CHVNFE <> '' and C00_CODEVE = '1' Then 'Envio de Evento não realizado'
		When  C00_CHVNFE <> '' and C00_CODEVE = '2' Then 'Envio de Evento realizado (Aguardando processamento)'
		When  C00_CHVNFE <> '' and C00_CODEVE = '3' Then 'Evento vinculado com sucesso'
		When  C00_CHVNFE <> '' and C00_CODEVE = '4' Then 'vento rejeitado (Verifique o monitor para saber os motivos)'
		Else 'Verifivcar'
	End As Status_Evento,

	Case 
		When C00_CHVNFE = '' Then 'Manifesto não Processado'
		When  C00_CHVNFE <> '' and C00_SITDOC = '1' Then 'Uso autorizado da NFe'
		When  C00_CHVNFE <> '' and C00_SITDOC = '2' Then 'Uso denegado'
		When  C00_CHVNFE <> '' and C00_SITDOC = '3' Then 'NFe cancelada'
		Else 'Verifivcar'
	End As Status_SITUACAO_COC,

	
	Case 
		When DS_CHAVENF <> '' 
		Then 'PRE_NOTA'
		Else 'SEM_PRE_NOTA'
	End as STATUS_PRE_NOTA,

	Case 
		When F3_CHVNFE <> '' Then 'Livro Fiscal'
		Else 'Sem Livro Fiscal'
	End as STATUS_FISCAL,

	Case 
		When F3_CHVNFE <> '' Then 'Livro Fiscal Itens'
		Else 'Sem Livro Fiscal Itens'
	End as STATUS_FISCAL_ITENS,

	Case 
		When C7_RESIDUO  = 'S' and D1_PEDIDO <> ''
		Then 'Finalizado' 
		When  D1_PEDIDO = ''
		Then 'Sem PC'
		Else 'Aberto'
	End RESIDUO,

	Case 
		When C7_ENCER = 'E' and D1_PEDIDO <> ''
		Then 'Encerrado'
		When  D1_PEDIDO = ''
		Then 'Sem PC'
		Else 'Não Encerrado'
	End Encerrado

	/*Case 
		When CTK_SEQUEN <> '' Then 'Com Contra Prova Contab'
		Else 'Sem Contra Prova Contab'
	End as STATUS_FISCAL_ITENS_CTK,

	Case 
		When CT2_SEQUEN <> '' Then 'Com Lanc. Contabil'
		Else 'Sem Lanc.Contabil'
	End as STATUS_FISCAL_ITENS_CT2,

	Case 
		When CV3_SEQUEN <> '' Then 'Com Rastreamento Contab.'
		Else 'Sem Rastreamento Contab'
	End as STATUS_FISCAL_ITENS_CV3*/




From SF1010 SF1 With(Nolock)  -- NF Entrada Cab.

		Inner Join SD1010 SD1 With(Nolock)  -- NF Entrada Itens
		On F1_FILIAL = D1_FILIAL
		And F1_DOC = D1_DOC
		And F1_LOJA = D1_LOJA
		And F1_FORNECE = D1_FORNECE
		And F1_LOJA = D1_LOJA
		And SD1.D_E_L_E_T_ =''

		
		Inner Join SA2010 SA2 With(Nolock) -- Fornecedores 
		On A2_COD = F1_FORNECE
		And A2_LOJA = F1_LOJA
		And SA2.D_E_L_E_T_ = ''

		Inner Join SX5010 SX5 With(Nolock)
		On X5_FILIAL = F1_FILIAL
		And X5_TABELA = '42' --ESPECIES DE DOCUMENTOS FISCAIS                         
		And X5_CHAVE = F1_ESPECIE
		And SX5.D_E_L_E_T_ = ''

		Inner Join SB1010 SB1 With(Nolock) --Produtos 
		On D1_COD = B1_COD
		And SB1.D_E_L_E_T_ = ''
				
		Inner Join SB2010 SB2 With(Nolock) -- Estoque 
		On B2_FILIAL = D1_FILIAL
		And B2_COD = D1_COD 
		And SB2.D_E_L_E_T_ = ''
			   
		Inner Join SX5010 SX5_TP With(Nolock) -- Generica Tipo Produto 
		On SX5_TP.X5_TABELA = '02'
		And SX5_TP.X5_CHAVE = B1_TIPO
		And SX5_TP.D_E_L_E_T_ = ''
		And SX5_TP.X5_FILIAL = F1_FILIAL

		Left Join C00010 C00 With(Nolock) -- Manifesto do destinatario
		On C00_CHVNFE = F1_CHVNFE
		And C00_FILIAL = F1_FILIAL
		And C00.D_E_L_E_T_ = ''

		Left Join SDS010 SDS With(Nolock) -- Cabecalho importacao XML NF-e
		On DS_CHAVENF = F1_CHVNFE
		And DS_FILIAL = F1_FILIAL 
		And SDS.D_E_L_E_T_ = ''

		Left Join SDT010 SDT With(Nolock) --Itens importacao XML NF-e
		On DT_FILIAL = DS_FILIAL
		And DT_DOC = DS_DOC
		And DT_FORNEC = DS_FORNEC
		And DT_LOJA = DS_LOJA
		And DT_ITEM = D1_ITEM
		And SDT.D_E_L_E_T_ = ''

		Left Join SF4010 SF4 With(Nolock) -- TES
		On D1_TES = F4_CODIGO
		and SF4.D_E_L_E_T_ =''

		Left Join SF3010 SF3 With(Nolock) -- Livros Fiscais 
		On F3_CHVNFE = F1_CHVNFE
		And F3_FILIAL = F1_FILIAL
		And F3_CLIEFOR = F1_FORNECE
		And F3_LOJA = F1_LOJA
		And SF3.D_E_L_E_T_ = ''

		Left Join SFT010 SFT With(Nolock) -- Livros Fiscais 
		On FT_CHVNFE = F1_CHVNFE
		And FT_ITEM = D1_ITEM
		And FT_FILIAL = D1_FILIAL
		And FT_CLIEFOR = D1_FORNECE
		And FT_LOJA = D1_LOJA
		And SFT.D_E_L_E_T_ = ''

		LEFT Join SC7010 SC7 With(Nolock) -- PC
		ON SD1.D1_FILIAL = C7_FILIAL
		And SD1.D1_PEDIDO = C7_NUM
		And SD1.D1_ITEMPC = C7_ITEM
		And SD1.D_E_L_E_T_ = ''

		Left Join SC8010 SC8 With(Nolock) -- Cotacao
		On C8_FILIAL = C7_FILIAL 
		And C8_NUMPED = C7_NUM 
		And C8_ITEMPED = C7_ITEM
		And SC8.D_E_L_E_T_ = ''

		Left Join SC1010 SC1 With(Nolock) -- SC
		On C1_FILIAL = C7_FILIAL 
		And C1_PEDIDO = C7_NUM
		And C1_ITEMPED = C7_ITEM 
		And SC1.D_E_L_E_T_ = ''

		
		Left Join SD3010 SD3 With(Nolock) --Mov.Internos 
		On D3_FILIAL = D1_FILIAL 
		And D3_COD = D1_COD
		And D3_DOC = F1_DOC
		And D3_EMISSAO Between @DATADE and @DATAFIM
		And SD3.D_E_L_E_T_ = ''

		Left Join SF5010 SF5 With(Nolock) -- Tipos de Movimentos 
		On D3_TM = F5_CODIGO 
		And SF5.D_E_L_E_T_ = ''

		/*Left Join CT2010 CT2 With(Nolock) -- Lanc. Contabeis
		On CT2_FILIAL = F1_FILIAL
		And SubString(CT2_ITEMC,2,6) = F1_FORNECE
		And SubString(CT2_ITEMC,8,2) = F1_LOJA
		--And CT2_LOTE = '008810'
		--And CT2_SBLOTE = '001'
		--And CT2_HIST Like ('FRETE%')
		--And CT2_VALOR = F1_VALBRUT
		And CT2_DATA Between @DATADE and @DATAFIM
		And SubString(CT2_KEY,3,9) = REPLICATE('0', 9 - LEN(F1_DOC)) + RTrim(F1_DOC)
		And CT2.D_E_L_E_T_ = ''

		Left Join CTK010 CTK With(Nolock) -- Lanc. Contabeis
		On CTK_SEQUEN = CT2_SEQUEN
		And CTK_DATA Between @DATADE and @DATAFIM
		And CTK.D_E_L_E_T_ = ''

		Left Join CV3010 CV3 With(Nolock) --CV3 - Rastreamento Lancamento
		On CV3_SEQUEN = CT2_SEQUEN
		And CV3_DTSEQ Between @DATADE and @DATAFIM
		And CV3.D_E_L_E_T_ = ''*/

		Left Join SF7010 SF7_PRODUT
		On SF7_PRODUT.F7_FILIAL = SF1.F1_FILIAL
		And SF7_PRODUT.F7_GRPCLI = B1_GRTRIB 
		And SF7_PRODUT.D_E_L_E_T_ = ''

		Left Join SF7010 SF7_FORNEC
		On SF7_FORNEC.F7_FILIAL = SF1.F1_FILIAL
		And SF7_FORNEC.F7_GRPCLI = A2_GRPTRIB 
		And SF7_FORNEC.D_E_L_E_T_ = ''

		Left Join SX5010 SX5_GRPTRIB
		On SX5_GRPTRIB.X5_TABELA = '21'
		And SX5_GRPTRIB.X5_CHAVE = SF7_FORNEC.F7_GRTRIB
		And SX5_GRPTRIB.D_E_L_E_T_ = ''
	   
Where (F1_VALPIS > 0 and F1_VALCOFI > 0)
And F1_EMISSAO Between @DATADE and @DATAFIM
And SF1.D_E_L_E_T_ = ''
Order By 1,2

