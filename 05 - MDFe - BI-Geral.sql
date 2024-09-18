--USE [IFC_P12]
--GO

/****** Object:  View [dbo].[BI_VW_MDFE_MANIFESTO_CARGA]    Script Date: 28/06/2024 09:45:18 ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO


--ALTER VIEW [dbo].[BI_VW_MDFE_MANIFESTO_CARGA]
--AS•




WITH XMLData AS (
    SELECT 

        CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), [CC0_XMLMDF])) AS XMLContent,
        (CC0.CC0_FILIAL),
        (CC0.CC0_SERMDF),
        (CC0.CC0_NUMMDF),
        (CC0.CC0_CHVMDF),
        (CC0.CC0_STATUS),
        (CC0.CC0_STATEV),
        (CC0.CC0_CODRET),
        (CC0.CC0_MSGRET),
        (CC0.CC0_PROTOC),
        (CC0.CC0_DTEMIS),
        (CC0_HREMIS),
        (CC0.CC0_UFINI),
        (CC0.CC0_UFFIM),
        (CC0.CC0_XMLMDF),
        (CC0.CC0_QTDNFE),
        (CC0.CC0_VTOTAL),
        (CC0.CC0_PESOB),
        (CC0.CC0_VEICUL),
        (CC0.CC0_TPEVEN),
        (CC0.CC0_TPNF),
        (CC0.CC0_CARGA),
        (CC0.CC0_VINCUL),
        (CC0.CC0_CARPST),
        (CC0.CC0_MOTORI),
        (CC0.CC0_MODAL),
        (CC0.D_E_L_E_T_),
        (DA4.DA4_COD),
        (DA4.DA4_NOME),
        (DA4.DA4_CGC),
        (DA4.DA4_MAT),
        (DA4.DA4_NUMCNH),
		(DA3.DA3_COD),
		(DA3.DA3_DESC),
		(DA3.DA3_PLACA),
		(DA3.DA3_RENAVA),
        CASE 
            WHEN CC0.CC0_STATUS = '1' THEN 'Transmitido'
            WHEN CC0.CC0_STATUS = '2' THEN 'Não Transmitido'
            WHEN CC0.CC0_STATUS = '3' THEN 'Autorizado'
            WHEN CC0.CC0_STATUS = '4' THEN 'Não Autorizado'
            WHEN CC0.CC0_STATUS = '5' THEN 'Cancelado'
            WHEN CC0.CC0_STATUS = '6' THEN 'Encerrado'
        END AS CC0_STATUS_DESC,
        CASE
            WHEN CC0.CC0_STATEV = '1' THEN 'Evento não Realizado'
            WHEN CC0.CC0_STATEV = '2' THEN 'Evento Realizado'
            WHEN CC0.CC0_STATEV = '3' THEN 'Evento Vinculado'
            WHEN CC0.CC0_STATEV = '4' THEN 'Evento não Vinculado'
            WHEN CC0.CC0_STATEV = ''  THEN ''
        END AS CC0_STATEV_DESC,
        CASE
            WHEN CC0.CC0_TPNF = '2' THEN 'NF Entrada'
            WHEN CC0.CC0_TPNF = '1' THEN 'NF Saída'
            WHEN CC0.CC0_TPNF = '3' THEN 'Outros'
        END AS CC0_TPNF_DESC,
				
		TIPOS_NF_ENTRADA = (Isnull((Stuff((Select '//'+F1_FILIAL+'-'+F1_DOC+'/'+F1_SERIE+'TIPO'+'-'+F1_TIPO+'-'+
											Case 
											When F1_TIPO = 'N' Then 'NF Normal'
											When F1_TIPO = 'C' Then 'Compl. Preco'
											When F1_TIPO = 'D' Then 'Devolucao'
											When F1_TIPO = 'I' Then ' NF Compl. ICMS'
											When F1_TIPO = 'P' Then 'NF Compl. IPI'
											When F1_TIPO = 'B' Then 'NF Beneficiamento'
											End --as TIPO
											+ '//'

											From SF1010 SF1 With(Nolock)							
											Where (CC0.CC0_FILIAL = SF1.F1_FILIAL
													Or	CC0.CC0_VEICUL = F1_VEICUL1)
											AND CC0.CC0_NUMMDF = SF1.F1_NUMMDF	
											AND CC0.CC0_SERMDF = SF1.F1_SERMDF	
											AND SF1.D_E_L_E_T_ = CC0.D_E_L_E_T_
											For XML Path ('')),1,1,'')),'')),

		TIPOS_NF_SAIDA = (Isnull((Stuff((Select '//'+F2_FILIAL+'-'+F2_DOC+'/'+F2_SERIE+'TIPO'+'-'+F2_TIPO+'-'+
											Case 
											When F2_TIPO = 'N' Then 'NF Normal'
											When F2_TIPO = 'C' Then 'Compl. Preco'
											When F2_TIPO = 'D' Then 'Devolucao'
											When F2_TIPO = 'I' Then ' NF Compl. ICMS'
											When F2_TIPO = 'P' Then 'NF Compl. IPI'
											When F2_TIPO = 'B' Then 'NF Beneficiamento'
											End --as TIPO
											+ '//'

											From SF2010 SF2 With(Nolock)							
											Where (CC0.CC0_FILIAL = SF2.F2_FILIAL
													Or CC0.CC0_VEICUL = F2_VEICUL1)
											AND CC0.CC0_NUMMDF = SF2.F2_NUMMDF	
											AND CC0.CC0_SERMDF = SF2.F2_SERMDF	
											AND SF2.D_E_L_E_T_ = CC0.D_E_L_E_T_
											For XML Path ('')),1,1,'')),'')),

	TIPOS_NF_ENTRADA_IND = (Isnull((Stuff((Select '//'+F1_FILIAL+'-'+F1_DOC+'/'+F1_SERIE+'TIPO'+'-'+F1_TIPO+'-'+
											Case 
											When F1_OBSTRF <> '' Then 'Industrialização'
											When F1_OBSTRF = '' Then ''
											End --as TIPO
											
											+'Obs'
											+ F1_OBSTRF											
											+ '//'

											From SF1010 SF1 With(Nolock)							
											Where (CC0.CC0_FILIAL = SF1.F1_FILIAL
													Or	CC0.CC0_VEICUL = F1_VEICUL1)
											AND CC0.CC0_NUMMDF = SF1.F1_NUMMDF	
											AND CC0.CC0_SERMDF = SF1.F1_SERMDF	
											AND F1_OBSTRF <> ''
											AND SF1.D_E_L_E_T_ = CC0.D_E_L_E_T_
											For XML Path ('')),1,1,'')),'')),

												
	TIPOS_NF_SAIDA_IND = (Isnull((Stuff((Select '//'+F2_FILIAL+'-'+F2_DOC+'/'+F2_SERIE+'TIPO'+'-'+F2_TIPO+'-'
											+'/'+
											Case 
											When D2_XOPER = '09' Then 'Industrialização'
											When D2_XOPER <> '09' Then ''
											End --as TIPO
											+'/'											
											+'Obs'
											+'/'
											+ D2_XOPER											
											+ '//'

											From SF2010 SF2 With(Nolock)
											
											Inner Join SD2010 SD2 With(Nolock) -- NF Saida Itens 
											On F2_FILIAL = D2_FILIAL
											And F2_DOC = D2_DOC
											And F2_SERIE = D2_SERIE
											And F2_CLIENTE = D2_CLIENTE
											And F2_LOJA = D2_LOJA
											And SD2.D_E_L_E_T_ = ''
															

											Where (CC0.CC0_FILIAL = SF2.F2_FILIAL
													Or	CC0.CC0_VEICUL = F2_VEICUL1)
											AND CC0.CC0_NUMMDF = SF2.F2_NUMMDF	
											AND CC0.CC0_SERMDF = SF2.F2_SERMDF	
											AND D2_XOPER = '09'
											AND SF2.D_E_L_E_T_ = CC0.D_E_L_E_T_
											For XML Path ('')),1,1,'')),'')),		

		TIPOS_NF_ENTRADA_QTDE_TIPO = (Isnull((Stuff((Select '//'+Convert(varchar,Count(F1_TIPO))+'/'+ 
											Case 
											When F1_TIPO = 'N' Then 'NF Normal'
											When F1_TIPO = 'C' Then 'Compl. Preco'
											When F1_TIPO = 'D' Then 'Devolucao'
											When F1_TIPO = 'I' Then ' NF Compl. ICMS'
											When F1_TIPO = 'P' Then 'NF Compl. IPI'
											When F1_TIPO = 'B' Then 'NF Beneficiamento'
											End --as TIPO*/
											+'//'
											
											From SF1010 SF1 With(Nolock)							
											Where (CC0.CC0_FILIAL = SF1.F1_FILIAL
													Or	CC0.CC0_VEICUL = F1_VEICUL1)
											AND CC0.CC0_NUMMDF = SF1.F1_NUMMDF	
											AND CC0.CC0_SERMDF = SF1.F1_SERMDF	
											AND SF1.D_E_L_E_T_ = CC0.D_E_L_E_T_
											Group By F1_TIPO
											For XML Path ('')),1,1,'')),'')),



		TIPOS_NF_SAIDA_QTDE_TIPO = (Isnull((Stuff((Select '//'+Convert(varchar,Count(F2_TIPO))+'/'+ 
												Case 
												When F2_TIPO = 'N' Then 'NF Normal'
												When F2_TIPO = 'C' Then 'Compl. Preco'
												When F2_TIPO = 'D' Then 'Devolucao'
												When F2_TIPO = 'I' Then ' NF Compl. ICMS'
												When F2_TIPO = 'P' Then 'NF Compl. IPI'
												When F2_TIPO = 'B' Then 'NF Beneficiamento'
												End --as TIPO*/
												+'//'
												
												From SF2010 SF2 With(Nolock)							
												Where (CC0.CC0_FILIAL = SF2.F2_FILIAL
														Or	CC0.CC0_VEICUL = F2_VEICUL1)
												AND CC0.CC0_NUMMDF = SF2.F2_NUMMDF	
												AND CC0.CC0_SERMDF = SF2.F2_SERMDF	
												AND SF2.D_E_L_E_T_ = CC0.D_E_L_E_T_
												Group By F2_TIPO
												For XML Path ('')),1,1,'')),'')),


		NF_ENTRADA_QTDE = (Isnull((Select Count(F1_TIPO)												
									From SF1010 SF1 With(Nolock)							
									Where (CC0.CC0_FILIAL = SF1.F1_FILIAL
											Or	CC0.CC0_VEICUL = F1_VEICUL1)
									AND CC0.CC0_NUMMDF = SF1.F1_NUMMDF	
									AND CC0.CC0_SERMDF = SF1.F1_SERMDF	
									AND SF1.D_E_L_E_T_ = CC0.D_E_L_E_T_),'')),

		NF_SAIDA_QTDE = (Isnull((Select Count(F2_TIPO)												
									From SF2010 SF2 With(Nolock)							
									Where (CC0.CC0_FILIAL = SF2.F2_FILIAL
											Or	CC0.CC0_VEICUL = F2_VEICUL1)
									AND CC0.CC0_NUMMDF = SF2.F2_NUMMDF	
									AND CC0.CC0_SERMDF = SF2.F2_SERMDF	
									AND SF2.D_E_L_E_T_ = CC0.D_E_L_E_T_),'')),

		NF_TOTAL_QTDE = (Isnull((Select Count(F1_TIPO)												
									From SF1010 SF1 With(Nolock)							
									Where (CC0.CC0_FILIAL = SF1.F1_FILIAL
											Or	CC0.CC0_VEICUL = F1_VEICUL1)
									AND CC0.CC0_NUMMDF = SF1.F1_NUMMDF	
									AND CC0.CC0_SERMDF = SF1.F1_SERMDF	
									AND SF1.D_E_L_E_T_ = CC0.D_E_L_E_T_),'')) + 

						(Isnull((Select Count(F2_TIPO)												
									From SF2010 SF2 With(Nolock)							
									Where (CC0.CC0_FILIAL = SF2.F2_FILIAL
											Or	CC0.CC0_VEICUL = F2_VEICUL1)
									AND CC0.CC0_NUMMDF = SF2.F2_NUMMDF	
									AND CC0.CC0_SERMDF = SF2.F2_SERMDF	
									AND SF2.D_E_L_E_T_ = CC0.D_E_L_E_T_),'')),

		TIPOS_NF_ENTRADA_PRODUTOS = (Isnull((Stuff((Select 
														'//'+'QTDE'+'-'+
															(Convert(varchar,Count(D1_COD)))+
															'/'+
															Ltrim(Rtrim(B1_TIPO))+
															'-'+
															Ltrim(Rtrim(X5_DESCRI))+
															 '/'+
															 Ltrim(Rtrim(BM_GRUPO))+
															 '-'+
															 Ltrim(Rtrim(BM_DESC))+
															 '/'+
															Ltrim(Rtrim(D1_COD))+
															'/'+
															Ltrim(Rtrim(B1_DESC))+
														'//' 
											
														From SF1010 SF1 With(Nolock)
														
														Inner Join SD1010 SD1 With(Nolock) -- NF Entrada Cab
														On F1_FILIAL = D1_FILIAL
														And F1_DOC = D1_DOC
														And F1_SERIE = D1_SERIE
														And F1_FORNECE = D1_FORNECE
														And F1_LOJA = D1_LOJA
														And SD1.D_E_L_E_T_ = ''
														
														Inner Join SB1010 SB1 With(Nolock) -- Produtos
														On D1_COD = B1_COD
														And SD1.D_E_L_E_T_ = ''
														
														Inner Join SX5010 SX5 With(Nolock) -- Genericas Tipos Produtos 
														On X5_TABELA = '02' 
														And X5_CHAVE = B1_TIPO
														And SX5.D_E_L_E_T_ = ''
														
														Inner Join SBM010 SBM With(Nolock) -- Grupos Produtos 
														On BM_GRUPO = B1_GRUPO
														And SBM.D_E_L_E_T_ = ''


														Where (CC0.CC0_FILIAL = SF1.F1_FILIAL
																Or	CC0.CC0_VEICUL = F1_VEICUL1)
														AND CC0.CC0_NUMMDF = SF1.F1_NUMMDF	
														AND CC0.CC0_SERMDF = SF1.F1_SERMDF	
														AND SF1.D_E_L_E_T_ = CC0.D_E_L_E_T_
														Group By D1_COD,B1_TIPO,X5_DESCRI,B1_DESC,BM_GRUPO,BM_DESC
														For XML Path ('')),1,1,'')),'')),

		TIPOS_NF_ENTRADA_TIPOS_PRODUTOS = (Isnull((Stuff((Select 
															'//'+'QTDE'+'-'+
																(Convert(varchar,Count( B1_TIPO)))+
																'/'+
																Ltrim(Rtrim(B1_TIPO))+
																'-'+
																Ltrim(Rtrim(X5_DESCRI))+
																'/'+
																Ltrim(Rtrim(BM_GRUPO))+
																'-'+
																Ltrim(Rtrim(BM_DESC))+
																'/'+
															'//' 
											
															From SF1010 SF1 With(Nolock)
															
															Inner Join SD1010 SD1 With(Nolock) -- NF Entrada Cab
															On F1_FILIAL = D1_FILIAL
															And F1_DOC = D1_DOC
															And F1_SERIE = D1_SERIE
															And F1_FORNECE = D1_FORNECE
															And F1_LOJA = D1_LOJA
															And SD1.D_E_L_E_T_ = ''
															
															Inner Join SB1010 SB1 With(Nolock) -- Produtos
															On D1_COD = B1_COD
															And SD1.D_E_L_E_T_ = ''
															
															Inner Join SX5010 SX5 With(Nolock) -- Genericas Tipos Produtos 
															On X5_TABELA = '02' 
															And X5_CHAVE = B1_TIPO
															And SX5.D_E_L_E_T_ = ''
															
															Inner Join SBM010 SBM With(Nolock) -- Grupos Produtos 
															On BM_GRUPO = B1_GRUPO
															And SBM.D_E_L_E_T_ = ''


															Where (CC0.CC0_FILIAL = SF1.F1_FILIAL
																	Or	CC0.CC0_VEICUL = F1_VEICUL1)
															AND CC0.CC0_NUMMDF = SF1.F1_NUMMDF	
															AND CC0.CC0_SERMDF = SF1.F1_SERMDF	
															AND SF1.D_E_L_E_T_ = CC0.D_E_L_E_T_
															Group By B1_TIPO,X5_DESCRI,BM_GRUPO,BM_DESC
															For XML Path ('')),1,1,'')),'')),

		TIPOS_NF_SAIDA_PRODUTOS = (Isnull((Stuff((Select 
														'//'+'QTDE'+'-'+
															(Convert(varchar,Count(D2_COD)))+
															'/'+
															Ltrim(Rtrim(B1_TIPO))+
															'-'+
															Ltrim(Rtrim(X5_DESCRI))+
															 '/'+
															 Ltrim(Rtrim(BM_GRUPO))+
															 '-'+
															 Ltrim(Rtrim(BM_DESC))+
															 '/'+
															Ltrim(Rtrim(D2_COD))+
															'/'+
															Ltrim(Rtrim(B1_DESC))+
														'//' 
											
														From SF2010 SF2 With(Nolock)
														
														Inner Join SD2010 SD2 With(Nolock) -- NF Entrada Cab
														On F2_FILIAL = D2_FILIAL
														And F2_DOC = D2_DOC
														And F2_SERIE = D2_SERIE
														And F2_CLIENTE = D2_CLIENTE
														And F2_LOJA = D2_LOJA
														And SD2.D_E_L_E_T_ = ''
														
														Inner Join SB1010 SB1 With(Nolock) -- Produtos
														On D2_COD = B1_COD
														And SD2.D_E_L_E_T_ = ''
														
														Inner Join SX5010 SX5 With(Nolock) -- Genericas Tipos Produtos 
														On X5_TABELA = '02' 
														And X5_CHAVE = B1_TIPO
														And SX5.D_E_L_E_T_ = ''
														
														Inner Join SBM010 SBM With(Nolock) -- Grupos Produtos 
														On BM_GRUPO = B1_GRUPO
														And SBM.D_E_L_E_T_ = ''


														Where (CC0.CC0_FILIAL = SF2.F2_FILIAL
																Or	CC0.CC0_VEICUL = F2_VEICUL1)
														AND CC0.CC0_NUMMDF = SF2.F2_NUMMDF	
														AND CC0.CC0_SERMDF = SF2.F2_SERMDF	
														AND SF2.D_E_L_E_T_ = CC0.D_E_L_E_T_
														Group By D2_COD,B1_TIPO,X5_DESCRI,B1_DESC,BM_GRUPO,BM_DESC
														For XML Path ('')),1,1,'')),'')),

		TIPOS_NF_SAIDA_TIPOS_PRODUTOS = (Isnull((Stuff((Select 
															'//'+'QTDE'+'-'+
																(Convert(varchar,Count( B1_TIPO)))+
																'/'+
																Ltrim(Rtrim(B1_TIPO))+
																'-'+
																Ltrim(Rtrim(X5_DESCRI))+
																'/'+
																Ltrim(Rtrim(BM_GRUPO))+
																'-'+
																Ltrim(Rtrim(BM_DESC))+
																'/'+
															'//' 
											
															From SF2010 SF2 With(Nolock)
															
															Inner Join SD2010 SD2 With(Nolock) -- NF Entrada Cab
															On F2_FILIAL = D2_FILIAL
															And F2_DOC = D2_DOC
															And F2_SERIE = D2_SERIE
															And F2_CLIENTE = D2_CLIENTE
															And F2_LOJA = D2_LOJA
															And SD2.D_E_L_E_T_ = ''
															
															Inner Join SB1010 SB1 With(Nolock) -- Produtos
															On D2_COD = B1_COD
															And SD2.D_E_L_E_T_ = ''
															
															Inner Join SX5010 SX5 With(Nolock) -- Genericas Tipos Produtos 
															On X5_TABELA = '02' 
															And X5_CHAVE = B1_TIPO
															And SX5.D_E_L_E_T_ = ''
															
															Inner Join SBM010 SBM With(Nolock) -- Grupos Produtos 
															On BM_GRUPO = B1_GRUPO
															And SBM.D_E_L_E_T_ = ''


															Where (CC0.CC0_FILIAL = SF2.F2_FILIAL
																	Or	CC0.CC0_VEICUL = F2_VEICUL1)
															AND CC0.CC0_NUMMDF = SF2.F2_NUMMDF	
															AND CC0.CC0_SERMDF = SF2.F2_SERMDF	
															AND SF2.D_E_L_E_T_ = CC0.D_E_L_E_T_
															Group By B1_TIPO,X5_DESCRI,BM_GRUPO,BM_DESC
															For XML Path ('')),1,1,'')),'')),

	TIPOS_NF_ENTRADA_Normal_QTDE = (Isnull(((Select Count(F1_TIPO)
												From SF1010 SF1 With(Nolock)							
												Where (CC0.CC0_FILIAL = SF1.F1_FILIAL
														Or	CC0.CC0_VEICUL = F1_VEICUL1)
												AND CC0.CC0_NUMMDF = SF1.F1_NUMMDF	
												AND CC0.CC0_SERMDF = SF1.F1_SERMDF
												And F1_TIPO = 'N'
												AND SF1.D_E_L_E_T_ = CC0.D_E_L_E_T_
											)),0)),

	TIPOS_NF_ENTRADA_Devolucao_QTDE = (Isnull(((Select Count(F1_TIPO)
												From SF1010 SF1 With(Nolock)							
												Where (CC0.CC0_FILIAL = SF1.F1_FILIAL
														Or	CC0.CC0_VEICUL = F1_VEICUL1)
												AND CC0.CC0_NUMMDF = SF1.F1_NUMMDF	
												AND CC0.CC0_SERMDF = SF1.F1_SERMDF
												And F1_TIPO = 'D'
												AND SF1.D_E_L_E_T_ = CC0.D_E_L_E_T_
											)),0)),

	TIPOS_NF_ENTRADA_Beneficiamento_QTDE = (Isnull(((Select Count(F1_TIPO)
												From SF1010 SF1 With(Nolock)							
												Where (CC0.CC0_FILIAL = SF1.F1_FILIAL
														Or	CC0.CC0_VEICUL = F1_VEICUL1)
												AND CC0.CC0_NUMMDF = SF1.F1_NUMMDF	
												AND CC0.CC0_SERMDF = SF1.F1_SERMDF
												And F1_TIPO = 'B'
												AND SF1.D_E_L_E_T_ = CC0.D_E_L_E_T_
											)),0)),

	TIPOS_NF_Saida_Normal_QTDE = (Isnull(((Select Count(F2_TIPO)
												From SF2010 SF2 With(Nolock)							
												Where (CC0.CC0_FILIAL = SF2.F2_FILIAL
														Or	CC0.CC0_VEICUL = F2_VEICUL1)
												AND CC0.CC0_NUMMDF = SF2.F2_NUMMDF	
												AND CC0.CC0_SERMDF = SF2.F2_SERMDF
												And F2_TIPO = 'N'
												AND SF2.D_E_L_E_T_ = CC0.D_E_L_E_T_
											)),0)),

	TIPOS_NF_Saida_Devolucao_QTDE = (Isnull(((Select Count(F2_TIPO)
												From SF2010 SF2 With(Nolock)							
												Where (CC0.CC0_FILIAL = SF2.F2_FILIAL
														Or	CC0.CC0_VEICUL = F2_VEICUL1)
												AND CC0.CC0_NUMMDF = SF2.F2_NUMMDF	
												AND CC0.CC0_SERMDF = SF2.F2_SERMDF
												And F2_TIPO = 'D'
												AND SF2.D_E_L_E_T_ = CC0.D_E_L_E_T_
											)),0)),

	TIPOS_NF_Saida_Beneficiamento_QTDE = (Isnull(((Select Count(F2_TIPO)
													From SF2010 SF2 With(Nolock)							
													Where (CC0.CC0_FILIAL = SF2.F2_FILIAL
															Or	CC0.CC0_VEICUL = F2_VEICUL1)
													AND CC0.CC0_NUMMDF = SF2.F2_NUMMDF	
													AND CC0.CC0_SERMDF = SF2.F2_SERMDF
													And F2_TIPO = 'B'
													AND SF2.D_E_L_E_T_ = CC0.D_E_L_E_T_
											)),0)),


	TIPOS_NF_ENTRADA_TIPOS_PRODUTOS_PA = (Isnull((Select Count( B1_TIPO)											
															From SF1010 SF1 With(Nolock)
															
															Inner Join SD1010 SD1 With(Nolock) -- NF Entrada Cab
															On F1_FILIAL = D1_FILIAL
															And F1_DOC = D1_DOC
															And F1_SERIE = D1_SERIE
															And F1_FORNECE = D1_FORNECE
															And F1_LOJA = D1_LOJA
															And SD1.D_E_L_E_T_ = ''
															
															Inner Join SB1010 SB1 With(Nolock) -- Produtos
															On D1_COD = B1_COD
															And SD1.D_E_L_E_T_ = ''
																		
															
															Where (CC0.CC0_FILIAL = SF1.F1_FILIAL
																	Or	CC0.CC0_VEICUL = F1_VEICUL1)
															AND CC0.CC0_NUMMDF = SF1.F1_NUMMDF	
															AND CC0.CC0_SERMDF = SF1.F1_SERMDF
															And B1_TIPO = 'PA'
															AND SF1.D_E_L_E_T_ = CC0.D_E_L_E_T_
																	),'')),

	TIPOS_NF_ENTRADA_TIPOS_PRODUTOS_PI = (Isnull((Select Count( B1_TIPO)											
															From SF1010 SF1 With(Nolock)
															
															Inner Join SD1010 SD1 With(Nolock) -- NF Entrada Cab
															On F1_FILIAL = D1_FILIAL
															And F1_DOC = D1_DOC
															And F1_SERIE = D1_SERIE
															And F1_FORNECE = D1_FORNECE
															And F1_LOJA = D1_LOJA
															And SD1.D_E_L_E_T_ = ''
															
															Inner Join SB1010 SB1 With(Nolock) -- Produtos
															On D1_COD = B1_COD
															And SD1.D_E_L_E_T_ = ''
																		
															
															Where (CC0.CC0_FILIAL = SF1.F1_FILIAL
																	Or	CC0.CC0_VEICUL = F1_VEICUL1)
															AND CC0.CC0_NUMMDF = SF1.F1_NUMMDF	
															AND CC0.CC0_SERMDF = SF1.F1_SERMDF
															And B1_TIPO = 'PI'
															AND SF1.D_E_L_E_T_ = CC0.D_E_L_E_T_
																	),'')),

	TIPOS_NF_ENTRADA_TIPOS_PRODUTOS_MC = (Isnull((Select Count( B1_TIPO)											
															From SF1010 SF1 With(Nolock)
															
															Inner Join SD1010 SD1 With(Nolock) -- NF Entrada Cab
															On F1_FILIAL = D1_FILIAL
															And F1_DOC = D1_DOC
															And F1_SERIE = D1_SERIE
															And F1_FORNECE = D1_FORNECE
															And F1_LOJA = D1_LOJA
															And SD1.D_E_L_E_T_ = ''
															
															Inner Join SB1010 SB1 With(Nolock) -- Produtos
															On D1_COD = B1_COD
															And SD1.D_E_L_E_T_ = ''
																		
															
															Where (CC0.CC0_FILIAL = SF1.F1_FILIAL
																	Or	CC0.CC0_VEICUL = F1_VEICUL1)
															AND CC0.CC0_NUMMDF = SF1.F1_NUMMDF	
															AND CC0.CC0_SERMDF = SF1.F1_SERMDF
															And B1_TIPO = 'MC'
															AND SF1.D_E_L_E_T_ = CC0.D_E_L_E_T_
																	),'')),

	TIPOS_NF_ENTRADA_TIPOS_PRODUTOS_MP = (Isnull((Select Count( B1_TIPO)											
															From SF1010 SF1 With(Nolock)
															
															Inner Join SD1010 SD1 With(Nolock) -- NF Entrada Cab
															On F1_FILIAL = D1_FILIAL
															And F1_DOC = D1_DOC
															And F1_SERIE = D1_SERIE
															And F1_FORNECE = D1_FORNECE
															And F1_LOJA = D1_LOJA
															And SD1.D_E_L_E_T_ = ''
															
															Inner Join SB1010 SB1 With(Nolock) -- Produtos
															On D1_COD = B1_COD
															And SD1.D_E_L_E_T_ = ''
																		
															
															Where (CC0.CC0_FILIAL = SF1.F1_FILIAL
																	Or	CC0.CC0_VEICUL = F1_VEICUL1)
															AND CC0.CC0_NUMMDF = SF1.F1_NUMMDF	
															AND CC0.CC0_SERMDF = SF1.F1_SERMDF
															And B1_TIPO = 'MP'
															AND SF1.D_E_L_E_T_ = CC0.D_E_L_E_T_
																	),'')),

	TIPOS_NF_ENTRADA_TIPOS_PRODUTOS_Outros = (Isnull((Select Count( B1_TIPO)											
															From SF1010 SF1 With(Nolock)
															
															Inner Join SD1010 SD1 With(Nolock) -- NF Entrada Cab
															On F1_FILIAL = D1_FILIAL
															And F1_DOC = D1_DOC
															And F1_SERIE = D1_SERIE
															And F1_FORNECE = D1_FORNECE
															And F1_LOJA = D1_LOJA
															And SD1.D_E_L_E_T_ = ''
															
															Inner Join SB1010 SB1 With(Nolock) -- Produtos
															On D1_COD = B1_COD
															And SD1.D_E_L_E_T_ = ''
																		
															
															Where (CC0.CC0_FILIAL = SF1.F1_FILIAL
																	Or	CC0.CC0_VEICUL = F1_VEICUL1)
															AND CC0.CC0_NUMMDF = SF1.F1_NUMMDF	
															AND CC0.CC0_SERMDF = SF1.F1_SERMDF
															And B1_TIPO Not In ('MP','MC','PI','PA')
															AND SF1.D_E_L_E_T_ = CC0.D_E_L_E_T_
																	),'')),

	TIPOS_NF_ENTRADA_TIPOS_PRODUTOS_MAIOR = (Isnull((Stuff((Select Top 1
															'//'+
															Convert(varchar,Count(B1_TIPO))+
															'/'+
															B1_TIPO+
															'/'+
															X5_DESCRI+
															''
											
															From SF1010 SF1 With(Nolock)
															
															Inner Join SD1010 SD1 With(Nolock) -- NF Entrada Cab
															On F1_FILIAL = D1_FILIAL
															And F1_DOC = D1_DOC
															And F1_SERIE = D1_SERIE
															And F1_FORNECE = D1_FORNECE
															And F1_LOJA = D1_LOJA
															And SD1.D_E_L_E_T_ = ''
															
															Inner Join SB1010 SB1 With(Nolock) -- Produtos
															On D1_COD = B1_COD
															And SD1.D_E_L_E_T_ = ''
															
															Inner Join SX5010 SX5 With(Nolock) -- Genericas Tipos Produtos 
															On X5_TABELA = '02' 
															And X5_CHAVE = B1_TIPO
															And SX5.D_E_L_E_T_ = ''
																													
															Where (CC0.CC0_FILIAL = SF1.F1_FILIAL
																	Or	CC0.CC0_VEICUL = F1_VEICUL1)
															AND CC0.CC0_NUMMDF = SF1.F1_NUMMDF	
															AND CC0.CC0_SERMDF = SF1.F1_SERMDF
															AND SF1.D_E_L_E_T_ = CC0.D_E_L_E_T_
															Group By B1_TIPO,X5_DESCRI
															ORDER BY Count(B1_TIPO) DESC
															For XML Path ('')),1,1,'')),'')),


		TIPOS_NF_SAIDA_TIPOS_PRODUTOS_PA = (Isnull((Select Count( B1_TIPO)											
															From SF2010 SF2 With(Nolock)
															
															Inner Join SD2010 SD2 With(Nolock) -- NF Entrada Cab
															On F2_FILIAL = D2_FILIAL
															And F2_DOC = D2_DOC
															And F2_SERIE = D2_SERIE
															And F2_CLIENTE = D2_CLIENTE
															And F2_LOJA = D2_LOJA
															And SD2.D_E_L_E_T_ = ''
															
															Inner Join SB1010 SB1 With(Nolock) -- Produtos
															On D2_COD = B1_COD
															And SD2.D_E_L_E_T_ = ''
																		
															
															Where (CC0.CC0_FILIAL = SF2.F2_FILIAL
																	Or	CC0.CC0_VEICUL = F2_VEICUL1)
															AND CC0.CC0_NUMMDF = SF2.F2_NUMMDF	
															AND CC0.CC0_SERMDF = SF2.F2_SERMDF
															And B1_TIPO = 'PA'
															AND SF2.D_E_L_E_T_ = CC0.D_E_L_E_T_
																	),'')),

	TIPOS_NF_SAIDA_TIPOS_PRODUTOS_PI = (Isnull((Select Count( B1_TIPO)											
															From SF2010 SF2 With(Nolock)
															
															Inner Join SD2010 SD2 With(Nolock) -- NF Entrada Cab
															On F2_FILIAL = D2_FILIAL
															And F2_DOC = D2_DOC
															And F2_SERIE = D2_SERIE
															And F2_CLIENTE = D2_CLIENTE
															And F2_LOJA = D2_LOJA
															And SD2.D_E_L_E_T_ = ''
															
															Inner Join SB1010 SB1 With(Nolock) -- Produtos
															On D2_COD = B1_COD
															And SD2.D_E_L_E_T_ = ''
																		
															
															Where (CC0.CC0_FILIAL = SF2.F2_FILIAL
																	Or	CC0.CC0_VEICUL = F2_VEICUL1)
															AND CC0.CC0_NUMMDF = SF2.F2_NUMMDF	
															AND CC0.CC0_SERMDF = SF2.F2_SERMDF
															And B1_TIPO = 'PI'
															AND SF2.D_E_L_E_T_ = CC0.D_E_L_E_T_
																	),'')),

	TIPOS_NF_SAIDA_TIPOS_PRODUTOS_MC = (Isnull((Select Count( B1_TIPO)											
															From SF2010 SF2 With(Nolock)
															
															Inner Join SD2010 SD2 With(Nolock) -- NF Entrada Cab
															On F2_FILIAL = D2_FILIAL
															And F2_DOC = D2_DOC
															And F2_SERIE = D2_SERIE
															And F2_CLIENTE = D2_CLIENTE
															And F2_LOJA = D2_LOJA
															And SD2.D_E_L_E_T_ = ''
															
															Inner Join SB1010 SB1 With(Nolock) -- Produtos
															On D2_COD = B1_COD
															And SD2.D_E_L_E_T_ = ''
																		
															
															Where (CC0.CC0_FILIAL = SF2.F2_FILIAL
																	Or	CC0.CC0_VEICUL = F2_VEICUL1)
															AND CC0.CC0_NUMMDF = SF2.F2_NUMMDF	
															AND CC0.CC0_SERMDF = SF2.F2_SERMDF
															And B1_TIPO = 'MC'
															AND SF2.D_E_L_E_T_ = CC0.D_E_L_E_T_
																	),'')),

	TIPOS_NF_SAIDA_TIPOS_PRODUTOS_MP = (Isnull((Select Count( B1_TIPO)											
															From SF2010 SF2 With(Nolock)
															
															Inner Join SD2010 SD2 With(Nolock) -- NF Entrada Cab
															On F2_FILIAL = D2_FILIAL
															And F2_DOC = D2_DOC
															And F2_SERIE = D2_SERIE
															And F2_CLIENTE = D2_CLIENTE
															And F2_LOJA = D2_LOJA
															And SD2.D_E_L_E_T_ = ''
															
															Inner Join SB1010 SB1 With(Nolock) -- Produtos
															On D2_COD = B1_COD
															And SD2.D_E_L_E_T_ = ''
																		
															
															Where (CC0.CC0_FILIAL = SF2.F2_FILIAL
																	Or	CC0.CC0_VEICUL = F2_VEICUL1)
															AND CC0.CC0_NUMMDF = SF2.F2_NUMMDF	
															AND CC0.CC0_SERMDF = SF2.F2_SERMDF
															And B1_TIPO = 'MP'
															AND SF2.D_E_L_E_T_ = CC0.D_E_L_E_T_
																	),'')),
																	
	TIPOS_NF_SAIDA_TIPOS_PRODUTOS_Outros = (Isnull((Select Count( B1_TIPO)											
															From SF2010 SF2 With(Nolock)
															
															Inner Join SD2010 SD2 With(Nolock) -- NF Entrada Cab
															On F2_FILIAL = D2_FILIAL
															And F2_DOC = D2_DOC
															And F2_SERIE = D2_SERIE
															And F2_CLIENTE = D2_CLIENTE
															And F2_LOJA = D2_LOJA
															And SD2.D_E_L_E_T_ = ''
															
															Inner Join SB1010 SB1 With(Nolock) -- Produtos
															On D2_COD = B1_COD
															And SD2.D_E_L_E_T_ = ''
																		
															
															Where (CC0.CC0_FILIAL = SF2.F2_FILIAL
																	Or	CC0.CC0_VEICUL = F2_VEICUL1)
															AND CC0.CC0_NUMMDF = SF2.F2_NUMMDF	
															AND CC0.CC0_SERMDF = SF2.F2_SERMDF
															And B1_TIPO Not In ('MP','MC','PI','PA')
															AND SF2.D_E_L_E_T_ = CC0.D_E_L_E_T_
																	),'')),

	TIPOS_NF_SAIDA_TIPOS_PRODUTOS_MAIOR = (Isnull((Stuff((Select Top 1
															'//'+
															Convert(varchar,Count(B1_TIPO))+
															'/'+
															B1_TIPO+
															'/'+
															X5_DESCRI+
															''											
															From SF2010 SF2 With(Nolock)
															
															Inner Join SD2010 SD2 With(Nolock) -- NF Entrada Cab
															On F2_FILIAL = D2_FILIAL
															And F2_DOC = D2_DOC
															And F2_SERIE = D2_SERIE
															And F2_CLIENTE = D2_CLIENTE
															And F2_LOJA = D2_LOJA
															And SD2.D_E_L_E_T_ = ''
															
															Inner Join SB1010 SB1 With(Nolock) -- Produtos
															On D2_COD = B1_COD
															And SD2.D_E_L_E_T_ = ''
															
															Inner Join SX5010 SX5 With(Nolock) -- Genericas Tipos Produtos 
															On X5_TABELA = '02' 
															And X5_CHAVE = B1_TIPO
															And SX5.D_E_L_E_T_ = ''
																													
															Where (CC0.CC0_FILIAL = SF2.F2_FILIAL
																	Or	CC0.CC0_VEICUL = F2_VEICUL1)
															AND CC0.CC0_NUMMDF = SF2.F2_NUMMDF	
															AND CC0.CC0_SERMDF = SF2.F2_SERMDF
															AND SF2.D_E_L_E_T_ = CC0.D_E_L_E_T_
															Group By B1_TIPO,X5_DESCRI
															ORDER BY Count(B1_TIPO) DESC
															For XML Path ('')),1,1,'')),'')),

	Case
		When 
			(Isnull((Select Top 1
					Count(B1_TIPO)
											
					From SF2010 SF2 With(Nolock)
					
					Inner Join SD2010 SD2 With(Nolock) -- NF Entrada Cab
					On F2_FILIAL = D2_FILIAL
					And F2_DOC = D2_DOC
					And F2_SERIE = D2_SERIE
					And F2_CLIENTE = D2_CLIENTE
					And F2_LOJA = D2_LOJA
					And SD2.D_E_L_E_T_ = ''
					
					Inner Join SB1010 SB1 With(Nolock) -- Produtos
					On D2_COD = B1_COD
					And SD2.D_E_L_E_T_ = ''
					
					Inner Join SX5010 SX5 With(Nolock) -- Genericas Tipos Produtos 
					On X5_TABELA = '02' 
					And X5_CHAVE = B1_TIPO
					And SX5.D_E_L_E_T_ = ''
																			
					Where (CC0.CC0_FILIAL = SF2.F2_FILIAL
							Or	CC0.CC0_VEICUL = F2_VEICUL1)
					AND CC0.CC0_NUMMDF = SF2.F2_NUMMDF	
					AND CC0.CC0_SERMDF = SF2.F2_SERMDF
					AND SF2.D_E_L_E_T_ = CC0.D_E_L_E_T_
					Group By B1_TIPO,X5_DESCRI
					ORDER BY Count(B1_TIPO) DESC),0)) >= 

			(Isnull((Select Top 1
					Count(B1_TIPO)
																
					From SF1010 SF1 With(Nolock)
					
					Inner Join SD1010 SD1 With(Nolock) -- NF Entrada Cab
					On F1_FILIAL = D1_FILIAL
					And F1_DOC = D1_DOC
					And F1_SERIE = D1_SERIE
					And F1_FORNECE = D1_FORNECE
					And F1_LOJA = D1_LOJA
					And SD1.D_E_L_E_T_ = ''
					
					Inner Join SB1010 SB1 With(Nolock) -- Produtos
					On D1_COD = B1_COD
					And SD1.D_E_L_E_T_ = ''
					
					Inner Join SX5010 SX5 With(Nolock) -- Genericas Tipos Produtos 
					On X5_TABELA = '02' 
					And X5_CHAVE = B1_TIPO
					And SX5.D_E_L_E_T_ = ''
																			
					Where (CC0.CC0_FILIAL = SF1.F1_FILIAL
							Or	CC0.CC0_VEICUL = F1_VEICUL1)
					AND CC0.CC0_NUMMDF = SF1.F1_NUMMDF	
					AND CC0.CC0_SERMDF = SF1.F1_SERMDF
					AND SF1.D_E_L_E_T_ = CC0.D_E_L_E_T_
					Group By B1_TIPO,X5_DESCRI
					ORDER BY Count(B1_TIPO) DESC),0))

		Then 'NF SAIDA MAIOR'
		Else 'NF ENTRADA MAIOR'
		End as Valid_NF_MAIOR,

	Case
		When 
			(Isnull((Select Top 1
					Count(B1_TIPO)
											
					From SF2010 SF2 With(Nolock)
					
					Inner Join SD2010 SD2 With(Nolock) -- NF Entrada Cab
					On F2_FILIAL = D2_FILIAL
					And F2_DOC = D2_DOC
					And F2_SERIE = D2_SERIE
					And F2_CLIENTE = D2_CLIENTE
					And F2_LOJA = D2_LOJA
					And SD2.D_E_L_E_T_ = ''
					
					Inner Join SB1010 SB1 With(Nolock) -- Produtos
					On D2_COD = B1_COD
					And SD2.D_E_L_E_T_ = ''
					
					Inner Join SX5010 SX5 With(Nolock) -- Genericas Tipos Produtos 
					On X5_TABELA = '02' 
					And X5_CHAVE = B1_TIPO
					And SX5.D_E_L_E_T_ = ''
																			
					Where (CC0.CC0_FILIAL = SF2.F2_FILIAL
							Or	CC0.CC0_VEICUL = F2_VEICUL1)
					AND CC0.CC0_NUMMDF = SF2.F2_NUMMDF	
					AND CC0.CC0_SERMDF = SF2.F2_SERMDF
					AND SF2.D_E_L_E_T_ = CC0.D_E_L_E_T_
					Group By B1_TIPO,X5_DESCRI
					ORDER BY Count(B1_TIPO) DESC),0)) >= 

			(Isnull((Select Top 1
					Count(B1_TIPO)
																
					From SF1010 SF1 With(Nolock)
					
					Inner Join SD1010 SD1 With(Nolock) -- NF Entrada Cab
					On F1_FILIAL = D1_FILIAL
					And F1_DOC = D1_DOC
					And F1_SERIE = D1_SERIE
					And F1_FORNECE = D1_FORNECE
					And F1_LOJA = D1_LOJA
					And SD1.D_E_L_E_T_ = ''
					
					Inner Join SB1010 SB1 With(Nolock) -- Produtos
					On D1_COD = B1_COD
					And SD1.D_E_L_E_T_ = ''
					
					Inner Join SX5010 SX5 With(Nolock) -- Genericas Tipos Produtos 
					On X5_TABELA = '02' 
					And X5_CHAVE = B1_TIPO
					And SX5.D_E_L_E_T_ = ''
																			
					Where (CC0.CC0_FILIAL = SF1.F1_FILIAL
							Or	CC0.CC0_VEICUL = F1_VEICUL1)
					AND CC0.CC0_NUMMDF = SF1.F1_NUMMDF	
					AND CC0.CC0_SERMDF = SF1.F1_SERMDF
					AND SF1.D_E_L_E_T_ = CC0.D_E_L_E_T_
					Group By B1_TIPO,X5_DESCRI
					ORDER BY Count(B1_TIPO) DESC),0))

		Then 
			(Isnull((Stuff((Select Top 1
								'//'+
								Convert(varchar,Count(B1_TIPO))+
								'/'+
								B1_TIPO+
								'/'+
								X5_DESCRI+
								''											
								From SF2010 SF2 With(Nolock)
								
								Inner Join SD2010 SD2 With(Nolock) -- NF Entrada Cab
								On F2_FILIAL = D2_FILIAL
								And F2_DOC = D2_DOC
								And F2_SERIE = D2_SERIE
								And F2_CLIENTE = D2_CLIENTE
								And F2_LOJA = D2_LOJA
								And SD2.D_E_L_E_T_ = ''
								
								Inner Join SB1010 SB1 With(Nolock) -- Produtos
								On D2_COD = B1_COD
								And SD2.D_E_L_E_T_ = ''
								
								Inner Join SX5010 SX5 With(Nolock) -- Genericas Tipos Produtos 
								On X5_TABELA = '02' 
								And X5_CHAVE = B1_TIPO
								And SX5.D_E_L_E_T_ = ''
																						
								Where (CC0.CC0_FILIAL = SF2.F2_FILIAL
										Or	CC0.CC0_VEICUL = F2_VEICUL1)
								AND CC0.CC0_NUMMDF = SF2.F2_NUMMDF	
								AND CC0.CC0_SERMDF = SF2.F2_SERMDF
								AND SF2.D_E_L_E_T_ = CC0.D_E_L_E_T_
								Group By B1_TIPO,X5_DESCRI
								ORDER BY Count(B1_TIPO) DESC
								For XML Path ('')),1,1,'')),''))



		Else 
			(Isnull((Stuff((Select Top 1
							'//'+
							Convert(varchar,Count(B1_TIPO))+
							'/'+
							B1_TIPO+
							'/'+
							X5_DESCRI+
							''
							
							From SF1010 SF1 With(Nolock)
							
							Inner Join SD1010 SD1 With(Nolock) -- NF Entrada Cab
							On F1_FILIAL = D1_FILIAL
							And F1_DOC = D1_DOC
							And F1_SERIE = D1_SERIE
							And F1_FORNECE = D1_FORNECE
							And F1_LOJA = D1_LOJA
							And SD1.D_E_L_E_T_ = ''
							
							Inner Join SB1010 SB1 With(Nolock) -- Produtos
							On D1_COD = B1_COD
							And SD1.D_E_L_E_T_ = ''
							
							Inner Join SX5010 SX5 With(Nolock) -- Genericas Tipos Produtos 
							On X5_TABELA = '02' 
							And X5_CHAVE = B1_TIPO
							And SX5.D_E_L_E_T_ = ''
																					
							Where (CC0.CC0_FILIAL = SF1.F1_FILIAL
									Or	CC0.CC0_VEICUL = F1_VEICUL1)
							AND CC0.CC0_NUMMDF = SF1.F1_NUMMDF	
							AND CC0.CC0_SERMDF = SF1.F1_SERMDF
							AND SF1.D_E_L_E_T_ = CC0.D_E_L_E_T_
							Group By B1_TIPO,X5_DESCRI
							ORDER BY Count(B1_TIPO) DESC
							For XML Path ('')),1,1,'')),''))

		End as Valid_Produto,

		Case 
			When 
				CC0.CC0_UFINI = 'SP' And CC0.CC0_UFFIM = 'MG' And CC0.CC0_STATUS = '6'
			Then 850.00

			When 
				CC0.CC0_UFINI = 'SP' And CC0.CC0_UFFIM = 'MS' And CC0.CC0_STATUS = '6'
			Then 2699.35

			When 
				CC0.CC0_UFINI = 'MG' And CC0.CC0_UFFIM = 'SP' And CC0.CC0_STATUS = '6'
			Then 850.00

			When 
				CC0.CC0_UFINI = 'MG' And CC0.CC0_UFFIM = 'MS'And CC0.CC0_STATUS = '6'
			Then 1736.36

			When 
				CC0.CC0_UFINI = 'MS' And CC0.CC0_UFFIM = 'MG' And CC0.CC0_STATUS = '6'
			Then 1736.36

			When 
				CC0.CC0_UFINI = 'MS' And CC0.CC0_UFFIM = 'SP' And CC0.CC0_STATUS = '6'
			Then 2715.83
			Else 0
			End as VALOR_FRETE,


		Case 
			When 
				CC0.CC0_UFINI = 'SP' And CC0.CC0_UFFIM = 'MG' And CC0.CC0_STATUS = '6'
			Then 2000.00

			When 
				CC0.CC0_UFINI = 'SP' And CC0.CC0_UFFIM = 'MS' And CC0.CC0_STATUS = '6'
			Then 6000.00

			When 
				CC0.CC0_UFINI = 'MG' And CC0.CC0_UFFIM = 'SP' And CC0.CC0_STATUS = '6'
			Then 2000.01

			When 
				CC0.CC0_UFINI = 'MG' And CC0.CC0_UFFIM = 'MS'And CC0.CC0_STATUS = '6'
			Then 6500.01

			When 
				CC0.CC0_UFINI = 'MS' And CC0.CC0_UFFIM = 'MG' And CC0.CC0_STATUS = '6'
			Then 8000.00

			When 
				CC0.CC0_UFINI = 'MS' And CC0.CC0_UFFIM = 'SP' And CC0.CC0_STATUS = '6'
			Then 6500.00
			Else 0
			End as VALOR_FRETE_TERCEIROS


    FROM CC0010 CC0 --MANIFESTOS DE CARGA
    
	INNER JOIN DA4010 DA4 -- MOTORISTAS 
	ON CC0.CC0_MOTORI = DA4.DA4_COD 
	AND DA4.D_E_L_E_T_ = ''

	INNER JOIN DA3010 DA3 --Veiculos
	ON CC0.CC0_VEICUL = DA3.DA3_COD
	AND DA3.D_E_L_E_T_ = ''

    WHERE CC0.D_E_L_E_T_ = ''


),
ParsedSegData AS (
    SELECT
        XMLContent,
        CASE 
            WHEN CHARINDEX('<seg>', XMLContent) > 0 
            THEN SUBSTRING(XMLContent, CHARINDEX('<seg>', XMLContent), CHARINDEX('</seg>', XMLContent) - CHARINDEX('<seg>', XMLContent) + LEN('</seg>'))
            ELSE ''
        END AS SegContent,
        CASE 
            WHEN CHARINDEX('<xSeg>', XMLContent) > 0 
            THEN SUBSTRING(XMLContent, CHARINDEX('<xSeg>', XMLContent), CHARINDEX('</xSeg>', XMLContent) - CHARINDEX('<xSeg>', XMLContent) + LEN('</xSeg>'))
            ELSE ''
        END AS xSegContent,
        CC0_FILIAL,
        CC0_SERMDF,
        CC0_NUMMDF,
        CC0_CHVMDF,
        CC0_STATUS,
        CC0_STATEV,
        CC0_CODRET,
        CC0_MSGRET,
        CC0_PROTOC,
        CC0_DTEMIS,
        CC0_HREMIS,
        CC0_UFINI,
        CC0_UFFIM,
        CC0_XMLMDF,
        CC0_QTDNFE,
        CC0_VTOTAL,
        CC0_PESOB,
        CC0_VEICUL,
        CC0_TPEVEN,
        CC0_TPNF,
        CC0_CARGA,
        CC0_VINCUL,
        CC0_CARPST,
        CC0_MOTORI,
        CC0_MODAL,
        D_E_L_E_T_,
        DA4_COD,
        DA4_NOME,
        DA4_CGC,
        DA4_MAT,
        DA4_NUMCNH,
        CC0_STATUS_DESC,
        CC0_STATEV_DESC,
        CC0_TPNF_DESC,
		DA3_COD,
		DA3_DESC,
		DA3_PLACA,
		DA3_RENAVA,
		TIPOS_NF_ENTRADA,
		TIPOS_NF_SAIDA,
		TIPOS_NF_ENTRADA_IND,
		TIPOS_NF_SAIDA_IND,
		TIPOS_NF_ENTRADA_QTDE_TIPO,
		TIPOS_NF_SAIDA_QTDE_TIPO,
		NF_ENTRADA_QTDE,
		NF_SAIDA_QTDE,
		NF_TOTAL_QTDE,
		TIPOS_NF_ENTRADA_PRODUTOS,
		TIPOS_NF_ENTRADA_TIPOS_PRODUTOS,
		TIPOS_NF_SAIDA_PRODUTOS,
		TIPOS_NF_SAIDA_TIPOS_PRODUTOS,
		TIPOS_NF_ENTRADA_Normal_QTDE,
		TIPOS_NF_ENTRADA_Devolucao_QTDE,
		TIPOS_NF_ENTRADA_Beneficiamento_QTDE,
		TIPOS_NF_Saida_Normal_QTDE,
		TIPOS_NF_Saida_Devolucao_QTDE,
		TIPOS_NF_Saida_Beneficiamento_QTDE,
		TIPOS_NF_ENTRADA_TIPOS_PRODUTOS_PA,
		TIPOS_NF_ENTRADA_TIPOS_PRODUTOS_PI,
		TIPOS_NF_ENTRADA_TIPOS_PRODUTOS_MC,
		TIPOS_NF_ENTRADA_TIPOS_PRODUTOS_MP,
		TIPOS_NF_ENTRADA_TIPOS_PRODUTOS_Outros,
		TIPOS_NF_ENTRADA_TIPOS_PRODUTOS_MAIOR,
		TIPOS_NF_SAIDA_TIPOS_PRODUTOS_PA,
		TIPOS_NF_SAIDA_TIPOS_PRODUTOS_PI,
		TIPOS_NF_SAIDA_TIPOS_PRODUTOS_MC,
		TIPOS_NF_SAIDA_TIPOS_PRODUTOS_MP,
		TIPOS_NF_SAIDA_TIPOS_PRODUTOS_Outros,
		TIPOS_NF_SAIDA_TIPOS_PRODUTOS_MAIOR,
		Valid_NF_MAIOR,
		Valid_Produto,
		VALOR_FRETE,
		VALOR_FRETE_TERCEIROS,

        CASE 
            WHEN CHARINDEX('<tot>', XMLContent) > 0 AND CHARINDEX('<vCarga>', XMLContent, CHARINDEX('<tot>', XMLContent)) > 0
            THEN 
                SUBSTRING(
                    XMLContent, 
                    CHARINDEX('<vCarga>', XMLContent, CHARINDEX('<tot>', XMLContent)) + LEN('<vCarga>'), 
                    CHARINDEX('</vCarga>', XMLContent, CHARINDEX('<vCarga>', XMLContent, CHARINDEX('<tot>', XMLContent))) - CHARINDEX('<vCarga>', XMLContent, CHARINDEX('<tot>', XMLContent)) - LEN('<vCarga>')
                )
            ELSE 'N/A'
        END AS vCarga,
        CASE 
            WHEN CHARINDEX('<tot>', XMLContent) > 0 AND CHARINDEX('<qCTe>', XMLContent, CHARINDEX('<tot>', XMLContent)) > 0
            THEN 
                SUBSTRING(
                    XMLContent, 
                    CHARINDEX('<qCTe>', XMLContent, CHARINDEX('<tot>', XMLContent)) + LEN('<qCTe>'), 
                    CHARINDEX('</qCTe>', XMLContent, CHARINDEX('<qCTe>', XMLContent, CHARINDEX('<tot>', XMLContent))) - CHARINDEX('<qCTe>', XMLContent, CHARINDEX('<tot>', XMLContent)) - LEN('<qCTe>')
                )
            ELSE 'N/A'
        END AS qCTe,
        CASE 
            WHEN CHARINDEX('<tot>', XMLContent) > 0 AND CHARINDEX('<qMDFe>', XMLContent, CHARINDEX('<tot>', XMLContent)) > 0
            THEN 
                SUBSTRING(
                    XMLContent, 
                    CHARINDEX('<qMDFe>', XMLContent, CHARINDEX('<tot>', XMLContent)) + LEN('<qMDFe>'), 
                    CHARINDEX('</qMDFe>', XMLContent, CHARINDEX('<qMDFe>', XMLContent, CHARINDEX('<tot>', XMLContent))) - CHARINDEX('<qMDFe>', XMLContent, CHARINDEX('<tot>', XMLContent)) - LEN('<qMDFe>')
                )
            ELSE 'N/A'
        END AS qMDFe,
        CASE 
            WHEN CHARINDEX('<tot>', XMLContent) > 0 AND CHARINDEX('<qCarga>', XMLContent, CHARINDEX('<tot>', XMLContent)) > 0
            THEN 
                SUBSTRING(
                    XMLContent, 
                    CHARINDEX('<qCarga>', XMLContent, CHARINDEX('<tot>', XMLContent)) + LEN('<qCarga>'), 
                    CHARINDEX('</qCarga>', XMLContent, CHARINDEX('<qCarga>', XMLContent, CHARINDEX('<tot>', XMLContent))) - CHARINDEX('<qCarga>', XMLContent, CHARINDEX('<tot>', XMLContent)) - LEN('<qCarga>')
                )
            ELSE 'N/A'
        END AS qCarga
    FROM XMLData
),
ExtractedCNPJData AS (
    SELECT
        CASE 
            WHEN CHARINDEX('<respSeg>', SegContent) > 0 AND CHARINDEX('<CNPJ>', SegContent, CHARINDEX('<respSeg>', SegContent)) > 0
            THEN 
                SUBSTRING(
                    SegContent, 
                    CHARINDEX('<CNPJ>', SegContent, CHARINDEX('<respSeg>', SegContent)) + LEN('<CNPJ>'), 
                    CHARINDEX('</CNPJ>', SegContent, CHARINDEX('<CNPJ>', SegContent, CHARINDEX('<respSeg>', SegContent))) - CHARINDEX('<CNPJ>', SegContent, CHARINDEX('<respSeg>', SegContent)) - LEN('<CNPJ>')
                )
            ELSE 'N/A'
        END AS resp_CNPJ,
        CASE 
            WHEN CHARINDEX('<infSeg>', SegContent) > 0 AND CHARINDEX('<CNPJ>', SegContent, CHARINDEX('<infSeg>', SegContent)) > 0
            THEN 
                SUBSTRING(
                    SegContent, 
                    CHARINDEX('<CNPJ>', SegContent, CHARINDEX('<infSeg>', SegContent)) + LEN('<CNPJ>'), 
                    CHARINDEX('</CNPJ>', SegContent, CHARINDEX('<CNPJ>', SegContent, CHARINDEX('<infSeg>', SegContent))) - CHARINDEX('<CNPJ>', SegContent, CHARINDEX('<infSeg>', SegContent)) - LEN('<CNPJ>')
                )
            ELSE 'N/A'
        END AS Seg_CNPJ,
        CASE 
            WHEN CHARINDEX('<nApol>', SegContent) > 0 
            THEN 
                SUBSTRING(
                    SegContent, 
                    CHARINDEX('<nApol>', SegContent) + LEN('<nApol>'), 
                    CHARINDEX('</nApol>', SegContent) - CHARINDEX('<nApol>', SegContent) - LEN('<nApol>')
                )
            ELSE 'N/A'
        END AS nApol,
        CASE 
            WHEN CHARINDEX('<nAver>', SegContent) > 0 
            THEN 
                SUBSTRING(
                    SegContent, 
                    CHARINDEX('<nAver>', SegContent) + LEN('<nAver>'), 
                    CHARINDEX('</nAver>', SegContent) - CHARINDEX('<nAver>', SegContent) - LEN('<nAver>')
                )
            ELSE 'N/A'
        END AS nAver,
		CASE 
            WHEN CHARINDEX('<infSeg>', SegContent) > 0 AND CHARINDEX('<xSeg>', SegContent, CHARINDEX('<infSeg>', SegContent)) > 0
            THEN 
                SUBSTRING(
                    SegContent, 
                    CHARINDEX('<xSeg>', SegContent, CHARINDEX('<respSeg>', SegContent)) + LEN('<xSeg>'), 
                    CHARINDEX('</xSeg>', SegContent, CHARINDEX('<xSeg>', SegContent, CHARINDEX('<respSeg>', SegContent))) - CHARINDEX('<xSeg>', SegContent, CHARINDEX('<respSeg>', SegContent)) - LEN('<xSeg>')
                )
            ELSE 'N/A'
        END AS Seg_Nome,
        
        CC0_FILIAL,
        CC0_SERMDF,
        CC0_NUMMDF,
        CC0_CHVMDF,
        CC0_STATUS,
        CC0_STATEV,
        CC0_CODRET,
        CC0_MSGRET,
        CC0_PROTOC,
        CC0_DTEMIS,
        CC0_HREMIS,
        CC0_UFINI,
        CC0_UFFIM,
        CC0_XMLMDF,
        CC0_QTDNFE,
        CC0_VTOTAL,
        CC0_PESOB,
        CC0_VEICUL,
        CC0_TPEVEN,
        CC0_TPNF,
        CC0_CARGA,
        CC0_VINCUL,
        CC0_CARPST,
        CC0_MOTORI,
        CC0_MODAL,
        D_E_L_E_T_,
        DA4_COD,
        DA4_NOME,
        DA4_CGC,
        DA4_MAT,
        DA4_NUMCNH,
        CC0_STATUS_DESC,
        CC0_STATEV_DESC,
        CC0_TPNF_DESC,
		DA3_COD,
		DA3_DESC,
		DA3_PLACA,
		DA3_RENAVA,
		TIPOS_NF_ENTRADA,
		TIPOS_NF_SAIDA,
		TIPOS_NF_ENTRADA_IND,
		TIPOS_NF_SAIDA_IND,
		TIPOS_NF_ENTRADA_QTDE_TIPO,
		TIPOS_NF_SAIDA_QTDE_TIPO,
		NF_ENTRADA_QTDE,
		NF_SAIDA_QTDE,
		NF_TOTAL_QTDE,
		TIPOS_NF_ENTRADA_PRODUTOS,
		TIPOS_NF_ENTRADA_TIPOS_PRODUTOS,
		TIPOS_NF_SAIDA_PRODUTOS,
		TIPOS_NF_SAIDA_TIPOS_PRODUTOS,
        vCarga,
        qCTe,
        qMDFe,
        qCarga,
		TIPOS_NF_ENTRADA_Normal_QTDE,
		TIPOS_NF_ENTRADA_Devolucao_QTDE,
		TIPOS_NF_ENTRADA_Beneficiamento_QTDE,
		TIPOS_NF_Saida_Normal_QTDE,
		TIPOS_NF_Saida_Devolucao_QTDE,
		TIPOS_NF_Saida_Beneficiamento_QTDE,
		TIPOS_NF_ENTRADA_TIPOS_PRODUTOS_PA,
		TIPOS_NF_ENTRADA_TIPOS_PRODUTOS_PI,
		TIPOS_NF_ENTRADA_TIPOS_PRODUTOS_MC,
		TIPOS_NF_ENTRADA_TIPOS_PRODUTOS_MP,
		TIPOS_NF_ENTRADA_TIPOS_PRODUTOS_Outros,
		TIPOS_NF_ENTRADA_TIPOS_PRODUTOS_MAIOR,
		TIPOS_NF_SAIDA_TIPOS_PRODUTOS_PA,
		TIPOS_NF_SAIDA_TIPOS_PRODUTOS_PI,
		TIPOS_NF_SAIDA_TIPOS_PRODUTOS_MC,
		TIPOS_NF_SAIDA_TIPOS_PRODUTOS_MP,
		TIPOS_NF_SAIDA_TIPOS_PRODUTOS_Outros,
		TIPOS_NF_SAIDA_TIPOS_PRODUTOS_MAIOR,
		Valid_NF_MAIOR,
		Valid_Produto,
		VALOR_FRETE,
		VALOR_FRETE_TERCEIROS

    FROM ParsedSegData
)
SELECT
    (IsNull(resp_CNPJ,''))								As CNPJ_Seguro_Responsavel, 
    (Isnull(Seg_CNPJ,''))								As CNPJ_Seguradora,
    (Isnull(nApol,''))									As Apolice_Numero, 
    (Isnull(nAver,''))									As Averbacao_Numero, 
    (Isnull(Seg_Nome,''))								As Seguradora_Nome,
	(Isnull(vCarga,0))  								As Carga_Valor,
    (Isnull(qCTe,0))									As Qtde_CTE,
    (Isnull(qMDFe,0))									As Qtde_MDFE,
    (Isnull(qCarga,0))									As Carga_Qtde,
    (Isnull(CC0_FILIAL,''))								As Filial,
    (Isnull(CC0_SERMDF,''))								As MDFE_Serie,
    (Isnull(CC0_NUMMDF,''))								As MDFE_Numero,
    (Isnull(CC0_CHVMDF,''))								As MDFE_Chave,
    (Isnull(CC0_STATUS,''))								As MDFE_Status,
    (Isnull(CC0_STATEV,''))								As MDFE_Status_Evento,
    (Isnull(CC0_CODRET,''))								AS Codigo_Retorno_SEFAZ,
    (Isnull(CC0_MSGRET,''))								As Mensagem_Retorno_SEFAZ,
    (Isnull(CC0_PROTOC,''))								AS MDFEProtocoloNumero,
    (ISNULL(Cast(CC0_DTEMIS as date), ''))				As DataEmissoaoMDFE,
    (ISNULL(Cast(CC0_HREMIS as time), ''))				As HoraEmissaoMDFE ,
    (ISNULL(CC0_UFINI,''))								As UFOrigem,
    (ISNULL(CC0_UFFIM,''))								As UFDestino,
    (ISNULL(CC0_XMLMDF,''))								As XMLMFDE,
    (ISNULL(CC0_QTDNFE,0))								As QtdeNFEMDFE,
    (ISNULL(CC0_VTOTAL,0))								As CargaValorTotal,
    (ISNULL(CC0_PESOB,0))								As CargaPesoBruto,
    (ISNULL(CC0_VEICUL,''))								As VeiculoCodigo,
    (ISNULL(CC0_TPEVEN,''))								As CodigoTipoVeiculo,
    (ISNULL(CC0_TPNF,''))								As TipoNFE,
    (ISNULL(CC0_CARGA,''))								As NumeroCarga,
    (ISNULL(CC0_VINCUL,''))								As TipoVinculoMDFE,
    (ISNULL(CC0_CARPST,''))								As CargaPosterior,
    (ISNULL(CC0_MOTORI,''))								As MotoristaCodigo,
    (ISNULL(CC0_MODAL,''))								As TipoModalMDFE,
    (ISNULL(DA4_NOME,''))								As MotoristaNome,
    (ISNULL(DA4_CGC,''))								As MotoristaCPF,
    (ISNULL(DA4_MAT,''))								As MotoristaMtricula,
    (ISNULL(DA4_NUMCNH,''))								As MotoristaCNH,
	
	(ISNULL(DA3_DESC,''))								As VeiculoDescricao,
	(ISNULL(DA3_PLACA,''))								As VeiculoPlaca,
	(ISNULL(DA3_RENAVA,''))								As VeiculoRENAVAM,
	(ISNULL(TIPOS_NF_ENTRADA,''))						As TiposNFEntrada,
	(ISNULL(TIPOS_NF_SAIDA,''))							As TiposNFSaida,
	(ISNULL(TIPOS_NF_ENTRADA_IND,''))					As TiposNFEntradaInd,
	(ISNULL(TIPOS_NF_SAIDA_IND,''))						As TiposNFSaidaInd,
	(ISNULL(TIPOS_NF_ENTRADA_QTDE_TIPO,0))				As TiposNFEntradaTipoQtde,
	(ISNULL(TIPOS_NF_SAIDA_QTDE_TIPO,0))				As TiposNFSaidaTipoQtde,
	(ISNULL(NF_ENTRADA_QTDE,0))							As NFEntradaQtde,
	(ISNULL(NF_SAIDA_QTDE,0))							As NFSaidaQtde,
	(ISNULL(NF_TOTAL_QTDE,0))							As NFTotalQtde,	
	(ISNULL(TIPOS_NF_ENTRADA_PRODUTOS,''))				As TiposNFEntradaProdutos,
	(ISNULL(TIPOS_NF_ENTRADA_TIPOS_PRODUTOS,''))		As TiposNFEntradaTiposProdutos,
	(ISNULL(TIPOS_NF_SAIDA_PRODUTOS,''))				As TiposNFSaidaProdutos,
	(ISNULL(TIPOS_NF_SAIDA_TIPOS_PRODUTOS,''))			As NFSaidaTiposProdutos,
    (ISNULL(CC0_STATUS_DESC,''))						As MDFEStatusDescricao,
    (ISNULL(CC0_STATEV_DESC,''))						As MDFESratusEventoDescricao,
    (ISNULL(CC0_TPNF_DESC,''))							As TipoNFDescricao,
	(ISNULL(TIPOS_NF_ENTRADA_Normal_QTDE,0))			As NFEntradaTipoNormalQtde,
	(ISNULL(TIPOS_NF_ENTRADA_Devolucao_QTDE,0))			As NFEntradaTipoDevolucaoQtde,
	(ISNULL(TIPOS_NF_ENTRADA_Beneficiamento_QTDE,0))	As NFEntradaBeneficiamentoQtde,

	(ISNULL(TIPOS_NF_Saida_Normal_QTDE,0))				As NFSaidaTipoNormalQtde,
	(ISNULL(TIPOS_NF_Saida_Devolucao_QTDE,0))			As NFSaidaTipoDevolucaoQtde,
	(ISNULL(TIPOS_NF_Saida_Beneficiamento_QTDE,0))		As NFSaidaTipoBeneficiamentoQtde,

	(ISNULL(TIPOS_NF_ENTRADA_TIPOS_PRODUTOS_PA,0))		As TIPOS_NF_ENTRADA_TIPOS_PRODUTOS_PA,
	(ISNULL(TIPOS_NF_ENTRADA_TIPOS_PRODUTOS_PI,0))		As TIPOS_NF_ENTRADA_TIPOS_PRODUTOS_PI,
	(ISNULL(TIPOS_NF_ENTRADA_TIPOS_PRODUTOS_MC,0))		As TIPOS_NF_ENTRADA_TIPOS_PRODUTOS_MC,
	(ISNULL(TIPOS_NF_ENTRADA_TIPOS_PRODUTOS_MP,0))		As TIPOS_NF_ENTRADA_TIPOS_PRODUTOS_MP,
	(ISNULL(TIPOS_NF_ENTRADA_TIPOS_PRODUTOS_Outros,0))	As TIPOS_NF_ENTRADA_TIPOS_PRODUTOS_OUTROS,
	(ISNULL(TIPOS_NF_ENTRADA_TIPOS_PRODUTOS_MAIOR,0))	As TIPOS_NF_ENTRADA_TIPOS_PRODUTOS_MAIOR,
	
	(ISNULL(TIPOS_NF_SAIDA_TIPOS_PRODUTOS_PA,0))		As TIPOS_NF_SAIDA_TIPOS_PRODUTOS_PA,
	(ISNULL(TIPOS_NF_SAIDA_TIPOS_PRODUTOS_PI,0))		As TIPOS_NF_SAIDA_TIPOS_PRODUTOS_PI,
	(ISNULL(TIPOS_NF_SAIDA_TIPOS_PRODUTOS_MC,0))		As TIPOS_NF_SAIDA_TIPOS_PRODUTOS_MC,
	(ISNULL(TIPOS_NF_SAIDA_TIPOS_PRODUTOS_MP,0))		As TIPOS_NF_SAIDA_TIPOS_PRODUTOS_MP,
	(ISNULL(TIPOS_NF_SAIDA_TIPOS_PRODUTOS_Outros,0))	As TIPOS_NF_SAIDA_TIPOS_PRODUTOS_OUTROS,
	(ISNULL(TIPOS_NF_SAIDA_TIPOS_PRODUTOS_MAIOR,0))		As TIPOS_NF_SAIDA_TIPOS_PRODUTOS_MAIOR,
	(ISNULL(Valid_NF_MAIOR,0))							As Valid_NF_MAIOR,
	(ISNULL(Valid_Produto,0))							As Valid_Produto,
	(ISNULL(VALOR_FRETE,0))								As VALOR_FRETE,
	(ISNULL(VALOR_FRETE_TERCEIROS,0))					As VALOR_FRETE_TERCEIROS,
	(ISNULL(VALOR_FRETE_TERCEIROS-VALOR_FRETE,0))		As VALOR_FRETE_SAVING	
			
FROM ExtractedCNPJData
Order By 10,12;
