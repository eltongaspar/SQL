USE [IFC_P12]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*
QUERY PARA EXTRAIR AS SOLICITAÇÕES DE COMPRAS
	Observações:
	
*/

--CREATE VIEW [dbo].[BI_VW_SOLICOMPRA]
--AS

SELECT 
	
	/*------------------------------------*/
	/*CHAVES PARA LIGAR COM OUTRAS TABELAS*/
	/*------------------------------------*/
	F2.F2_FILIAL									AS CH_Filial,				/*CRIAR TABELA NO QLIKVIEW PARA FILIAL*/
	F2.F2_CLIENTE+'-'+F2.F2_LOJA					AS CH_ClienteLoja,
	F2.F2_COND										AS CH_CondicaoPagamento,
	/*------------------------------------*/
	CASE
		WHEN F2.F2_VEND1 = ''
			THEN 'N/I'
		ELSE F2.F2_VEND1
	END												AS CH_Representante,
	/*------------------------------------*/
	
	CASE
		WHEN A3.A3_GEREN = ''
			THEN 'N/I'
		ELSE ISNULL(A3.A3_GEREN,'N/I')
	END												AS CH_GerenteVendas,
	
	D2.D2_COD										AS CH_Produto,
	/*------------------------------------*/
	CASE
		WHEN A1.A1_SEGMENT = ''
			THEN 'N/I'
		ELSE A1.A1_SEGMENT
	END												AS CH_Segmento,		
	
	CASE
		WHEN A1.A1_CGC = ''
			THEN 'N/I'
		ELSE A1.A1_CGC
	END												AS CH_CNPJ,

								
	/*------------------------------------*/
	CASE
		WHEN F2.F2_TRANSP = ''
			THEN 'N/I'
		ELSE F2.F2_TRANSP
	END												AS CH_Transportadora,
	
	/*LEO: CHAVE PARA ESTOQUE DE BOBINAS*/
	CASE
		WHEN C6.C6_ACONDIC = 'B'
			THEN RTRIM(LTRIM(F2.F2_FILIAL)) + RTRIM(LTRIM(C6.C6_PRODUTO))
		    ELSE ''
	END											As CH_BOB,
	
			
	/*------------------------------------*/
	/*CAMPOS DA TABELA                    */
	/*------------------------------------*/
	/*CABEÇALHO NOTA FISCAL               */
	/*------------------------------------*/
	'Faturamento'									AS Origem,					/*IDENTIFICAÇÃO DO REGISTRO NA TABELA FATO*/
	F2.F2_FILIAL									AS Filial,
   	F2.F2_SERIE										AS Serie,
   	F2.F2_DOC										AS NotaFiscal,
	F2.F2_CLIENTE+'-'+F2.F2_LOJA					AS ClienteLoja,
	F2.F2_COND										AS CondicaoPagamento,
	/*------------------------------------*/
	CASE
		WHEN F2.F2_VEND1 = ''
			THEN 'N/I'
		ELSE F2.F2_VEND1
	END												AS Representante,
	/*------------------------------------*/
	ISNULL(A3.A3_GEREN,'N/I')						AS GerenteVendas,
   	CASE
   		WHEN F2.F2_EMISSAO = ''
   		THEN NULL
   		ELSE CAST(F2.F2_EMISSAO AS DATE)
	END												AS Emissao,
	CASE
		WHEN F2.F2_EMISSAO = ''
		THEN ''
		ELSE SUBSTRING(F2.F2_EMISSAO,1,4)
	END												AS EmissaoAno,
	CASE
		WHEN F2.F2_EMISSAO = ''
		THEN ''
		ELSE SUBSTRING(F2.F2_EMISSAO,5,2)
	END												AS EmissaoMes,
	
	CASE
		WHEN F2.F2_EMISSAO = ''
		THEN ''
		ELSE DATEPART(WK, CAST(F2.F2_EMISSAO AS DATETIME)) - 
			 DATEPART(WK, CAST(F2.F2_EMISSAO AS DATETIME) - 
			 DAY(CAST(F2.F2_EMISSAO AS DATETIME)) + 1) + 1			
	END												AS EmissaoSemana,
	
	CASE
		WHEN F2.F2_EMISSAO = ''
		THEN ''
		ELSE SUBSTRING(F2.F2_EMISSAO,7,2)
	END												AS EmissaoDia,
	/*------------------------------------*/
	
	/*------------------------------------*/
	CASE
   		WHEN F2.F2_EMISSAO = '' OR A3.A3_GEREN = NULL  
   		THEN 'N/I'
   		ELSE ISNULL( ( SELECT ZZP.ZZP_PERIOD FROM ZZP010 ZZP WHERE F2.F2_EMISSAO BETWEEN ZZP.ZZP_INICIO AND ZZP.ZZP_FINAL AND ZZP.D_E_L_E_T_ <>'*'  ) 
   				+ A3.A3_GEREN ,'N/I')
	END											AS CH_PeriodoGerente,
	
	CASE
   		WHEN F2.F2_EMISSAO = '' OR A3.A3_GEREN = NULL  
   		THEN 'N/I'
   		ELSE  ISNULL(( SELECT ZZP.ZZP_PERIOD FROM ZZP010 ZZP WHERE F2.F2_EMISSAO BETWEEN ZZP.ZZP_INICIO AND ZZP.ZZP_FINAL AND ZZP.D_E_L_E_T_ <>'*' ),'N/I') 
	END											AS CH_Periodo,
	
	/*------------------------------------*/
	
	CASE
		WHEN F2.F2_MOEDA = '1'
			THEN 'REAL'
		WHEN F2.F2_MOEDA = '2'
			THEN 'DOLAR'
		WHEN F2.F2_MOEDA = '3'
			THEN 'UFIR'
		WHEN F2.F2_MOEDA = '4'
			THEN 'COBRE (LME)'
		WHEN F2.F2_MOEDA = '5'
			THEN 'N/I'
		ELSE 'N/I'
	END												AS Moeda,
	/*------------------------------------*/
	CASE
		WHEN A1.A1_SEGMENT = ''
			THEN 'N/I'
		ELSE A1.A1_SEGMENT
	END												AS Segmento,
	/*------------------------------------*/
	CASE
		WHEN F2.F2_TRANSP = ''
			THEN 'N/I'
		ELSE F2.F2_TRANSP
	END												AS Transportadora,
	/*------------------------------------*/
   	CASE
		WHEN F2.F2_TPFRETE = 'C'
			THEN 'CIF'
		WHEN F2.F2_TPFRETE = 'F'
			THEN 'FOB'
		WHEN F2.F2_TPFRETE = 'T'
			THEN 'TERCEIROS'
		WHEN F2.F2_TPFRETE = 'S'
			THEN 'SEM FRETE'
		ELSE 'N/I'
	END												AS TipoFrete,
	/*------------------------------------*/
    CASE
		WHEN A1.A1_EST IN ('RO', 'AC', 'AM', 'RR', 'PA', 'AP', 'TO' )
			THEN 'NORTE'
		WHEN A1.A1_EST IN ('MA', 'PI', 'CE', 'RN', 'PB', 'PE', 'AL', 'SE', 'BA')
			THEN 'NORDESTE' 
		WHEN A1.A1_EST IN ('MG', 'ES', 'RJ', 'SP')
			THEN 'SUDESTE'
		WHEN A1.A1_EST IN ('PR', 'SC', 'RS')
			THEN 'SUL'
		WHEN A1.A1_EST IN ('MS', 'MT', 'GO', 'DF')
			THEN 'CENTRO-OESTE'
		WHEN A1.A1_EST IN ('EX')
			THEN 'MERCADO EXTERNO'
		ELSE 'N/I'
	END												AS Regiao,
	/*------------------------------------*/
   	CASE
   		WHEN C5.C5_DRC = 0 
   			THEN 'NAO'
   		ELSE
		   	CASE
		   		WHEN C5.C5_DRCPROD = 'S'
   					THEN 'SIM (PRODUZIR)'
   				ELSE 'SIM (NAO PRODUZIR)'
   			END
   	END												AS DRC,						/*DRC-Devolução e Reclamação de Cliente*/
	
	/*------------------------------------*/
	CASE 
		WHEN C5.C5_ZTPVEND = ''
			THEN 'N'
		ELSE C5.C5_ZTPVEND
	END												AS TipoVenda,
	/*------------------------------------*/

	/*------------------------------------*/
	/*ITENS NOTA FISCAL                   */
	/*------------------------------------*/
	D2.D2_ITEM										AS Item,
	D2.D2_COD										AS Produto,
	/*------------------------------------*/
	/*
	CASE
		WHEN DB.DB_LOCALIZ IS NOT NULL
		THEN 
			CASE
				WHEN SUBSTRING(DB.DB_LOCALIZ,2,5) = ''
				THEN 1
				ELSE CAST(SUBSTRING(DB.DB_LOCALIZ,2,5)AS INT)
			END												
		ELSE 1
	END												AS TamanhoLance,			/*Não pode ser zero, pois será usado em conta de divisão (QtdeVolumes)*/
	*/
  	C6.C6_METRAGE									AS TamanhoLance,			/*Tamanho do Lance em Metros*/
	
	/*------------------------------------*/
	/*DEFINIÇÕES PEDIDOS ITENS INDUSTRIALIZAÇÃO (LEO/JEF - 10/09/15), 
		([UPD]-LEO - 07/03/16)      */
	/*------------------------------------*/
   	CASE
		WHEN C6.C6_ZZPVORI <> ''
			THEN
				CASE
					WHEN C6.C6_LOCAL = '10'
						THEN 'TRIANGULACAO'
						
					ELSE	'INDUSTRIALIZACAO'
				END 
		ELSE
			CASE 
				WHEN C6.C6_LOCAL = '10'
				
					THEN	'TRIANGULACAO'
				
				WHEN C6.C6_SEMANA = 'TAUTOM'
					THEN 'INDUSTRIALIZACAO'
				
				ELSE 'VENDA NORMAL'
				
			END 								
	END											AS ItemIndl,
	
	/*------------------------------------*/
	/*
	CASE
		WHEN SUBSTRING(DB.DB_LOCALIZ,1,1) = 'R'
			THEN 'ROLO'
		WHEN SUBSTRING(DB.DB_LOCALIZ,1,1) = 'B'
			THEN 'BOBINA'
		WHEN SUBSTRING(DB.DB_LOCALIZ,1,1) = 'C'
			THEN 'CARRETEL PLASTICO'
		WHEN SUBSTRING(DB.DB_LOCALIZ,1,1) = 'M'
			THEN 'CARRETEL MADEIRA'
		WHEN SUBSTRING(DB.DB_LOCALIZ,1,1) = 'T'
			THEN 'RETALHO'
		WHEN SUBSTRING(DB.DB_LOCALIZ,1,1) = 'L'
			THEN 'BLISTER'
		ELSE 'INVALIDO'							
	END												AS Acondicionamento,								
	*/
		CASE
		WHEN C6.C6_ACONDIC = 'R'
			THEN 'ROLO'
		WHEN C6.C6_ACONDIC = 'B'
			THEN 'BOBINA'
		WHEN C6.C6_ACONDIC = 'C'
			THEN 'CARRETEL PLASTICO'
		WHEN C6.C6_ACONDIC = 'M'
			THEN 'CARRETEL MADEIRA'
		WHEN C6.C6_ACONDIC = 'T'
			THEN 'RETALHO'
		WHEN C6.C6_ACONDIC = 'L'
			THEN 'BLISTER'
		ELSE 'N/I'
	END												AS Acondicionamento,
	
	/* TIPO DE BOBINA 06/02/21 - LEO*/
	CASE
		WHEN C6.C6_ACONDIC = 'B'
			THEN ISNULL(dbo.GET_BOBINA(C6.C6_METRAGE,C6.C6_PRODUTO,F2.F2_CLIENTE,F2.F2_LOJA),'')
			ELSE ''
	END											As TipoBobina,

	/* METRAGEM MAX BOBINA 11/02/21 - LEO */
	CASE
		WHEN C6.C6_ACONDIC = 'B'
			THEN ISNULL(dbo.GET_BOBMAX_MTR(C6.C6_METRAGE,C6.C6_PRODUTO,F2.F2_CLIENTE,F2.F2_LOJA),'')
		    ELSE ''
	END											As MaxMtrBobina,
	/* METRAGEM MAX BOBINA 11/02/21 - LEO */
	CASE
		WHEN C6.C6_ACONDIC = 'B'
			THEN ISNULL(dbo.GET_BEST_BOB(C6.C6_METRAGE,C6.C6_PRODUTO,F2.F2_CLIENTE,F2.F2_LOJA),'')
		    ELSE ''
	END											As MelhorBobina,

	/* IDENTIFICA SE BOBINA PADRÃO 17/02/21 - LEO */
	CASE
		WHEN C6.C6_ACONDIC = 'B'
			THEN isnull(dbo.IS_BOBPAD(C6.C6_METRAGE, C6.C6_PRODUTO), 'E')
			ELSE ''
	END As LancePad,

	/*------------------------------------*/
	/*MÉTRICAS                            */
	/*------------------------------------*/
	CASE
		WHEN C6.C6_ACONDIC NOT IN ('R','B','C','M','T','L')
		THEN 0
		ELSE
			CASE
				WHEN C6.C6_METRAGE <= 0
				THEN D2.D2_QUANT / 1
				ELSE D2.D2_QUANT / C6.C6_METRAGE
			END
	END												AS QtdeVolumes,				/*Calculado com base em SC6, analisar trecho anterior se mudar critério para SDB*/
	D2.D2_QUANT										AS QtdeVendidaItem,
	D2.D2_PRCVEN									AS ValorUnitarioItem,
	D2.D2_TOTAL										AS ValorTotalItem,
	D2.D2_COMIS1									AS PorcentComissaoItem,		/*Porcentagem de Comissão no Item*/
  	C6.C6_LUCROBR									AS PorcentLucroBrutoItem,	/*Porcentagem Lucro Bruto no Item (Origem Pedido Vendas)*/
	D2.D2_BASEICM									AS BaseCalculoICMS,
	D2.D2_VALICM									AS ValorICMS,
	D2.D2_VALIPI									AS ValorIPI,
	D2.D2_PICM										AS AliquotaICMS,
	D2.D2_IPI										AS AliquotaIPI,
	D2.D2_TES										AS Tes,
	F4.F4_ESTOQUE									AS Estoque,
	/*------------------------------------*/
	/*Calcula DiasExpedirFaturado         */
	/*------------------------------------*/
	CASE
		/*Verifica se EmissãoNotaFiscal está vazia ou DataExpedição < EmissãoNotaFiscal*/
		WHEN F2.F2_EMISSAO = '' OR F2.F2_DTENTR < F2.F2_EMISSAO
		THEN 0
		ELSE
			CASE
  				/*Verifica se DataExpedição está vazia*/
				WHEN F2.F2_DTENTR = ''
				THEN 
					/*Calcula EmissãoNotaFiscal x DataAtual*/
					DATEDIFF(DAY,CONVERT(DATETIME,F2.F2_EMISSAO),CAST(CAST(GETDATE() AS DATE) As DATETIME))
				ELSE
					/*Calcula EmissãoNotaFiscal x DataExpedição*/
					DATEDIFF(DAY,CONVERT(DATETIME,F2.F2_EMISSAO),CONVERT(DATETIME,F2.F2_DTENTR))
			END
   	END												AS DiasExpedirFaturado,		/*Lead Time Expedir Faturado*/
	/*------------------------------------*/
	/*Calcula PrazoExpediçãoReal          */
	/*alterado em 14/10/15, (Crispilho/jeferosn/leonardo)
	REGRA PARA CALCULAR O PRAZO REAL DE SAIDA DA NOTA, CONSIDERA-SE A DIFERENÇA DE DIAS
	ENTRE A (C5_EMISSAO E F2_DTENTR), EXISTEM CASOS ONDE: 
	O F2.F2_DTENTR É MENOR QUE A EMISSÃO SOLUÇÃO( CONSIDERAR A F2.F2_EMISSÃO )
	O F2.F2_DTENTR MAIOR QUE A (F2.F2_EMISSÃO+60) (CONSIDERAR A F2.F2_EMISSAO + 5
	O F2.F2_DTENTR ESTA VAZIO, NORMALMENTE CONSIDERA A DATA CARGA (F2.EMISSAO = 2014 DATA CARGA =  2015) */
	/*------------------------------------*/
  	CASE
  		/*Verifica se EmissãoPedido está vazio*/
		WHEN C5.C5_EMISSAO = ''
		THEN 0
		ELSE
			CASE
  				/*Verifica se DataExpedição está vazia*/
				WHEN F2.F2_DTENTR = ''
				THEN 
					CASE	
						WHEN CAST(CAST(GETDATE() AS DATE) As DATETIME) > (CAST(F2.F2_EMISSAO AS DATETIME)+ 60)
						THEN
							DATEDIFF(DAY,CONVERT(DATETIME,C5.C5_EMISSAO),(CONVERT(DATETIME,F2.F2_EMISSAO) + 5))	
						ELSE
							/*Calcula EmissãoPedido x DataAtual*/
							DATEDIFF(DAY,CONVERT(DATETIME,C5.C5_EMISSAO),CAST(CAST(GETDATE() AS DATE) As DATETIME))
					END
				WHEN ( F2.F2_DTENTR < F2.F2_EMISSAO )
				
				THEN
					 /*Quando a data de entrega é menor que a data emissão considerar a data emissão*/
					DATEDIFF(DAY,CONVERT(DATETIME,C5.C5_EMISSAO),CONVERT(DATETIME,F2.F2_EMISSAO))
				
				WHEN (CAST(F2.F2_DTENTR AS DATETIME) > (CAST(F2.F2_EMISSAO AS DATETIME)+ 60) )
					/*Quando a data de entrega é maior que a data de emissão considerar data emissão mais 5 dias */
				THEN
					DATEDIFF(DAY,CONVERT(DATETIME,C5.C5_EMISSAO),(CONVERT(DATETIME,F2.F2_EMISSAO) + 5))
				ELSE
					/*Calcula EmissãoPedido x DataExpedição*/
					DATEDIFF(DAY,CONVERT(DATETIME,C5.C5_EMISSAO),CONVERT(DATETIME,F2.F2_DTENTR))
			END
	END											AS PrazoExpedicaoReal,			/*Prazo de Expedição Real (Saída da Cobrecom)*/	

	/*Campo com a data entrega considerada no calculo do prazo*/
	CASE
		WHEN C5.C5_EMISSAO = ''
			THEN ''
			ELSE
				CASE
					WHEN F2.F2_DTENTR = ''
					THEN 
						CASE	
							WHEN CAST(CAST(GETDATE() AS DATE) As DATETIME) > (CAST(F2.F2_EMISSAO AS DATETIME)+ 60)
							THEN
								  CONVERT( DATE,CAST(F2.F2_EMISSAO AS DATETIME) + 5) 	
							ELSE
								 CAST(GETDATE() AS DATE) 
						END
					WHEN ( F2.F2_DTENTR < F2.F2_EMISSAO )
					
					THEN
							CAST(F2.F2_EMISSAO AS DATE)
					
					WHEN (CAST(F2.F2_DTENTR AS DATETIME) > (CAST(F2.F2_EMISSAO AS DATETIME)+ 60) )
			
					THEN
						 CONVERT( DATE,CAST(F2.F2_EMISSAO AS DATETIME) + 5) 
					ELSE
						
						 CAST(F2.F2_DTENTR AS DATE)
				END
	END											AS SaidaNota,				
	CAST(C5.C5_EMISSAO AS DATE)					AS EmissãoPedido,
	C6.C6_NUM									AS NumeroPedido,
	C6.C6_ITEM									AS ItemPedido,
	
	/*------------------------------------*/
	/*Calcula DiasEfetivarOrcamento       */
	/*------------------------------------*/
   	CASE
  		/*Verifica se Pedido foi originado de Orçamento*/
		WHEN C6.C6_NUMORC = ''
		THEN 0
   		ELSE
		  	CASE
		  		/*Verifica se EmissãoOrçamento ou EmissãoPedido estão vazios*/
				WHEN CJ.CJ_EMISSAO = '' OR C5.C5_EMISSAO = ''
				THEN 0
				ELSE
					CASE
  						/*Verifica se EmissãoPedido menor/igual que EmissãoOrçamento*/
						WHEN C5.C5_EMISSAO <= CJ.CJ_EMISSAO
						THEN 0
						ELSE DATEDIFF(DAY,CONVERT(DATETIME,CJ.CJ_EMISSAO),CONVERT(DATETIME,C5.C5_EMISSAO))
					END
			END
   	END														AS DiasEfetivarOrcamento,	/*Lead Time Efetivar Orçamento*/
	
	CASE
		WHEN CJ.CJ_EMISSAO IS NULL OR CJ.CJ_EMISSAO = ''
		THEN ''
		ELSE
		CAST(CJ.CJ_EMISSAO AS DATE)								
	END														AS EmissaoOrcamento,
	
	CASE
		WHEN CJ.CJ_NUM IS NULL OR CJ.CJ_NUM = ''
		THEN ''
		ELSE
			CJ.CJ_NUM								
	END														AS NumeroOrcamento,
	
	/*
	/*--------------------------------------------------------------------------*/
	/*Campos usados para validar os Prazos/Lead Times                           */
	/*--------------------------------------------------------------------------*/
	C5.C5_EMISSAO								AS EMISSAO_PEDIDO,
	D2.D2_EMISSAO								AS EMISSAO_NOTA,
	F2.F2_DTENTR								AS SAIDA_NOTA,
	*/
	/*---------------------------------------------------------------------------------------------*/
  	/*Cálculos Intermediários: Usados na consolidação da média do LB - Restante do calculo Qlikview*/
  	/*(23/11/2015)Jef/Leo/Rob -Utilizado o campo D2_QTD809 para obter o CustoTotaldoItem, pois as notas fiscais serie U Desconto no valor 
  	possui o campo D2.D2_QUANT zerado. */
  	/*---------------------------------------------------------------------------------------------*/
  	D2.D2_PRCVEN/((C6.C6_LUCROBR/100)+1)											AS CustoUnitarioItem, 
   (D2.D2_QUANT + ISNULL(D2.D2_QTD809,0)) * (D2.D2_PRCVEN/((C6.C6_LUCROBR/100)+1))	AS CustoTotalItem
   --D2.D2_QUANT * (D2.D2_PRCVEN/((C6.C6_LUCROBR/100)+1))	AS CustoTotalItem,
	
