-- NF Entrada Cab.
Select F1_DOC,Isnull(A2_COD,'') A2_COD,Isnull(A2_NOME,'') A2_NOME,Isnull(A2_CGC,'') A2_CGC,
Isnull(A1_COD,'') A1_COD,Isnull(A1_NOME,'') A1_NOME,Isnull(A1_CGC,'') A1_CGC,
Isnull(COMP_CLI.M0_CGC,'') AS COMP_CLI_M0_CGC ,Isnull(COMP_FOR.M0_CGC,'') As COMP_FOR_M0_CGC,
F1_ESPECIE,SX5_TP.X5_DESCRI,F1_TIPO,D1_COD,D1_DESCRI,B1_TIPO, C00_STATUS,
Isnull(C1_NUM,'') As C1_NUM,Isnull(C8_NUM,'') As C8_NUM,Isnull(C7_NUM,'') As C7_NUM,D1_PEDIDO,B2_QATU,

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
	And SF3.D_E_L_E_T_ = ''

	Left Join SFT010 SFT With(Nolock) -- Livros Fiscais 
	On FT_CHVNFE = F1_CHVNFE
	And FT_ITEM = D1_ITEM
	And FT_FILIAL = F1_FILIAL
	And FT_CLIEFOR = D1_FORNECE
	And FT_LOJA = D1_LOJA
	And SFT.D_E_L_E_T_ = ''

	Left Join SE2010 SE2
	On E2_FILIAL = F1_FILIAL
	And E2_FORNECE = F1_FORNECE
	And E2_LOJA = F1_LOJA
	And E2_NUM = F1_DOC 
	And SE2.D_E_L_E_T_ = ''
	
Where A2_CGC In ('53113791000122','28644310000168','9013750000000','05607657001026','46156377000135','03037365000189') 
And E2_BAIXA Between '20240201' and '20240229'
and SF1.D_E_L_E_T_ =''


--Contas a pagar x NF Entrada
Select E2_NUM,E2_FORNECE,E2_NOMFOR,D1_COD,D1_COD,B1_DESC,
E2_BASECOF,F1_VALBRUT,E2_VALOR,E2_VALLIQ,
E2_ISS,E2_IRRF,E2_PIS,E2_INSS,E2_COFINS,E2_CSLL,
E2_VRETISS,E2_VRETIRF,E2_VRETPIS,E2_VRETINS,E2_VRETCOF,E2_VRETCSL,		
E2_DESCONT,E2_ACRESC,E2_DECRESC,
F1_ICMS,F1_VALIMP5,F1_VALIMP6,F1_INSS,F1_ISS,F1_VALPIS,F1_VALCOFI,F1_VALCSLL,F1_VALIRF,
F1_ICMSRET,F1_IRRF,
(E2_VRETISS+E2_VRETIRF+E2_VRETPIS+E2_VRETINS+E2_VRETCOF+E2_VRETCSL) As IMP_RET,
(F1_ISS+F1_VALIRF+F1_INSS) As IMP_FISCAL,
(E2_PIS+E2_COFINS+E2_CSLL) As IMP_BASE,
(F1_VALPIS+F1_VALCOFI+F1_VALCSLL) as IMP_BASE_FISCAL,
X5_DESCRI,F1_DOC,
* From SE2010 SE2 -- Contas a pagar

	--Genericas
	Left Join SX5010 SX5
	On  X5_TABELA = '05'
	And X5_FILIAL = E2_FILIAL
	And E2_TIPO = X5_CHAVE
	And SX5.D_E_L_E_T_ = ''

	--NF Entrada Cab.
	Left Join SF1010 SF1
	On F1_FILIAL = E2_FILIAL
	And F1_DOC = E2_NUM
	And F1_FORNECE = E2_FORNECE
	And F1_LOJA = E2_LOJA
	And SF1.D_E_L_E_T_ = ''


	--NF Entrada Itens
	Left Join SD1010 SD1
	On D1_FILIAL = F1_FILIAL
	And D1_DOC = F1_DOC
	And D1_FORNECE = F1_FORNECE
	And D1_LOJA = F1_LOJA
	And SD1.D_E_L_E_T_ = ''

	Inner Join SB1010 SB1 --Produtos 
	On B1_COD = D1_COD
	And SB1.D_E_L_E_T_ = ''

	   
Where E2_FORNECE In ('V00335') and E2_NUM = '000020309'
and SE2.D_E_L_E_T_ = ''
Order By E2_TIPO



