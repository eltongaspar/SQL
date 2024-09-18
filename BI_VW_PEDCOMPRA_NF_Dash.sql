--USE [IFC_P12]
--GO

/****** Object:  View [dbo].[BI_VW_PEDCOMPRA_NF_DASH_EMERG]    Script Date: 13/05/2024 11:00:18 ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO


--ALTER VIEW [dbo].[BI_VW_PEDCOMPRA_NF_DASH_EMERG]
--AS



Select 

	/*------------------------------------*/
	/*CHAVES PARA LIGAR COM OUTRAS TABELAS*/
	/*------------------------------------*/

	RTRIM(LTRIM(ISNULL(C7_FILIAL,'')))														As CH_FILIAL,
	RTRIM(LTRIM(ISNULL(C7_FORNECE,'')))+'-'+RTRIM(LTRIM(ISNULL(C7_LOJA,'')))				As CH_FORNECELOJA,
	RTRIM(LTRIM(ISNULL(C7_PRODUTO,'')))														As CH_PRODUTO,
	RTRIM(LTRIM(ISNULL(C7_CC,'')))															As CH_CC,
	RTRIM(LTRIM(ISNULL(C7_FILIAL,'')))+'-'+RTRIM(LTRIM(ISNULL(C7_NUM,'')))+'-'+
			RTRIM(LTRIM(ISNULL(C7_PRODUTO,'')))+'-'+RTRIM(LTRIM(ISNULL(C7_ITEM,'')))	    As CH_FILIALPEDIDO,		/*Pedido de Compras*/
	RTRIM(LTRIM(ISNULL(C7_FILIAL,'')))+'-'+RTRIM(LTRIM(ISNULL(C7_NUMSC,'')))+'-'+
			RTRIM(LTRIM(ISNULL(C7_PRODUTO,'')))+'-'+RTRIM(LTRIM(ISNULL(C7_ITEMSC,'')))		As CH_FILIALSC,			/*Solicitacao de Compras*/
	RTRIM(LTRIM(ISNULL(C7_FILIAL,'')))+'-'+RTRIM(LTRIM(ISNULL(C7_NUMCOT,'')))+'-'+
			RTRIM(LTRIM(ISNULL(C7_PRODUTO,'')))												As CH_FILIALCOTACAO,	/*Coatcao de Compras*/

	/*------------------------------------*/
	--Dados
	RTRIM(LTRIM(ISNULL(C7_PRODUTO,'')))						As PRODUTO_CODIGO,
	RTRIM(LTRIM(ISNULL(C7_DESCRI, '')))						AS PRODUTO_NOME,
	RTRIM(LTRIM(ISNULL(C7_NUM, '')))						AS PC_NUM,
	RTRIM(LTRIM(ISNULL(C1_NUM, '')))						As SC_NUM,
	RTRIM(LTRIM(ISNULL(C8_NUM, '')))						As COT_NUM,
	RTRIM(LTRIM(ISNULL(C7_ITEM, '')))						As PC_ITEM,
	RTRIM(LTRIM(ISNULL(C1_ITEM, '')))						As SC_ITEM,
	RTRIM(LTRIM(ISNULL(C8_ITEM, '')))						As COT_ITEM,
	RTRIM(LTRIM(ISNULL(C7_NUMSC, '')))						As PC_SC_NUM,
	RTRIM(LTRIM(ISNULL(C7_NUMCOT, '')))						As PC_COT_NUM,
	RTRIM(LTRIM(ISNULL(D1_DOC, '')))						AS NF_NUMERO,
	RTRIM(LTRIM(ISNULL(D1_ITEM, '')))						AS NF_ITEM,
	RTRIM(LTRIM(ISNULL(D1_PEDIDO, '')))						As NF_NUM_PC,
	RTRIM(LTRIM(ISNULL(D1_ITEMPC, '')))						As NF_ITEM_PC,
	
	--Qtdes
	(ISNULL(C7_QUANT, 0))									AS PC_QTDE,
	(ISNULL(C7_QUJE, 0))									AS QTDE_ENTREGUE,
	(ISNULL(D1_QUANT, 0))									AS NF_QTDE,
	(ISNULL(C7_QTDSOL, 0))									AS SOLICITACAO_QTDE,
	(C7_QUANT - Isnull(D1_QUANT,0))							As SALDO_PC_NF,
	(C7_QUANT - Isnull(C7_QUJE,0))							As SALDO_PC,

	--Datas
	Case
		When C7_EMISSAO <> '' 
		Then 
			RTRIM(LTRIM(ISNULL(Cast(C7_EMISSAO as date), '')))
	End														As PC_DATA,
	
	Case
		When CR_DATALIB <> ''
		Then
			RTRIM(LTRIM(ISNULL(Cast(CR_DATALIB as date), '')))
		Else ''
	End														As DATA_LIBERACAO,

	Case
		When D1_DTDIGIT <> ''
		Then 
			RTRIM(LTRIM(ISNULL(Cast(D1_DTDIGIT as date), '')))
		Else ''
	End														As NF_DATA,

	Case
		When C1_EMISSAO <> ''
		Then
			RTRIM(LTRIM(ISNULL(Cast(C1_EMISSAO as date), '')))
		Else ''
	End														As SC_DATA,

	Case
		When C8_EMISSAO <> ''
		Then 
			RTRIM(LTRIM(ISNULL(Cast(C8_EMISSAO as date), '')))
		Else ''
	End													As COTACAO_DATA,

	Case
		When C7_DATPRF <> ''
		Then
			RTRIM(LTRIM(ISNULL(Cast(C7_DATPRF as date), '')))
		Else ''
	End														As PC_DATA_NECESSIDADE,

	DateDiff(Day,Max(C7_DATPRF),Getdate())					As DIAS_ATRASO_PC,
	Isnull(DateDiff(Day,Max(D1_DTDIGIT),C7_DATPRF),'')		As DIAS_ATRASO_NF,
	Isnull(DateDiff(Day,Max(C7_EMISSAO),CR_DATALIB),'')		As DIAS_LIB,

	--Dados
	RTRIM(LTRIM(ISNULL(C7_CC, '')))							As PC_CC,
	RTRIM(LTRIM(ISNULL(D1_CC, '')))							As NF_CC,
	RTRIM(LTRIM(ISNULL(CTT_DESC01, '')))					As PC_CC_NOME,
	RTRIM(LTRIM(ISNULL(C7_FORNECE, '')))					As FORNECEDOR,
	RTRIM(LTRIM(ISNULL(A2_NOME, '')))						As FORNECEDOR_NOME,
	RTRIM(LTRIM(ISNULL(CR_LIBAPRO, '')))					As APROVADOR_CODIGO,
	RTRIM(LTRIM(ISNULL(AK_NOME, '')))						As APROVADOR_NOME,
	RTRIM(LTRIM(ISNULL(C7_USER, '')))						As USER_COD,
	RTRIM(LTRIM(ISNULL(C7_COMPRA, '')))						As COMPRADOR_COD,
	RTRIM(LTRIM(ISNULL(Y1_NOME, '')))						As COMPRADOR_NOME,
	RTRIM(LTRIM(ISNULL(C7_COND, '')))						As PC_CONDICAO_PAG,
	RTRIM(LTRIM(ISNULL(SE4.E4_DESCRI, '')))					As PC_CONDICAO_PAG_DESCRICAO,
	RTRIM(LTRIM(ISNULL(F1_COND, '')))						As NF_CONDICAO_PAG,
	RTRIM(LTRIM(ISNULL(SE4_SF1.E4_DESCRI, '')))				As NF_CONDICAO_PAGAMENTO_NOME,
	RTRIM(LTRIM(ISNULL(C7_OBS, '')))						As PC_OBS,

	--Valores
	(ISNULL(C7_PRECO, 0))									As PC_PRECO,
	(ISNULL(C7_TOTAL, 0))									As PC_VALOR_TOTAL_ITEM,
	(ISNULL(D1_TOTAL, 0))									As NF_VALOR_TOTAL_ITEM,
	(ISNULL(D1_VUNIT, 0))									As NF_VALOR_UNIARIO,
	(ISNULL(D1_CUSTO, 0))									As NF_CUSTO_MEDIO,

	--Dados
	RTRIM(LTRIM(ISNULL(C1_SOLICIT, '')))					As SOLICITANTE,
	
	   	 	
	Case 
		When C7_QUANT = (C7_QUJE+C7_QTDACLA)
			Then 'Entregue'
		When (C7_QUJE+C7_QTDACLA) < C7_QUANT and C7_DATPRF < Getdate()
			Then 'No prazo'
		When (C7_QUJE+C7_QTDACLA) < C7_QUANT and C7_DATPRF > Getdate()
			Then 'Em atraso'
		Else 'Sem NF'
	End as DATA_ENT,

	Case 
	When C7_ENCER = 'E'  Then 'Encerrado'
	When C7_ENCER = ' '  Then 'Nao Encerrado'
	Else 'Verificar'
	End AS Status_ENC,

	Case 
	When C7_RESIDUO = 'S'  Then 'Eliminado'
	When C7_RESIDUO = ' '  Then 'Nao Eliminado'
	Else 'Verificar'
	End AS Status_RES,
	   
	Case 
	When C7_CONAPRO = 'B' Then 'BLOQ'
	When C7_CONAPRO = 'L' Then 'LIB'
	When C7_CONAPRO = 'R' Then 'REJ'
	Else 'VERIFICAR'
	End As STATUS_LIB,

	CASE 
		WHEN C7_QUJE = 0 AND C7_QTDACLA = 0 AND C7_CONAPRO <> 'B' AND C7_TIPO =1 AND C7_RESIDUO = ''
			THEN 'Pendente'
		WHEN C7_QUJE  <> 0 AND C7_QUJE < C7_QUANT 
			THEN 'Recebido Parcial'
		WHEN  C7_QUJE >= C7_QUANT 
			THEN 'Recebido'
		WHEN  C7_CONAPRO  = 'B' AND C7_QUJE < C7_QUANT 
			THEN 'Em Aprovacao'
		WHEN  C7_RESIDUO  <> ''  
			THEN 'Eliminado residuo'
		WHEN  C7_QTDACLA   > 0  
			THEN 'Em recebimento'
		WHEN C7_CONTRA   <> '' AND C7_RESIDUO <> ''  
			THEN 'Em Contrato'
		WHEN  C7_CONAPRO =  'R' 
			THEN 'Rejeitado pelo Aprovador'
		ELSE 'N/D'
	END  AS StatusPedido,

	Case
	When C7_OBS Like ('%(E)%')
		Then 3
	When C7_OBS Like ('%(U)%')
		Then 2
	When C7_OBS Like ('%(N)%')
		Then 1
	Else 0
	End as Status_Prioridade,

	Case
	When C7_OBS Like ('%(E)%')
		Then 'EMERGENCIAL'
	When C7_OBS Like ('%(U)%')
		Then 'URGENTE'
	When C7_OBS Like ('%(N)%')
		Then 'Normal'
	Else 'Não Critico'
	End as Status_Prioridade
	

