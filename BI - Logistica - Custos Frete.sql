
Select Distinct
	GXG_CTE,GXH_DANFE,F1_CHVNFE,
	F1_DOC,F1_TIPO,F1_ESPECIE,F2_TIPO,F2_DOC,F2_VALBRUT,F2_VALMERC,F2_PLIQUI,F2_PBRUTO,
	D2_XOPER,D2_COD,D2_ITEM,B1_TIPO,
	NF_Qtde_Itens = (COUNT(D2_COD)),
	D2_TOTAL, D2_PESO,

	Case 
		When F2_VALBRUT > 0 And F2_PBRUTO > 0
		Then Round((F2_VALBRUT / F2_PBRUTO),2)
		Else 0 
	End As Valor_Peso,

	Case 
		When F2_VALBRUT > 0 And F2_PBRUTO > 0
			 Then Round((F2_VALBRUT / (COUNT(D2_COD))),2)
		Else 0 
	End As Valor_Itens,

	Case 
		When F2_VALBRUT > 0 And F2_PBRUTO > 0
		Then Round((F2_PBRUTO / (COUNT(D2_COD))),2)
		Else 0 
	End As Peso_Itens,

	

	Peso_Bruto_NF = (Select Isnull(Sum (F2_PBRUTO),0)
						From GXG010 GXG02
						
							Inner Join GXH010 GXH With(Nolock)
								On GXG02.GXG_FILIAL = GXH_FILIAL
								And GXG02.GXG_NRIMP = GXH_NRIMP
								And GXG02.D_E_L_E_T_ = ''
	
							Left Join SF2010 SF2 With(NoLock)
								On SF2.F2_FILIAL = GXH.GXH_FILIAL
								And SF2.F2_CHVNFE = GXH.GXH_DANFE
								And SF2.D_E_L_E_T_ = ''

							Where GXG02.GXG_FILIAL = GXG.GXG_FILIAL 
								And GXG02.GXG_CTE = GXG.GXG_CTE
								And GXG02.D_E_L_E_T_ =''
					),


	VAlor_Mercadoria_NF = (Select Isnull(Sum (F2_VALBRUT),0)
						From GXG010 GXG02
						
							Inner Join GXH010 GXH With(Nolock)
								On GXG02.GXG_FILIAL = GXH_FILIAL
								And GXG02.GXG_NRIMP = GXH_NRIMP
								And GXG02.D_E_L_E_T_ = ''
	
							Left Join SF2010 SF2 With(NoLock)
								On SF2.F2_FILIAL = GXH.GXH_FILIAL
								And SF2.F2_CHVNFE = GXH.GXH_DANFE
								And SF2.D_E_L_E_T_ = ''

							Where GXG02.GXG_FILIAL = GXG.GXG_FILIAL 
								And GXG02.GXG_CTE = GXG.GXG_CTE
								And GXG02.D_E_L_E_T_ =''
					),
	
	
								
GXG_PESOR,GXG_FRPESO,GXG_FRVAL,GXG_VLIMP,GXG_PEDAG,GXG_VLDF,
GXG_VLCARG,GXG_QTVOL,GXG_ZZDTOM,GXG_UFINI,GXG_UFFIM,GXG_QTDCS,
F1_VALMERC,F1_VALBRUT,

		Case
			When GXG_VLDF > 0 and GXG_PESOR > 0
			Then Round((GXG_VLDF/GXG_PESOR),4) 
			Else 0
		End As Valor_FRETE_KG,

		Case
			When GXG_VLCARG > 0 and GXG_PESOR > 0
			Then Round((GXG_VLCARG/GXG_PESOR),4) 
			Else 0
		End As Valor_Carga_KG,

	((D2_PESO*D2_QUANT)) As Peso_Item,
	(D2_TOTAL/(D2_PESO*D2_QUANT)) As Valor_Carga_Item_KG,
	(GXG_VLCARG/(D2_PESO*D2_QUANT)) As Valor_Carga_Item_NF



From GXG010 GXG With(Nolock)

	Inner Join GXH010 GXH With(Nolock)
	On GXG_FILIAL = GXH_FILIAL
	And GXG_NRIMP = GXH_NRIMP
	And GXG.D_E_L_E_T_ = ''
	--And GXH_SEQ = '00001'

		-- NF Saida - Cab.
	Left Join SF2010 SF2 With(NoLock)
	On SF2.F2_FILIAL = GXH.GXH_FILIAL
	And SF2.F2_CHVNFE = GXH.GXH_DANFE
--	And SF2.F2_TRANSP = GXG.GXG_EMISDF
	And SF2.D_E_L_E_T_ = ''

	-- NF Saida - Itens 
	Left Join SD2010 SD2 With(NoLock)
	On SD2.D2_FILIAL = SF2.F2_FILIAL
	And SD2.D2_DOC = SF2.F2_DOC
--	And SF2.F2_TRANSP = GXG.GXG_EMISDF
	And SD2.D_E_L_E_T_ = ''

	-- NF Entrada - CTE
	Left Join SF1010 SF1 With(NoLock)
	On GXG.GXG_FILIAL = F1_FILIAL
	And GXG.GXG_CTE = F1_CHVNFE
	And SF1.D_E_L_E_T_ = ''

	--Produtos 
	Inner Join SB1010 SB1
	On D2_COD = B1_COD
	And SB1.D_E_L_E_T_ = ''
		
Where GXG.D_E_L_E_T_ = '' and GXH.D_E_L_E_T_ = ''
--And GXG_DTEMIS Between '20240501' and '20240531'
And GXG_CTE = '35200589823918003089570000004361591290202896'
Group By GXG_CTE,GXH_DANFE,F2_TIPO,F2_DOC,F2_VALBRUT,F2_VALMERC,F2_PLIQUI,F2_PBRUTO,
		GXG_PESOR,GXG_FRPESO,GXG_FRVAL,GXG_VLIMP,GXG_PEDAG,GXG_VLDF,
		GXH_FILIAL,GXH_FILIAL,GXH_NRIMP,GXG_FILIAL,GXG_NRIMP,GXG_VLCARG,GXG_QTVOL,GXG_ZZDTOM,GXG_UFINI,GXG_UFFIM,GXG_QTDCS,
		F1_CHVNFE,F1_TIPO,F1_DOC,F1_VALMERC,F1_VALBRUT,F1_ESPECIE,
		D2_XOPER,D2_COD,D2_ITEM,B1_TIPO,D2_TOTAL,D2_PESO,D2_QUANT

Order By 1