FROM SD2010 D2 WITH (NOLOCK)
	
	/*--------------------------------------------------------------------------*/
	/*SF4-CADASTRO DE TIPOS DE ENTRADA E SAÍDA (TES)                            */
	/*ÍNDICE 01: F4_FILIAL, F4_CODIGO, R_E_C_N_O_, D_E_L_E_T_                   */
	/*--------------------------------------------------------------------------*/
	INNER JOIN SF4010 F4 WITH (NOLOCK)
    ON ''								= F4.F4_FILIAL
    AND D2.D2_TES						= F4.F4_CODIGO
    AND D2.D_E_L_E_T_					= F4.D_E_L_E_T_
	/*--------------------------------------------------------------------------*/
	/*SC6-ITENS PEDIDO DE VENDAS                                                */
	/*ÍNDICE 01: C6_FILIAL, C6_NUM, C6_ITEM, C6_PRODUTO, R_E_C_N_O_, D_E_L_E_T_ */
	/*--------------------------------------------------------------------------*/
	INNER JOIN SC6010 C6 WITH (NOLOCK)
	ON	D2.D2_FILIAL					= C6.C6_FILIAL
	AND D2.D2_PEDIDO					= C6.C6_NUM
	AND D2.D2_ITEMPV					= C6.C6_ITEM
	AND D2.D2_COD						= C6.C6_PRODUTO
	AND D2.D_E_L_E_T_					= C6.D_E_L_E_T_
	/*--------------------------------------------------------------------------*/
	/*SC5-CABEÇALHO PEDIDO DE VENDAS                                            */
	/*ÍNDICE 01: C5_FILIAL, C5_NUM, R_E_C_N_O_, D_E_L_E_T_                      */
	/*--------------------------------------------------------------------------*/
	INNER JOIN SC5010 C5 WITH (NOLOCK)
	ON C6.C6_FILIAL						= C5.C5_FILIAL
	AND C6.C6_NUM						= C5.C5_NUM
	AND C6.D_E_L_E_T_					= C5.D_E_L_E_T_
	
	/*--------------------------------------------------------------------------*/
	/*SCK-ITENS DO ORÇAMENTO DE VENDAS                                          */
	/*ÍNDICE 01: CK_FILIAL, CK_NUM, CK_ITEM, CK_PRODUTO, R_E_C_N_O_, D_E_L_E_T_ */
	/*--------------------------------------------------------------------------*/
	LEFT JOIN SCK010 CK WITH (NOLOCK)
	ON ''				= CK.CK_FILIAL
	AND C6.C6_NUMORC	= CK.CK_NUM+CK.CK_ITEM
	AND C6.D_E_L_E_T_	= CK.D_E_L_E_T_
	/*--------------------------------------------------------------------------*/
	/*SCJ-CABEÇALHO DO ORÇAMENTO DE VENDAS                                      */
	/*ÍNDICE 01: CJ_FILIAL, CJ_NUM, CJ_CLIENTE, CJ_LOJA, R_E_C_N_O_, D_E_L_E_T_ */
	/*--------------------------------------------------------------------------*/
	LEFT JOIN SCJ010 CJ WITH (NOLOCK)
	ON CK.CK_FILIAL		= CJ.CJ_FILIAL
	AND CK.CK_NUM		= CJ.CJ_NUM
	AND CK.D_E_L_E_T_	= CJ.D_E_L_E_T_
	/*
	/*----------------------------------------------------------------------------------------------------------------------------*/
	/*SDB-MOVIMENTOS POR LOCALIZAÇÃO (NA COBRECOM, LOCALIZAÇÃO=ACONDICIONAMENTO)                                                  */
	/*ÍNDICE 01: DB_FILIAL, DB_PRODUTO, DB_LOCAL, DB_NUMSEQ, DB_DOC, DB_SERIE, DB_CLIFOR, DB_LOJA, DB_ITEM, R_E_C_N_O_, D_E_L_E_T_*/
	/*----------------------------------------------------------------------------------------------------------------------------*/
	LEFT JOIN SDB010 DB
	ON	D2.D2_FILIAL					= DB.DB_FILIAL
	AND D2.D2_COD						= DB.DB_PRODUTO
	AND D2.D2_LOCAL						= DB.DB_LOCAL
	AND D2.D2_NUMSEQ					= DB.DB_NUMSEQ
	AND D2.D2_DOC						= DB.DB_DOC
	AND D2.D2_SERIE						= DB.DB_SERIE
	AND D2.D_E_L_E_T_					= DB.D_E_L_E_T_
	*/
	/*------------------------------------------------------------------------------------------------------- */
	/*SF2-CABEÇALHO DA NOTA FISCAL DE SAÍDA                                                                   */
	/*ÍNDICE 01: F2_FILIAL, F2_DOC, F2_SERIE, F2_CLIENTE, F2_LOJA, F2_FORMUL, F2_TIPO, R_E_C_N_O_, D_E_L_E_T_ */
	/*------------------------------------------------------------------------------------------------------- */
	INNER JOIN SF2010 F2 WITH (NOLOCK)
	ON	D2.D2_FILIAL					= F2.F2_FILIAL
	AND D2.D2_DOC						= F2.F2_DOC
	AND D2.D2_SERIE						= F2.F2_SERIE
	AND D2.D2_CLIENTE					= F2.F2_CLIENTE
	AND D2.D2_LOJA						= F2.F2_LOJA
	AND D2.D_E_L_E_T_					= F2.D_E_L_E_T_
	/*--------------------------------------------------------------------------*/
	/*SA1-CADASTRO DE CLIENTES                                                  */
	/*ÍNDICE 01: A1_FILIAL, A1_COD, A1_LOJA, R_E_C_N_O_, D_E_L_E_T_             */
	/*--------------------------------------------------------------------------*/
	INNER JOIN SA1010 A1 WITH (NOLOCK)
	ON ''								= A1.A1_FILIAL
	AND F2.F2_CLIENTE					= A1.A1_COD
	AND F2.F2_LOJA						= A1.A1_LOJA
	AND F2.D_E_L_E_T_					= A1.D_E_L_E_T_
	/*--------------------------------------------------------------------------*/
	/*SA3-CADASTRO DE VENDEDORES (REPRESENTANTES/ATENDENTES/GERENTES VENDAS)    */
	/*ÍNDICE 01: A3_FILIAL, A3_COD, R_E_C_N_O_, D_E_L_E_T_                      */
	/*--------------------------------------------------------------------------*/
	LEFT JOIN SA3010 A3 WITH (NOLOCK)
	ON ''				= A3.A3_FILIAL
	AND F2.F2_VEND1		= A3.A3_COD
	AND F2.D_E_L_E_T_	= A3.D_E_L_E_T_
	