From SC7010 SC7 With(Nolock)

	Left Join SD1010 SD1 With(Nolock) -- NF Entarda Itens 
	On D1_FILIAL = C7_FILIAL
	And D1_PEDIDO = C7_NUM
	And D1_ITEMPC = C7_ITEM 
	And D1_FORNECE = C7_FORNECE
	And D1_LOJA = C7_LOJA
	And D1_COD = C7_PRODUTO
	And SD1.D_E_L_E_T_ = ''

	Left Join SF1010 SF1 With(Nolock) -- NF Entrada
	On D1_FILIAL = F1_FILIAL
	And D1_FORNECE = F1_FORNECE
	And D1_LOJA = F1_LOJA
	And D1_DOC = F1_DOC
	And SF1.D_E_L_E_T_ = ''


	LEFT JOIN CTT010 CTT With(Nolock) -- Centro de custo
	ON  '' = CTT_FILIAL
	AND C7_CC=  CTT_CUSTO
	AND CTT.D_E_L_E_T_ = ''

	Left Join SA2010 SA2 With(Nolock) --Fonecedores 
	On A2_COD = C7_FORNECE
	And A2_LOJA = C7_LOJA
	And SA2.D_E_L_E_T_ = ''

	INNER JOIN SB1010 SB1 With(Nolock) -- Produtos
	ON '' = B1_FILIAL
	AND C7_PRODUTO = B1_COD
	AND SB1.D_E_L_E_T_ = ''


	INNER JOIN SE4010 SE4 With(Nolock) -- Cond. de pagamentos 
	ON '' = E4_FILIAL
	AND C7_COND = E4_CODIGO
	AND SE4.D_E_L_E_T_ = ''

	Left JOIN SE4010 SE4_SF1 With(Nolock) -- Cond. de pagamentos 
	ON '' = SE4_SF1 .E4_FILIAL
	AND F1_COND = SE4_SF1 .E4_CODIGO
	AND SE4_SF1.D_E_L_E_T_ = ''

	LEFT JOIN SY1010 SY1 With(Nolock) --Comprador
	ON '' =  Y1_FILIAL
	AND C7_COMPRA =  Y1_COD
	AND SY1.D_E_L_E_T_	= ''

	Left Join SCR010 SCR With(Nolock) -- Controle de documentos
	On CR_FILIAL = C7_FILIAL
	And CR_NUM = C7_NUM
	And CR_TIPO = 'PC'
	And CR_LIBAPRO <> ''
	And CR_DATALIB <> ''
	And SCR.D_E_L_E_T_ = ''


	Left Join SAK010 SAK With(Nolock) -- Aprovadores 
	On AK_FILIAL = CR_FILIAL
	And AK_COD = CR_LIBAPRO
	And SAK.D_E_L_E_T_ = '' 

	Left Join SC1010 SC1 With(Nolock) -- SC
	On C1_FILIAL = C7_FILIAL
	And C1_PEDIDO = C7_NUM
	And C1_NUM = C7_NUMSC
	And C1_ITEMPED = C7_ITEM
	And C1_PRODUTO = C7_PRODUTO
	And SC1.D_E_L_E_T_ = ''

	Left Join SC8010 SC8 With(Nolock) -- COTACAO
	On C8_FILIAL = C7_FILIAL
	And C8_NUMPED = C7_NUM
	And C8_NUM = C7_NUMCOT
	And C8_ITEMPED = C7_ITEM
	And C8_PRODUTO = C7_PRODUTO

