--USE [IFC_P12]
--GO
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO


/*
QUERY PARA EXTRAIR AS NF Entrada Itens sem Pedido de Compras 
Somente NFS Tipo N e Especie SPED e NFS
	Observações:
	
*/

--CREATE VIEW [dbo].[BI_VW_NF_SEM_PC]
--AS

-- 



Select 

	/*------------------------------------*/
	/*CHAVES PARA LIGAR COM OUTRAS TABELAS*/
	/*------------------------------------*/
	RTRIM(LTRIM(ISNULL(D1_FILIAL,'')))														As CH_FILIAL,

    CASE D1_FILIAL 
            when '01' then 'ITU'
            when '02' then 'TRES-LAGOAS'
            when '03' then 'MINAS'
    END																						AS FILIALNOME,

	RTRIM(LTRIM(ISNULL(D1_COD,'')))															As CH_PRODUTO,
	RTRIM(LTRIM(ISNULL(D1_FORNECE,'')))+'-'+RTRIM(LTRIM(ISNULL(D1_LOJA,'')))				As CH_FORNECELOJA,
	RTRIM(LTRIM(ISNULL(D1_CC,'')))															As CH_CC,
	RTRIM(LTRIM(ISNULL(D1_FILIAL,'')))+'-'+RTRIM(LTRIM(ISNULL(D1_DOC,'')))+				
					'-'+RTRIM(LTRIM(ISNULL(D1_SERIE,'')))									As CH_FILIAL_DOC_SERIE,
	/*------------------------------------*/


	/*------------------------------------*/
	RTRIM(LTRIM(ISNULL(D1_FILIAL, '')))														As FILIAL,
	RTRIM(LTRIM(ISNULL(D1_PEDIDO, '')))														As PC_NUM,
	RTRIM(LTRIM(ISNULL(D1_COD, '')))														As PRODUTO_CODIGO,
	RTRIM(LTRIM(ISNULL(D1_DESCRI, '')))														As PRODUTO_DESCRICAO,
	RTRIM(LTRIM(ISNULL(D1_TP, '')))															As TIPO_PRODUTO,
	RTRIM(LTRIM(ISNULL(D1_TIPO, '')))														As NF_TIPO,
	RTRIM(LTRIM(ISNULL(F1_ESPECIE, '')))													As NF_ESPECIE,
	RTRIM(LTRIM(ISNULL(X5_DESCRI, '')))														As NF_ESPECIE_DESC,
	RTRIM(LTRIM(ISNULL(D1_DOC, '')))														As NF_NUMERO,
	RTRIM(LTRIM(ISNULL(D1_SERIE, '')))														As NF_SERIE, 
	RTRIM(LTRIM(ISNULL(D1_FORNECE, '')))													As FORNECE,
	RTRIM(LTRIM(ISNULL(D1_LOJA, '')))														As FORNECE_LOJA,
	RTRIM(LTRIM(ISNULL(A2_NOME, '')))														As FORNECE_NOME,
	RTRIM(LTRIM(ISNULL(D1_CC, '')))															As CC_CODIGO,
	RTRIM(LTRIM(ISNULL(CTT_DESC01, '')))													As CC_NOME,
	RTRIM(LTRIM(ISNULL(D1_EMISSAO, '')))													As NF_DATA_EMISSAO,
	RTRIM(LTRIM(ISNULL(D1_DTDIGIT, '')))													As NF_DATA_ENTRADA,


	/*------------------------------------*/

	/*------------------------------------*/
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
		End as TIPO

	/*------------------------------------*/
From SD1010 SD1 With(Nolock)
	

	/*------------------------------------*/
	Inner Join SF1010 SF1 With(Nolock) -- NF Sadia Itens
	On D1_FILIAL = F1_FILIAL
	And D1_FORNECE = F1_FORNECE
	And D1_LOJA = F1_LOJA  
	And D1_DOC = F1_DOC
	And SF1.D_E_L_E_T_ = ''

	
	Left Join SX5010 SX5 With(Nolock)
	On X5_FILIAL = F1_FILIAL
	And X5_TABELA = '42' --ESPECIES DE DOCUMENTOS FISCAIS                         
	And X5_CHAVE = F1_ESPECIE
	And SX5.D_E_L_E_T_ = ''

	
	Left Join SA2010 SA2 With(Nolock) --Fonecedores 
	On A2_COD = D1_FORNECE
	And A2_LOJA = D1_LOJA
	And SA2.D_E_L_E_T_ = ''
	
	Left Join CTT010 CTT With(Nolock) --Centro de Custo ,
	On CTT_CUSTO = D1_CC
	And CTT.D_E_L_E_T_ = ''

	/*------------------------------------*/

	/*------------------------------------*/
Where D1_PEDIDO = ''
And D1_TIPO = 'N'
And F1_ESPECIE In ('SPED','NFS')
And F1_ORIGEM Not in ('cbcInTrC')
And D1_FORNECE Not In ('000048','UNIAO','V00693','VOOCHU')
And D1_EMISSAO >= CONVERT(CHAR(8),DATEADD (YEAR, -3, GETDATE() ),112)
And SD1.D_E_L_E_T_ = ''
	/*------------------------------------*/