WHERE
	/*--------------------------------------------------------------------------*/
	/*SD2-ITENS DA NOTA FISCAL DE SAÍDA                                         */
	/*ÍNDICE 05: D2_FILIAL, D2_EMISSAO, D2_NUMSEQ, R_E_C_N_O_, D_E_L_E_T_       */
	/*--------------------------------------------------------------------------*/
	 D2.D2_FILIAL		IN ('01','02', '03')
	/*-------------------------------------------------------------------------------------------------------------------*/
	/*DATA DE EMISSÃO: A PARTIR DE JAN/2014                                                                              */
	/*-------------------------------------------------------------------------------------------------------------------*/
	--AND D2.D2_EMISSAO BETWEEN '20200501' AND '20200530'
	AND D2.D2_EMISSAO	>= '20160101'
	--AND D2.D2_EMISSAO	>= '20140101'
	AND D2.D2_EMISSAO	<= 
		CASE 
			WHEN SUBSTRING(CONVERT(VARCHAR(11),GETDATE(),114),1,2) = '05'	 
			THEN CONVERT(VARCHAR(11),(GETDATE()-1),112)					
			ELSE CONVERT(VARCHAR(11),GETDATE(),112)							
		END
	/*
	/*-------------------------------------------------------------------------------------------------------------------*/
	/*TIPOS DE OPERAÇÃO:                                                                                                 */
	/*CONSIDERADOS = VENDA (DEMAIS C6_CF)                                                                                */
	/*IGNORADOS    = TRANSFERENCIA (C6_CF = 6151/6152/6901)                                                              */
	/*               RETORNO DE TRANSFERENCIA (C6_CF = 6124/6902                                                         */
	/*  ** TESTES REALIZADOS NO DESENVOLVIMENTO DA QUERY NÃO IDENTIFICARAM A PRESENÇA DESTES TIPOS DE OPERAÇÃO COM OS    */
	/*     FILTROS UTILIZADOS.                                                                                           */
	/*-------------------------------------------------------------------------------------------------------------------*/
	AND D2_CF			NOT IN ('6151','6152','6901','6124','6902') 
	*/
	/*-------------------------------------------------------------------------------------------------------------------*/
	AND D2.D_E_L_E_T_	= ''
	/*-------------------------------------------------------------------------------------------------------------------*/
	/*TIPOS DE ENTRADA E SAÍDA QUE GERAM DUPLICATA A RECEBER.                                                            */
	/*-------------------------------------------------------------------------------------------------------------------*/
	AND F4.F4_DUPLIC	=	'S'
	/*-------------------------------------------------------------------------------------------------------------------*/
	/*TIPOS DE NOTA FISCAL:                                                                                              */
	/*CONSIDERADOS = NORMAL(N)                                                                                           */
	/*IGNORADOS    = COMPLEMENTO DE PREÇOS(C)/ICMS(I)/IPI(P)                                                             */
	/*               DEVOLUÇÃO(D)                                                                                        */
	/*               UTILIZA FORNECEDOR/BENEFICIAMENTO(B)                                                                */
	/*-------------------------------------------------------------------------------------------------------------------*/
	AND F2.F2_TIPO		= 	'N'
	/*-------------------------------------------------------------------------------------------------------------------*/
 	/*23/04/15 - A PEDIDO DO RAFAEL, FILTRAR (NÃO MOSTRAR) AS NOTAS FISCAIS DOS CLIENTES ABAIXO (VENDAS DIRETAS RAFAEL). */
	/*           POSTERIORMENTE, ANALISAR CRIAÇÃO DE DIFERENCIADOR PARA MOSTRAR ESTES ORÇAMENTOS SOMENTE PARA DIRETORIA. */
	/*-------------------------------------------------------------------------------------------------------------------*/
	AND F2.F2_CLIENTE NOT IN ('017449','017826','016227','017813','010188','017010','013478','015678','017011', '011248', '012677')
GO



