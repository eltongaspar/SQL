-- NF Entrada Cab. 
Select F1_CHVNFE,C00_STATUS,C00_CODEVE,C00_SITDOC,F1_DTLANC,F1_ORIGEM,F1_DOC,Isnull(A2_COD,'') A2_COD,Isnull(A2_NOME,'') A2_NOME,Isnull(A2_CGC,'') A2_CGC,
Isnull(A1_COD,'') A1_COD,Isnull(A1_NOME,'') A1_NOME,Isnull(A1_CGC,'') A1_CGC,
Isnull(COMP_CLI.M0_CGC,'') AS COMP_CLI_M0_CGC ,Isnull(COMP_FOR.M0_CGC,'') As COMP_FOR_M0_CGC,
F1_ESPECIE,SX5_TP.X5_DESCRI,F1_TIPO,D1_COD,D1_DESCRI,B1_TIPO, C00_STATUS,
Isnull(C1_NUM,'') As C1_NUM,Isnull(C8_NUM,'') As C8_NUM,Isnull(C7_NUM,'') As C7_NUM,D1_PEDIDO,B2_QATU,

	Case 
	When F1_ORIGEM = 'COMXCOL' Then 'AUTO_IMPORT'
	When F1_ORIGEM = 'AtuDocFr' Then 'AUTO_CTE'
	When F1_ORIGEM = 'cbcInTrC' Then 'AUTO_IND'
	Else 'MANUAL'
	End AS Status_,

FIN_SALDO = Isnull((Select Sum(E2_SALDO) From SE2010 SE2 -- Contas a Pagar 
					Where E2_FILIAL = F1_FILIAL
					And E2_NUM = F1_DOC
					And E2_FORNECE = F1_FORNECE
					And E2_LOJA = F1_LOJA
					And SE2.D_E_L_E_T_ = ''),0),

FIN_LIQUID = Isnull((Select Sum(E2_VALLIQ) From SE2010 SE2
					Where E2_FILIAL = F1_FILIAL
					And E2_NUM = F1_DOC
					And E2_FORNECE = F1_FORNECE
					And E2_LOJA = F1_LOJA
					And SE2.D_E_L_E_T_ = ''),0),
					
FIN_QTDE_SALDO = Isnull((Select Count(E2_SALDO) From SE2010 SE2
					Where E2_FILIAL = F1_FILIAL
					And E2_NUM = F1_DOC
					And E2_FORNECE = F1_FORNECE
					And E2_LOJA = F1_LOJA
					And E2_SALDO > 0 
					And E2_BAIXA = ''
					And SE2.D_E_L_E_T_ = ''),0),

FIN_QTDE_LIQUID = Isnull((Select Count(E2_SALDO) From SE2010 SE2
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
	End as STATUS_FISCAL_ITENS



From SF1010 SF1 With(Nolock)

	Left Join SA1010 SA1 With(Nolock) -- Clientes 
	On A1_COD = F1_FORNECE
	And A1_LOJA = F1_LOJA

	Left Join SA2010 SA2 With(Nolock) -- Fornecedores 
	On A2_COD = F1_FORNECE
	And A2_LOJA = F1_LOJA

	Left Join SX5010 SX5 With(Nolock)
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

	Left Join SB2010 SB2 With(Nolock) -- Estoque 
	On B2_FILIAL = D1_FILIAL
	And B2_COD = D1_COD 
	And B2_QATU > 0
	And SB2.D_E_L_E_T_ = ''

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
	
Where C00_STATUS In ('4')
And F1_CHVNFE <> ''
And F1_STATUS = ''
And F1_EMISSAO >= '20240101'
and SF1.D_E_L_E_T_ =''
Order By 2

/*O C00_CODEVE (Status do Evento), pode ter os seguintes conteúdos:

1 = Envio de Evento não realizado
2 = Envio de Evento realizado (Aguardando processamento)
3 = Evento vinculado com sucesso
4 = Evento rejeitado (Verifique o monitor para saber os motivos)
Já o C00_SITDOC (Situação do Documento), pode ter os seguintes conteúdos:

1 = Uso autorizado da NFe
2 = Uso denegado
3 = NFe cancelada*/