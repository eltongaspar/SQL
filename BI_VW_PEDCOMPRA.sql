--USE [IFC_P12]
--GO

/****** Object:  View [dbo].[BI_VW_PEDCOMPRA]    Script Date: 15/03/2024 14:20:18 ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO


--ALTER VIEW [dbo].[BI_VW_PEDCOMPRA]
--AS
SELECT 
	C7.C7_FILIAL							AS Filial,
	/* Solicitaçao de compra */
	RTRIM(LTRIM(ISNULL(C1.C1_NUM, '')))		AS NroSC,
	RTRIM(LTRIM(ISNULL(C1.C1_ITEM, '')))	AS ItemSC,
	ISNULL(C1.C1_QUANT, 0)					AS QtdSC,
	RTRIM(LTRIM(ISNULL(C1.C1_EMISSAO, '')))	AS EmissaoSC,
	RTRIM(LTRIM(ISNULL(C1.C1_OBS, '')))		AS ObsSC,
	RTRIM(LTRIM(ISNULL(C1.C1_SOLICIT, '')))	AS SolicitanteSC,
	/* Cotacao */
	RTRIM(LTRIM(ISNULL(C8.C8_NUM, '')))	    AS NroCt,
	RTRIM(LTRIM(ISNULL(C8.C8_ITEM, '')))	AS ItmCt,
	ISNULL(C8.C8_PRECO, 0)					AS PrcCt,
	ISNULL(C8.C8_QUANT,0)					AS QtdCt,
	ISNULL(C8_DATPRF, '')					AS DtCt,
	C7.C7_EMISSAO							AS EmissaoPedido,
	CASE 
		WHEN C7.C7_QUJE = 0 AND C7.C7_QTDACLA = 0 AND C7.C7_CONAPRO <> 'B' AND C7.C7_TIPO =1 AND C7.C7_RESIDUO = ''
			THEN 'Pendente'
		WHEN C7.C7_QUJE  <> 0 AND C7.C7_QUJE < C7.C7_QUANT 
			THEN 'Recebido Parcial'
		WHEN  C7.C7_QUJE >= C7.C7_QUANT 
			THEN 'Recebido'
		WHEN  C7.C7_CONAPRO  = 'B' AND C7.C7_QUJE < C7.C7_QUANT 
			THEN 'Em Aprovacao'
		WHEN  C7.C7_RESIDUO  <> ''  
			THEN 'Eliminado residuo'
		WHEN  C7.C7_QTDACLA   > 0  
			THEN 'Em recebimento'
		WHEN  C7.C7_CONTRA   <> '' AND C7.C7_RESIDUO <> ''  
			THEN 'Em Contrato'
		WHEN  C7.C7_CONAPRO =  'R' 
			THEN 'Rejeitado pelo Aprovador'
		ELSE 'N/D'
	END  AS StatusPedido,
	C7.C7_NUM					AS NumeroPedido,
	C7.C7_ITEM					AS ItemPedido,
	RTRIM(LTRIM(B1.B1_COD))		AS CodigoProduto,
	RTRIM(LTRIM(B1.B1_DESC))	AS Produto,
	RTRIM(LTRIM(B1.B1_GRUPO))	AS GrupoProduto,
	B1.B1_POSIPI				AS NcmProduto,
	RTRIM(LTRIM(C7.C7_UM))		AS UM_Produto,
	RTRIM(LTRIM(C7.C7_SEGUM))	AS Seg_UM_Produto,
	C7.C7_QUANT					AS Quantidade,
    C7.C7_PRECO					AS Preco,
	C7.C7_TOTAL					AS Total,
	C7.C7_DATPRF				AS DataEntrega,
	C7.C7_QUJE					AS QtdEntregue,
	RTRIM(LTRIM(C7.C7_OBS))     AS Observacao,
	C7.C7_CC					AS CentroCusto,
	ISNULL(CT.CTT_DESC01, '')	AS NomeCCusto,
	A2.A2_NOME					AS Fornecedor,
	E4.E4_CODIGO				AS CodCondPag,
	E4.E4_DESCRI				AS DescCondPag,
	E4.E4_ZMEDPAG				AS MedCondPag,
	C7.C7_APROV					AS Aprovador,
	ISNULL(AK.AK_NOME, '')		AS NomeAprovador,
	C7.C7_USER					AS Solicitante,
	C7.C7_COMPRA				AS Comprador,
	ISNULL(Y1.Y1_NOME, '')		AS NomeComprador,
	C7.C7_QTDSOL				AS QtdSolicitada
FROM 
	SC7010 C7
INNER JOIN SB1010 B1
	ON '' = B1.B1_FILIAL
	AND C7.C7_PRODUTO = B1.B1_COD
	AND C7.D_E_L_E_T_ = B1.D_E_L_E_T_ 
INNER JOIN SA2010 A2
	ON '' = A2.A2_FILIAL
	AND C7.C7_FORNECE	= A2.A2_COD
	AND C7.C7_LOJA		= A2.A2_LOJA
	AND C7.D_E_L_E_T_	= A2.D_E_L_E_T_
INNER JOIN SE4010 E4
	ON ''				= E4.E4_FILIAL
	AND C7.C7_COND		= E4.E4_CODIGO
	AND C7.D_E_L_E_T_	= E4.D_E_L_E_T_

LEFT JOIN SY1010 Y1
	ON ''		=  Y1.Y1_FILIAL
	AND C7.C7_COMPRA	=  Y1.Y1_COD
	AND C7.D_E_L_E_T_	=  Y1.D_E_L_E_T_

LEFT JOIN SAK010 AK
	ON C7.C7_FILIAL		=  AK.AK_FILIAL
	AND C7.C7_APROV		=  AK.AK_COD
	AND C7.D_E_L_E_T_	=  AK.D_E_L_E_T_
LEFT JOIN SC1010 C1
	ON  C7.C7_FILIAL  = C1.C1_FILIAL
	AND C7.C7_NUMSC   = C1.C1_NUM
	AND C7.C7_ITEMSC  = C1.C1_ITEM
	AND C7.D_E_L_E_T_ = C1.D_E_L_E_T_
LEFT JOIN SC8010 C8
	ON  C7.C7_FILIAL	= C8.C8_FILIAL
	AND C7.C7_NUM		= C8.C8_NUMPED
	AND C7.C7_ITEM		= C8.C8_ITEMPED
	AND C7.D_E_L_E_T_	= C8.D_E_L_E_T_
LEFT JOIN CTT010 CT
	ON  ''				= CT.CTT_FILIAL
	AND C7.C7_CC		= CT.CTT_CUSTO
	AND C7.D_E_L_E_T_	= CT.D_E_L_E_T_

WHERE
	C7.C7_EMISSAO >= '20220101' 
	AND C7.D_E_L_E_T_ = ''
GO



