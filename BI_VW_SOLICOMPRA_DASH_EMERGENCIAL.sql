--USE [IFC_P12]
--GO
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO


/*
QUERY PARA EXTRAIR AS SOLICITAÇÕES DE COMPRAS
	Observações:
	
*/

--CREATE VIEW [dbo].[BI_VW_SOLICOMPRA_DASH_EMERGENCIAL]
--AS

-- 
Select
	/*------------------------------------*/
	/*CHAVES PARA LIGAR COM OUTRAS TABELAS*/
	/*------------------------------------*/
	RTRIM(LTRIM(ISNULL(C1_FILIAL,'')))														As CH_FILIAL,
	RTRIM(LTRIM(ISNULL(C1_FORNECE,'')))+'-'+RTRIM(LTRIM(ISNULL(C1_LOJA,'')))				As CH_FORNECELOJA, 
	RTRIM(LTRIM(ISNULL(C1_PRODUTO,'')))														As CH_PRODUTO,
	RTRIM(LTRIM(ISNULL(C1_CC,'')))															As CH_CC,				/*Centro de Custo*/
	RTRIM(LTRIM(ISNULL(C1_FILIAL,'')))+'-'+RTRIM(LTRIM(ISNULL(C1_PEDIDO,'')))+'-'+
				RTRIM(LTRIM(ISNULL(C1_PRODUTO,'')))+'-'+RTRIM(LTRIM(ISNULL(C1_ITEMPED,''))) As CH_FILIALPEDIDO,		/*Pedido de Compras*/
	RTRIM(LTRIM(ISNULL(C1_FILIAL,'')))+'-'+RTRIM(LTRIM(ISNULL(C1_COTACAO,'')))+'-'+
				RTRIM(LTRIM(ISNULL(C1_PRODUTO,'')))											As CH_FILIALCOTACAO,	/*Cotação*/ 
	/*------------------------------------*/

	RTRIM(LTRIM(ISNULL(C1_FILIAL, '')))														As C1_FILIAL,
	RTRIM(LTRIM(ISNULL(C1_NUM, '')))														As C1_NUM,
	RTRIM(LTRIM(ISNULL(C1_EMISSAO, '')))													As C1_EMISSAO,
	RTRIM(LTRIM(ISNULL(C1_DATPRF, '')))														As C1_DATPRF,
	RTRIM(LTRIM(ISNULL(C1_PEDIDO, '')))														As C1_PEDIDO,
	RTRIM(LTRIM(ISNULL(C1_COTACAO, '')))													As C1_COTACAO,
	RTRIM(LTRIM(ISNULL(C1_ITEM, '')))														As C1_ITEM,
	RTRIM(LTRIM(ISNULL(C1_PRODUTO, '')))													As C1_PRODUTO,
	RTRIM(LTRIM(ISNULL(C1_DESCRI, '')))														As C1_DESCRI,
	RTRIM(LTRIM(ISNULL(C1_UM, '')))															As C1_UM,
	RTRIM(LTRIM(ISNULL(AH_UMRES, '')))														As AH_UMRES,
	(ISNULL(C1_QTDORIG, 0))																	As C1_QTDORIG,
	(ISNULL(C1_QUANT, 0))																	As C1_QUANT,
	(ISNULL(C1_QUJE, 0))																	As C1_QUJE,
	RTRIM(LTRIM(ISNULL(C1_OBS, '')))														As	C1_OBS,
	RTRIM(LTRIM(ISNULL(CTT_DESC01, '')))													As CTT_DESC01,
	RTRIM(LTRIM(ISNULL(C1_FORNECE, '')))													As C1_FORNECE,
	RTRIM(LTRIM(ISNULL(C1_LOJA, '')))														As C1_LOJA,
	RTRIM(LTRIM(ISNULL(C1_LOCAL, '')))														As C1_LOCAL,
	RTRIM(LTRIM(ISNULL(C1_SOLICIT, '')))													As C1_SOLICIT,
	RTRIM(LTRIM(ISNULL(C1_APROV, '')))														As C1_APROV,
	RTRIM(LTRIM(ISNULL(C1_CODCOMP, '')))													As COMPRADOR_COD,
	RTRIM(LTRIM(ISNULL(Y1_NOME, '')))														As COMPRADOR_NOME,

	/*------------------------------------*/
	Case 
		When C1_QUJE = 0 And C1_COTACAO = '' --And C1_APROV = 'L'
			Then 'Solicitação Pendente'
		When C1_QUANT = C1_QUJE
			Then 'Solicitação Totalmente Atendida'
		When C1_QUJE < C1_QUANT
			Then 'Solicitação Parcialmente Atendida'
		When C1_QUANT > 0 And C1_QUJE < C1_QUANT  and C1_COTACAO = 'XXXXXX'
			Then 'Solicitação Parcialmente Atendida Utilizada em Cotação '
		When C1_COTACAO <> ''
			Then 'Solicitação em Processo de Cotação'
		When C1_RESIDUO = 'S'
			Then 'Elimnado Resíduo'
		When C1_QUJE > 0 And (C1_COTACAO = '' Or C1_COTACAO = 'Import') And C1_APROV = 'B'
			Then 'Solicitação Bloqueada'
		When C1_IMPORT = 'S'
			Then 'Solicitação de Produto Importado'
		When C1_QUJE = 0 And (C1_COTACAO = '' or C1_COTACAO = 'Import') and C1_APROV = 'R'
			Then 'Solicitação Rejeitada'
		When C1_FLAGGCT = '1' and C1_QUJE < C1_QUANT
			Then 'Integração Módulo Contratos'
		when C1_TPSC = 2 and C1_QUJE = 0 and C1_CODED <> ''
			Then 'Solicitação em Processo de Edital'
		When C1_RESIDUO = 'S' and C1_COMPRAC = '1'
			Then 'Solicitação em Compra Centralizada'
		When C1_TIPO = '1'
			Then 'Solicitação de Importação'
		When C1_ACCPROC <> ''
			Then 'Solicitação em Processo de Cotação MKT'
		When C1_QUJE = 0 and C1_APROV = 'L'and (C1_COTACAO = '' or C1_COTACAO = 'ANALIS') and C1_TPSC = '2'
			Then 'Solicitação para Licitação'
		Else 'Analisar'
		End
		As STATUS_,

	Isnull(DateDiff(Day,Max(C1_EMISSAO),C1_DATPRF),'')  As DIAS_ATRASO,

	
	Case
	When C1_OBS Like ('%(E)%')
		Then 3
	When C1_OBS Like ('%(U)%')
		Then 2
	When C1_OBS Like ('%(N)%')
		Then 1
	Else 0
	End as Status_Prioridade,

	Case
	When C1_OBS Like ('%(E)%')
		Then 'EMERGENCIAL'
	When C1_OBS Like ('%(U)%')
		Then 'URGENTE'
	When C1_OBS Like ('%(N)%')
		Then 'NORMAL'
	Else 'Não Critico'
	End as Status_Prioridade
	

	/*------------------------------------*/

