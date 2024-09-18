SELECT 
	/*CHAVES PARA LIGAR COM OUTRAS TABELAS*/
	B1.B1_COD									AS CH_Produto,
	/*CAMPOS DA TABELA*/
	B1.B1_COD									AS Produto,
   	B1.B1_DESC									AS DescricaoCompleta,
   	B1.B1_UM									AS UnidadeMedida,
   	B1.B1_ORIGEM								AS OrigemFCI,
   	B1.B1_PESCOB								AS PesoCobre,
   	B1.B1_PESPVC								AS PesoPVC,
	B1.B1_PESBRU								AS PesoBruto,
	B1.B1_CUSTD									AS CustoItu,
	B1.B1_CUSTD3L								AS CustoTL,
	B1.B1_XPORTAL								AS Portal,
	B1.B1_ZZFILFB								AS UnidadeFabricacao,
 
   	/* 02/02/2017 - Leonardo */
   	CASE
   		WHEN (B1.B1_NOME + B1.B1_BITOLA) IN ('10105','11505')
   			THEN 'S'
   		ELSE 'N'
   	END											AS Flex25,
   	
   	CASE
   		WHEN B1.B1_BLQVEN = ''
   			THEN 'NAO'
   		WHEN B1.B1_BLQVEN = 'N'
   			THEN 'NAO'
   		WHEN B1.B1_BLQVEN = 'S'
   			THEN 'SIM'
   		ELSE 'INVALIDO'
   	END		   									AS BloqueioVendas,
   	CASE
   		WHEN B1.B1_MSBLQL = ''
   			THEN 'NAO'
   		WHEN B1.B1_MSBLQL = '2'
   			THEN 'NAO'
   		WHEN B1.B1_MSBLQL = '1'
   			THEN 'SIM'
   		ELSE 'INVALIDO'
   	END		   									AS BloqueioSistema,
   	ISNULL(X5_1.X5_DESCRI,'INVALIDO')			AS Tipo,
   	UPPER(ISNULL(BM.BM_DESC,'INVALIDO'))		AS Grupo,
	CASE
		WHEN B1.B1_TIPO IN ('PI','SC')
			THEN 'N/I'
		WHEN B1.B1_TIPO IN ('MP','PA')
			THEN
				
				CASE
					WHEN Z1.Z1_NOME = ''
						THEN 'N/I'
					ELSE ISNULL(Z1.Z1_NOME,'N/I')
				END

		ELSE 'INVALIDO'
	END											AS Nome, /* QUANDO PRODUTO NÃO TEM CAMPO Z1_NOME */
	CASE
		WHEN B1.B1_TIPO IN ('MP','PI','SC')
			THEN 'N/I'
		WHEN B1.B1_TIPO = 'PA'
			THEN ISNULL(Z2.Z2_DESC,'N/I')
		ELSE 'INVALIDO'
	END											AS Bitola,
	CASE
		WHEN B1.B1_TIPO IN ('PI','SC')
			THEN 'N/I'
		WHEN B1.B1_TIPO IN ('MP','PA')
			THEN ISNULL(Z3.Z3_DESC,'N/I')
		ELSE 'INVALIDO'
	END											AS Cor,
	CASE
		WHEN B1.B1_TIPO IN ('MP','PI','SC')
			THEN 'N/I'
		WHEN B1.B1_TIPO = 'PA'
			THEN B1.B1_CLASENC+'-'+ISNULL(X5_2.X5_DESCRI,'N/I')
		ELSE 'INVALIDO'
	END											AS ClasseEncordoamento,
	CASE
		WHEN B1.B1_TIPO IN ('MP','PI','SC')
			THEN 'N/I'
		WHEN B1.B1_TIPO = 'PA'
			THEN ISNULL(Z4.Z4_DESC,'N/I')
		ELSE 'INVALIDO'
	END											AS Especialidade,

	B1_CONTA									As Conta_Contabil,
	CT1_DESC01									As Conta_Descrição, 
	B1_CC										As Centro_Custo,
	CTT_DESC01									As CC_Descrição,
	B1_ITEMCC									As Item_Contabil,
	B1_PIS										As PIS,
	B1_COFINS									As COFINS,
	B1_CSLL										As CSLL,
	B1_POSIPI									As NCM,
	B1_PICM										As ICMS_Alicota,
	B1_IPI										As IPI,
	B1_ALIQISS									As ISS_Alicota,
	B1_CODISS									As ISS_Codigo_Servico,
	B1_TE										As TES_ENTRADA,
	B1_TS										As TES_SAIDA,
	B1_PICMRET									As ICMS_Solidario_Saida,
	B1_PICMENT									As ICMS_Solidario_Entrada,
	B1_IMPZFRC									As Importa_Zona_Franca_Manaus,			
	B1_GRUDES									As Grupo_Desconto,
	B1_REDPIS									As PIS_Reducao,
	B1_REDCOF									As COFINS_Reducao,
	B1_PCSLL									As CSLL_Percentual,
	B1_PCOFINS									As COFINS_Percentual,
	B1_REDIRRF									As IRRF_Reducao_Percentual,
	B1_TAB_IPI									As IPI_Pauta,
	B1_DATASUB									As Data_Substituicao,
	B1_PPIS										As PIS_Percentual,
	B1_VLR_IPI									As IPI_Pauta,
	B1_VLR_ICM									As ICMS_Pauta

