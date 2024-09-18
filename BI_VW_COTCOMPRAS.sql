--USE [IFC_P12]
--USE [IFC_P12]
--GO
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO


/*
QUERY PARA EXTRAIR AS COTACOES DE COMPRAS
	Observações:
	
*/

--CREATE VIEW [dbo].[BI_VW_COTCOMPRAS]
--AS

-- 
Select
	/*------------------------------------*/
	/*CHAVES PARA LIGAR COM OUTRAS TABELAS*/
	/*------------------------------------*/
	C8_FILIAL												As CH_FILIAL,
	C8_FORNECE+'-'+C8_LOJA									As CH_FORNECELOJA, 
	C8_PRODUTO												As CH_PRODUTO,
	C8_FILIAL+'-'+C8_NUMPED+'-'+C8_PRODUTO+'-'+C8_ITEMPED		As CH_FILIALPEDIDO,		/*Pedido de Compras*/
	C8_FILIAL+'-'+C8_NUMSC+'-'+C8_PRODUTO+'-'+C8_ITEMSC		As CH_FILIALCOTACAO,	/*Cotação*/ 
	/*------------------------------------*/

C8_FILIAL,C8_NUM,
C8_EMISSAO,C8_DATPRF,C8_NUMPED,C8_NUMSC,C8_ITEM,C8_PRODUTO,B1_DESC,C8_UM,IsNull(AH_UMRES,'ND') As AH_UMRES,C8_QUANT,C8_FORNECE,C8_LOJA,
ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), C8_OBS)),'') AS C8_OBS,
ISNULL(CONVERT(VARCHAR(8000), CONVERT(VARBINARY(8000), C8_MOTVENC)),'') AS C8_MOTVENC,

	/*------------------------------------*/
	Case 
		When C8_NUMPED = '' And C8_PRECO > 0 and C8_COND <>''
			Then 'Cotação em Aberto'
		When C8_NUMPED <> ''
			Then 'Cotação Baixada'
		When C8_PRECO = 0 and C8_COND = '' and C8_NUMPED = ''
			Then 'Cotação Não Digitada'
		Else 'Analisar'
		End
		As STATUS_
	/*------------------------------------*/

From SC8010 SC8


	/*------------------------------------*/
	/*Incio Left Join*/
	
	Left Join SB1010 SB1 -- Produtos 
	On B1_COD = C8_PRODUTO
	And SB1.D_E_L_E_T_ = ''

	Left Join SA2010 SA2 --Fonecedores 
	On A2_COD = C8_FORNECE
	And A2_LOJA = C8_LOJA
	And SA2.D_E_L_E_T_ = ''
	
	Left Join SAH010 SAH -- UM
	On AH_UNIMED = C8_UM
	And SAH.D_E_L_E_T_ = ''
		
Where C8_FILIAL In ('01','02','03')
And C8_EMISSAO >= CONVERT(CHAR(8),DATEADD (YEAR, -3, GETDATE() ),112)
And SC8.D_E_L_E_T_ = ''



	