From SC1010 SC1


	/*------------------------------------*/
	/*Incio Left Join*/
	
	Left Join SB1010 SB1 -- Produtos 
	On B1_COD = C1_PRODUTO
	And SB1.D_E_L_E_T_ = ''

	Left Join SA2010 SA2 --Fonecedores 
	On A2_COD = C1_FORNECE
	And A2_LOJA = C1_LOJA
	And SA2.D_E_L_E_T_ = ''

	Left Join CTT010 CTT --Centro de Custo 
	On CTT_CUSTO = C1_CC
	And CTT.D_E_L_E_T_ = ''

	Left Join SAH010 SAH -- UM
	On AH_UNIMED = C1_UM
	And SAH.D_E_L_E_T_ = ''

	Left Join NNR010 NNR --Armazem / Local 
	ON NNR_CODIGO = C1_LOCAL
	And NNR.D_E_L_E_T_ = ''

	LEFT JOIN SY1010 SY1 With(Nolock) --Comprador
	ON '' =  Y1_FILIAL
	AND C1_CODCOMP =  Y1_COD
	AND SY1.D_E_L_E_T_	= ''

Where C1_FILIAL In ('01','02','03')
And C1_EMISSAO >= CONVERT(CHAR(8),DATEADD (YEAR, -3, GETDATE() ),112)
And (C1_OBS Like ('%(E)%') or C1_OBS Like ('%(U)%') or C1_OBS Like ('%(N)%'))
And (C1_PEDIDO = '' and  C1_COTACAO = '')
And C1_QUJE = 0
And (C1_RESIDUO <> 'S' and C1_APROV <> 'B' and C1_APROV <> 'R')
And SC1.D_E_L_E_T_ = ''
Group By C1_FILIAL,C1_FORNECE,C1_LOJA,C1_PRODUTO,C1_CC,C1_PEDIDO,C1_ITEM,C1_COTACAO,C1_NUM,C1_EMISSAO,
C1_DATPRF,C1_DESCRI,C1_UM,AH_UMRES,C1_QTDORIG,C1_QUANT,C1_QUJE,C1_OBS,CTT_DESC01,C1_LOCAL,C1_SOLICIT,C1_APROV,
C1_RESIDUO,C1_IMPORT,C1_FLAGGCT,C1_TPSC,C1_CODED,C1_COMPRAC,C1_TIPO,C1_ACCPROC,C1_ITEMPED,C1_CODCOMP,Y1_NOME
Order By 32 Desc



	



