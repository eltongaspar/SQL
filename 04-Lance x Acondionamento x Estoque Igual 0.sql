-- Script para verificar Analise de Pedidos Vendas x Estoque 
-- Total / Lance = 0 

SELECT 
	isnull(BF_QUANT-BF_EMPENHO,0) TOTAL,
	CAST(SUBSTRING(BF_LOCALIZ,2,5) AS NUMERIC) AS LANCE,
	*
FROM SBF010
WHERE
BF_PRODUTO Between '0000000000' and '999999999' 
AND BF_LOCAL = '01'
AND BF_QUANT-BF_EMPENHO > 0
AND CAST(isnull(BF_QUANT-BF_EMPENHO,0) /  CAST(SUBSTRING(BF_LOCALIZ,2,5) AS NUMERIC) AS INT) = 0
AND D_E_L_E_T_ = ''


Declare @FILIAL VARCHAR(2), @BFLOCAL Varchar(2), @CODPRODINI Varchar(10), @CODPRODFIM Varchar(10)
SET @FILIAL = '01'
Set @BFLOCAL = '01'
Set @CODPRODINI = '000000000'
SET @CODPRODFIM = '999999999'
			SELECT BF_LOCAL, BF_PRODUTO, Isnull(BF_QUANT-BF_EMPENHO,0) TOTAL, 
				SUBSTRING(BF_LOCALIZ,1,1) ACONDIC     , ISNULL(CAST( isnull(SUBSTRING(BF_LOCALIZ,2,5),'1') AS NUMERIC ),0) LANCE, 
				ISNULL(( isnull(SUBSTRING(BF_LOCALIZ,2,5),'1') ),'') METRAG_S, 'E' SD_ORIG
				From SBF010 BF 
				Where BF.D_E_L_E_T_ = ' ' AND BF_FILIAL = @FILIAL and BF_LOCAL = @BFLOCAL and (BF_QUANT-BF_EMPENHO) > 0  
				and SUBSTRING(BF_LOCALIZ,1,1) <> 'B'  and BF_PRODUTO Between @CODPRODINI and @CODPRODFIM
				AND CAST(isnull(BF_QUANT-BF_EMPENHO,0) /  CAST(SUBSTRING(BF_LOCALIZ,2,5) AS NUMERIC) AS INT) = 0