Where C7_FILIAL In ('01','02','03') 
--And (C1_NUM <> C7_NUMSC or C8_NUM <> C7_NUMCOT)
And (C7_QUANT <= (C7_QUJE+C7_QUANT))
AND C7_CONAPRO Not In  ('R')
AND C7_RESIDUO = ''
And C7_ENCER Not In ('E')
And (C7_OBS Like ('%(E)%') or C7_OBS Like ('%(U)%') or C7_OBS Like ('%(N)%'))
And SC7.D_E_L_E_T_ = ''
And C7_EMISSAO >= CONVERT(CHAR(8),DATEADD (YEAR, -3, GETDATE() ),112)
Group By D1_DOC,C7_QUANT,D1_QUANT,C7_NUM,C7_ITEM,D1_PEDIDO,D1_ITEMPC,C7_DATPRF,D1_DTDIGIT,C7_CC,D1_CC,CTT_DESC01,C7_QUJE,C7_QTDACLA,
		C7_ENCER,C7_RESIDUO,C7_CONAPRO,C7_EMISSAO,C7_FILIAL,C7_LOJA,C7_FORNECE,C7_PRODUTO,C7_NUMSC,C7_ITEMSC,C7_NUMCOT,A2_NOME,C7_APROV,AK_NOME,
		C7_USER,C7_COMPRA,Y1_NOME,C7_QTDSOL,C7_TIPO,C7_CONTRA,C7_COND,SE4.E4_DESCRI,C7_OBS,CR_DATALIB,CR_LIBAPRO,D1_CUSTO,C1_EMISSAO,C8_EMISSAO,
		C7_PRECO,C7_TOTAL,D1_TOTAL,D1_VUNIT,F1_COND,SE4_SF1.E4_DESCRI,C7_DESCRI,C1_SOLICIT,C1_NUM,C1_ITEM,C8_NUM,C8_ITEM,D1_ITEM
Order By 1,10,11