-- Contas a Pagar x Caixa x NF Entrada Cab/Itens x TES x Genericas x Natureza Rendimentos 
Select IsNull(SX5F1.X5_DESCRI,'') As DESC_ESPECIE,IsNull(SX5E2.X5_DESCRI,'') As DESC_TIPO,E2_TIPO,
IsNull(D1_COD,'') As D1_COD,IsNull(B1_DESC,'') As B1_DESC ,
IsNull(FKX_DESCR,'') As NATREND_DESC,IsNull(DHR_NATREN,'') NATREND_COD,
E2_NUM,IsNull(ZM_NUMERO,'') AS ZM_NUMERO,E2_FORNECE,E2_NOMFOR,E2_VALOR,E2_SALDO,E2_VALLIQ,E2_BAIXA,IsNull(F1_VALBRUT,'') As F1_VALBRUT,
(E2_VALLIQ-E2_VALOR) As DIF_LIQ, (E2_VRETISS+E2_VRETIRF+E2_VRETINS) As IMP_RET,
(E2_PIS+E2_COFINS+E2_CSLL) As IMP_BASE,
E2_VRETPIS,E2_VRETCOF,E2_VRETCSL,E2_VRETISS,E2_VRETIRF,E2_VRETINS,
IsNull(D1_TES,'') As TES, IsNulL(F4_TEXTO,'') As F4_TEXTO
From SE2010 SE2 -- Contas a pagar 

	-- NF Entrada Cab.
	Left Join SF1010 SF1
	On F1_FILIAL = E2_FILIAL
	And F1_FORNECE = E2_FORNECE
	And F1_LOJA = E2_LOJA
	And F1_DOC = E2_NUM
	And SF1.D_E_L_E_T_ = ''

	-- NF Entrada Itens 
	Left Join SD1010 SD1
	On D1_FILIAL = F1_FILIAL
	And D1_FORNECE = F1_FORNECE
	And D1_LOJA = F1_LOJA
	And D1_DOC = F1_DOC
	And SD1.D_E_L_E_T_ = ''

	--TES
	Left Join SF4010 SF4
	On F4_CODIGO = D1_TES
	And SF4.D_E_L_E_T_ = ''

	-- Genericas
	Left Join SX5010 SX5F1
	On SX5F1.X5_TABELA = '42'
	And SX5F1.X5_FILIAL = F1_FILIAL
	And SX5F1.X5_CHAVE = F1_ESPECIE
	And SX5F1.D_E_L_E_T_ = ''

	-- Genericas 
	Left Join SX5010 SX5E2
	On SX5E2.X5_TABELA = '05'
	And SX5E2.X5_FILIAL = E2_FILIAL
	And SX5E2.X5_CHAVE = E2_TIPO
	And SX5E2.D_E_L_E_T_ = ''

	-- Caixa
	Left Join SZM010 SZM
	On ZM_FILIAL = E2_FILIAL
	And ZM_FORNEC = E2_FORNECE
	And ZM_LOJA = E2_LOJA
	And ZM_NUMERO = E2_NUM
	And ZM_PREFIXO = E2_PREFIXO
	And ZM_PARCELA = E2_PARCELA
	And ZM_TIPO = E2_TIPO
	And SZM.D_E_L_E_T_ = ''

	Left Join SB1010 SB1 --Produtos 
	On B1_COD = D1_COD
	And SB1.D_E_L_E_T_ = ''

	Left Join DHR010 DHR --NF x Natureza Rendimentos 
	On DHR_FILIAL = F1_FILIAL
	And DHR_FORNEC = F1_FORNECE
	And DHR_LOJA = F1_LOJA
	And DHR_DOC = F1_DOC
	And DHR_SERIE = F1_SERIE
	And DHR.D_E_L_E_T_ = ''

	Left Join FKX010 FKX
	On FKX_CODIGO = DHR_NATREN
	And FKX.D_E_L_E_T_ = ''
	

Where E2_FILIAL In ('01','02','03')
And E2_TIPO In ('ISS','TX','IRF','NF')
And E2_TIPO = 'NF'
And E2_FORNECE In ('V00A1C','V00AGK','VOOCE3','VOP001','V00247','MUNIC','UNIAO')
--And (E2_PIS+E2_COFINS+E2_CSLL) > 0
And E2_EMISSAO Between ('20231201') and ('20240229')
And E2_BAIXA Between ('20231201')  and ('20240229')
And E2_NUM In ('5370','41539','00033284','00000116','03752118')
and SE2.D_E_L_E_T_ = ''
Order By 6,7



--Fornecedor 
Select A2_CGC,* From SA2010
Where A2_CGC In ('53113791000122','28644310000168','9013750000000','05607657001026','46156377000135','03037365000189')
and D_E_L_E_T_ = ''

--NF Entrada 
Select * From SF1010
Where F1_FORNECE = 'V00247'
And F1_EMISSAO >= '20230101'
--And F1_DOC = '41539'
and D_E_L_E_T_ = ''
Order By F1_DOC

--Natureza de Rendimentos 
Select FKX_DESCR,* From DHR010 DHR
	Inner Join FKX010 FKX
	On FKX_CODIGO = DHR_NATREN
	And FKX.D_E_L_E_T_ = ''
	
Where DHR_FILIAL = '01' and DHR_FORNEC = 'V00A1C' --and DHR_DOC = '5370'
and DHR.D_E_L_E_T_ = ''


-- Contas a pagar 	
Select E2_TITPAI,E2_PIS,E2_COFINS,E2_CSLL,E2_VALOR,E2_BAIXA,E2_SALDO,* From SE2010
Where E2_FILIAL In ('01','02','03')
And E2_TIPO In ('ISS','TX','IRF','NF')
--And E2_TIPO = 'NF'
And E2_FORNECE In ('V00A1C','V00AGK','VOOCE3','VOP001','V00247','MUNIC','UNIAO')
--And (E2_PIS+E2_COFINS+E2_CSLL) > 0
And E2_EMISSAO Between ('20231201') and ('20240229')
--And E2_BAIXA Between ('20231201')  and ('20240229')
And E2_NUM In ('00033284')
--And E2_TITPAI <> ''
and D_E_L_E_T_ = ''
Order By E2_NUM

--FKX (Naturezas de Rendimento)
Select ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), FKX_DESEXT)),'') AS FKX_DESEXT,
* From FKX010


--Parametros
Select X6_FIL,X6_VAR,X6_DESCRIC,X6_DESC1,X6_DESC2,X6_CONTEUD,* From SX6010
Where X6_VAR In ('MV_BX10925','MV_RT10925')
and D_E_L_E_T_ = ''
