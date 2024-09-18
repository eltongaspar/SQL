-- NF Entrada Cab. - Custos CTE

Select Distinct  (Select Distinct F1_DOC), F1_VALBRUT,
Isnull(A2_COD,'') A2_COD,Isnull(A2_LOJA,'') A2_LOJA,Isnull(A2_NOME,'') A2_NOME,Isnull(A2_CGC,'') A2_CGC,
SubString(CT2_ITEMC,2,6) AS FORNEC_CONTAB,SubString(CT2_ITEMC,8,2) As LOJA_CONTAB,
Isnull(A1_COD,'') A1_COD,Isnull(A1_NOME,'') A1_NOME,Isnull(A1_CGC,'') A1_CGC,
Isnull(COMP_CLI.M0_CGC,'') AS COMP_CLI_M0_CGC ,Isnull(COMP_FOR.M0_CGC,'') As COMP_FOR_M0_CGC,
F1_ESPECIE,SX5_TP.X5_DESCRI,F1_TIPO,D1_COD,D1_DESCRI,B1_TIPO, C00_STATUS,
Isnull(C1_NUM,'') As C1_NUM,Isnull(C8_NUM,'') As C8_NUM,Isnull(C7_NUM,'') As C7_NUM,D1_PEDIDO,B2_QATU,
D1_COD,F4_TEXTO,F4_ESTOQUE,
Isnull(D3_DOC,0) As D3_DOC,
Isnull(D3_TM,'') As D3_TM ,Isnull(F5_TEXTO,'') As F5_TEXTO, Isnull(F5_TIPO,'') As F5_TIPO,
D1_TES, F4_TEXTO,
Isnull(A1_GRPTRIB,'') As A1_GRPTRIB, Isnull(A2_GRPTRIB,'') As A2_GRPTRIB , Isnull(B1_GRTRIB,'') As B1_GRTRIB,
Isnull(SF7_FORNEC.F7_GRPCLI,'') As F7_GRPCLI , Isnull(SF7_FORNEC.F7_GRTRIB,'') As F7_GRTRIB, Isnull(SX5_GRPTRIB.X5_DESCRI,'') As GRPTRIB_X5_DESCRI,
CT2_HIST,CTK_HIST,CV3_HIST,

FIN_SALDO = Isnull((Select Sum(E2_SALDO) From SE2010 SE2 With(Nolock) -- Contas a Pagar 
					Where E2_FILIAL = F1_FILIAL
					And E2_NUM = F1_DOC
					And E2_FORNECE = F1_FORNECE
					And E2_LOJA = F1_LOJA
					And SE2.D_E_L_E_T_ = ''),0),

FIN_LIQUID = Isnull((Select Sum(E2_VALLIQ) From SE2010 SE2 With(Nolock)
					Where E2_FILIAL = F1_FILIAL
					And E2_NUM = F1_DOC
					And E2_FORNECE = F1_FORNECE
					And E2_LOJA = F1_LOJA
					And SE2.D_E_L_E_T_ = ''),0),
					
FIN_QTDE_SALDO = Isnull((Select Count(E2_SALDO) From SE2010 SE2 With(Nolock)
					Where E2_FILIAL = F1_FILIAL
					And E2_NUM = F1_DOC
					And E2_FORNECE = F1_FORNECE
					And E2_LOJA = F1_LOJA
					And E2_SALDO > 0 
					And E2_BAIXA = ''
					And SE2.D_E_L_E_T_ = ''),0),

FIN_QTDE_LIQUID = Isnull((Select Count(E2_SALDO) From SE2010 SE2 With(Nolock)
					Where E2_FILIAL = F1_FILIAL
					And E2_NUM = F1_DOC
					And E2_FORNECE = F1_FORNECE
					And E2_LOJA = F1_LOJA
					And E2_SALDO = 0 
					And E2_BAIXA <> ''
					And SE2.D_E_L_E_T_ = ''),0),
	
	Case When COMP_CLI.M0_CGC= A1_CGC 
	Then 'VALIDADO'
	Else 'ERROR'
	End as VALID_CLI,

	Case When COMP_FOR.M0_CGC= A2_CGC 
	Then 'VALIDADO'
	Else 'ERROR'
	End as VALID_FOR,

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
	When C00_CHVNFE = '' Then 'Manifesto não Processado'
	When  C00_CHVNFE <> '' and C00_CODEVE = '1' Then 'Envio de Evento não realizado'
	When  C00_CHVNFE <> '' and C00_CODEVE = '2' Then 'Envio de Evento realizado (Aguardando processamento)'
	When  C00_CHVNFE <> '' and C00_CODEVE = '3' Then 'Evento vinculado com sucesso'
	When  C00_CHVNFE <> '' and C00_CODEVE = '4' Then 'Evento rejeitado (Verifique o monitor para saber os motivos)'
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
	End Encerrado,

	Case When F3_CHVNFE <> '' Then 'Livro Fiscal'
	Else 'Sem Livro Fiscal'
	End as STATUS_FISCAL,

	Case When F3_CHVNFE <> '' Then 'Livro Fiscal Itens'
	Else 'Sem Livro Fiscal Itens'
	End as STATUS_FISCAL_ITENS,

	Case When CTK_SEQUEN <> '' Then 'Com Contra Prova Contab'
	Else 'Sem Contra Prova Contab'
	End as STATUS_FISCAL_ITENS,

	Case When CT2_SEQUEN <> '' Then 'Com Lanc. Contabil'
	Else 'Sem Lanc.Contabil'
	End as STATUS_FISCAL_ITENS,

	Case When CV3_SEQUEN <> '' Then 'Com Rastreamento Contab.'
	Else 'Sem Rastreamento Contab'
	End as STATUS_FISCAL_ITENS