FROM SB1010 B1 WITH (NOLOCK)
LEFT OUTER JOIN SX5010 X5_1	WITH (NOLOCK)		/*RELACIONA COM TIPOS DE PRODUTO*/
	ON '01'				= X5_1.X5_FILIAL
	AND '02'			= X5_1.X5_TABELA
	AND B1.B1_TIPO		= X5_1.X5_CHAVE
	AND B1.D_E_L_E_T_	= X5_1.D_E_L_E_T_

LEFT OUTER JOIN SX5010 X5_2 WITH (NOLOCK)		/*RELACIONA COM CLASSES DE ENCORDOAMENTO*/
	ON '01'				= X5_2.X5_FILIAL
	AND 'Z1'			= X5_2.X5_TABELA
	AND B1.B1_CLASENC	= X5_2.X5_CHAVE
	AND B1.D_E_L_E_T_	= X5_2.D_E_L_E_T_

LEFT OUTER JOIN SBM010 BM WITH (NOLOCK)			/*RELACIONA COM GRUPOS*/
	ON B1.B1_FILIAL		= BM.BM_FILIAL
	AND B1.B1_GRUPO		= BM.BM_GRUPO
	AND B1.D_E_L_E_T_	= BM.D_E_L_E_T_

LEFT OUTER JOIN SZ1010 Z1 WITH (NOLOCK)			/*RELACIONA COM NOME PRODUTO*/
	ON B1.B1_FILIAL		= Z1.Z1_FILIAL
	AND B1.B1_NOME		= Z1.Z1_COD
	AND B1.D_E_L_E_T_	= Z1.D_E_L_E_T_
LEFT OUTER JOIN SZ2010 Z2 WITH (NOLOCK)			/*RELACIONA COM BITOLAS*/
	ON B1.B1_FILIAL		= Z2.Z2_FILIAL
	AND B1.B1_BITOLA	= Z2.Z2_COD
	AND B1.D_E_L_E_T_	= Z2.D_E_L_E_T_

LEFT OUTER JOIN SZ3010 Z3 WITH (NOLOCK)			/*RELACIONA COM CORES*/
	ON B1.B1_FILIAL		= Z3.Z3_FILIAL
	AND B1.B1_COR		= Z3.Z3_COD
	AND B1.D_E_L_E_T_	= Z3.D_E_L_E_T_

LEFT OUTER JOIN SZ4010 Z4 WITH (NOLOCK)			/*RELACIONA COM ESPECIALIDADES*/
	ON B1.B1_FILIAL		= Z4.Z4_FILIAL
	AND B1.B1_ESPECIA	= Z4.Z4_COD
	AND B1.D_E_L_E_T_	= Z4.D_E_L_E_T_


Left Join CT1010 CT1
	On CT1_CONTA = B1_CONTA
	And CT1_FILIAL = B1_FILIAL
	And CT1.D_E_L_E_T_ = ''

Left Join  CTT010 CTT
	On CTT_CUSTO = B1_CC
	And CTT_FILIAL = B1_FILIAL
	And CTT.D_E_L_E_T_ = ''

WHERE
	B1.B1_FILIAL		= ''
	AND B1.D_E_L_E_T_	= ''


	
--B1_PIS	Retem PIS	Efetua a retencao-PIS
--B1_COFINS	Retem COF	Efetua a retencao-COFINS
--B1_CSLL	Retem CSLL	Efetua a Retencao-CSLL
--B1_CONTA	Cta Contabil	Conta Contabil dn Prod.
--B1_POSIPI	Pos.IPI/NCM	Nomenclatura Ext.Mercosul
--B1_PICM	Aliq. ICMS	Aliquota de ICMS
--B1_IPI	Aliq. IPI	Aliquota de IPI
--B1_ALIQISS	Aliq. ISS	Aliquota de ISS
--B1_CODISS	Cod.Serv.ISS	Codigo de Servico do ISS	
--B1_TE	TE Padrao	Codigo de Entrada padrao	
--B1_TS	TS Padrao	Codigo de Saida padrao
--B1_PICM	Aliq. ICMS	Aliquota de ICMS
--B1_PICMRET	Solid. Saida	% Lucro Calc. Solid.Saida	
--B1_PICMENT	Solid. Entr.	% Lucro Calc. Solid.Entr.
--B1_IMPZFRC	Imp.Z.Franca	Produto Import. Z.Franca
--B1_REDIRRF	% Red. IRRF	Perc. de reducao do IRRF
--B1_TAB_IPI	IPI de Pauta	Tabela para IPI de Pauta
--B1_GRUDES	Grupo Descon	Grupo de Desconto	
--B1_REDPIS	%Red.PIS	Perc. Reducao PIS
--B1_REDCOF	% Red.COFINS	Perc.Reducao COFINS	
--B1_DATASUB	Data Substit	Data da Substituicao	
--B1_PCSLL	Perc. CSLL	Percentual CSLL
--B1_PCOFINS	Perc. COFINS	Percentual COFINS	
--B1_PPIS	Perc. PIS	Percentual PIS
--B1_VLR_IPI	IPI de Pauta	Vlr unit. do IPI de Pauta
--B1_VLR_ICM	Icms Pauta	Valor de Icms de Pauta



-- Genericas
-- Select * From SX5010 Where X5_TABELA = '02' and D_E_L_E_T_ = ''
-- Grupos de produtos
-- Select * From SBM010
-- Conta Contabil 
-- Select * FRom CT1010