From SF1010 SF1 With(Nolock) -- NF Entrada Cab.

	Left Join SA1010 SA1 With(Nolock) -- Clientes 
	On A1_COD = F1_FORNECE
	And A1_LOJA = F1_LOJA

	Left Join SA2010 SA2 With(Nolock) -- Fornecedores 
	On A2_COD = F1_FORNECE
	And A2_LOJA = F1_LOJA

	Inner Join SX5010 SX5 With(Nolock)
	On X5_FILIAL = F1_FILIAL
	And X5_TABELA = '42' --ESPECIES DE DOCUMENTOS FISCAIS                         
	And X5_CHAVE = F1_ESPECIE
	And SX5.D_E_L_E_T_ = ''

	Left Join SYS_COMPANY COMP_CLI With(Nolock) -- Filiais 
	On COMP_CLI.M0_CGC = A1_CGC
	And COMP_CLI.D_E_L_E_T_ = ''

	Left Join SYS_COMPANY COMP_FOR With(Nolock) -- Filiais 
	On COMP_FOR.M0_CGC = A2_CGC
	And COMP_FOR.D_E_L_E_T_ = ''

	Left Join SD1010 SD1 With(Nolock) -- NF Sadia Itens
	On D1_FILIAL = F1_FILIAL
	And D1_FORNECE = F1_FORNECE
	And D1_LOJA = F1_LOJA  
	And D1_DOC = F1_DOC
	And SD1.D_E_L_E_T_ = ''

	Inner Join SB1010 SB1 With(Nolock) --Produtos 
	On D1_COD = B1_COD
	And SB1.D_E_L_E_T_ = ''

	Inner Join SX5010 SX5_TP With(Nolock) -- Generica Tipo Produto 
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

	Left Join C00010 C00 With(Nolock) -- Manifesto do destinatario
	On C00_CHVNFE = F1_CHVNFE
	And C00.D_E_L_E_T_ = ''

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

	Inner Join SB2010 SB2 With(Nolock) -- Estoque 
	On B2_FILIAL = D1_FILIAL
	And B2_COD = D1_COD 
	And SB2.D_E_L_E_T_ = ''

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

	Inner Join SF4010 SF4 With(Nolock) -- TES
	On D1_TES = F4_CODIGO
	and SF4.D_E_L_E_T_ =''

	Left Join SD3010 SD3 With(Nolock) --Mov.Internos 
	On D3_FILIAL = D1_FILIAL 
	And D3_COD = D1_COD
	And D3_DOC = F1_DOC
	And SD3.D_E_L_E_T_ = ''

	Left Join SF5010 SF5 With(Nolock) -- Tipos de Movimentos 
	On D3_TM = F5_CODIGO 
	And SF5.D_E_L_E_T_ = ''
	
	Left Join CT2010 CT2 With(Nolock) -- Lanc. Contabeis
	On CT2_FILIAL = F1_FILIAL
	And SubString(CT2_ITEMC,2,6) = F1_FORNECE
	--And SubString(CT2_ITEMC,8,2) = F1_LOJA
	--And CT2_LOTE = '008810'
	--And CT2_SBLOTE = '001'
	--And CT2_HIST Like ('FRETE%')
	--And CT2_VALOR = F1_VALBRUT
	And SubString(CT2_KEY,3,9) = REPLICATE('0', 9 - LEN(F1_DOC)) + RTrim(F1_DOC)
	And CT2.D_E_L_E_T_ = ''

	Left Join CTK010 CTK With(Nolock) -- Lanc. Contabeis
	On CTK_SEQUEN = CT2_SEQUEN
	And CTK.D_E_L_E_T_ = ''

	Left Join CV3010 CV3 With(Nolock) --CV3 - Rastreamento Lancamento
	On CV3_SEQUEN = CT2_SEQUEN
	And CV3.D_E_L_E_T_ = ''

	Left Join SF7010 SF7_CLI 
	On SF7_CLI.F7_FILIAL = SF1.F1_FILIAL
	And SF7_CLI.F7_GRPCLI = A1_GRPTRIB 
	And SF7_CLI.D_E_L_E_T_ = ''

	Left Join SF7010 SF7_FORNEC
	On SF7_FORNEC.F7_FILIAL = SF1.F1_FILIAL
	And SF7_FORNEC.F7_GRPCLI = A2_GRPTRIB 
	And SF7_FORNEC.D_E_L_E_T_ = ''

	Left Join SF7010 SF7_PRODUT
	On SF7_PRODUT.F7_FILIAL = SF1.F1_FILIAL
	And SF7_PRODUT.F7_GRPCLI = B1_GRTRIB 
	And SF7_PRODUT.D_E_L_E_T_ = ''

	Left Join SX5010 SX5_GRPTRIB
	On SX5_GRPTRIB.X5_TABELA = '21'
	And SX5_GRPTRIB.X5_CHAVE = SF7_FORNEC.F7_GRTRIB
	And SX5_GRPTRIB.D_E_L_E_T_ = ''


Where F1_CHVNFE = '35240550222363000140550010000168381320081065'
--F1_ESPECIE = 'CTE' and F1_FORNECE In ('VOPACJ','VOP004') 
And F1_EMISSAO Between '20240501' and '20240531'
And SF1.D_E_L_E_T_ = ''
Order By 1

