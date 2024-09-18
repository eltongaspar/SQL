Select * From GXG010 GXG
Where GXG.D_E_L_E_T_ = ''
And GXG_DTEMIS Between '20240501' and '20240531'

Select * From GXH010



Select Distinct
	GXG_CTE,GXH_DANFE,F2_TIPO,F2_DOC,F2_VALBRUT,F2_VALMERC,F2_PLIQUI,F2_PBRUTO,
	--D2_XOPER,D2_COD,D2_ITEM,* 
	NF_Qtde_Itens = (COUNT(D2_COD)),

	Case 
		When F2_VALBRUT > 0 And F2_PBRUTO > 0
		Then Round((F2_VALBRUT / F2_PBRUTO),2)
		Else 0 
	End As Valor_Peso,

	Case 
		When F2_VALBRUT > 0 And F2_PBRUTO > 0
		Then Round((F2_VALBRUT / (COUNT(D2_COD))),2)
		Else 0 
	End As Valor_Item,

	Case 
		When F2_VALBRUT > 0 And F2_PBRUTO > 0
		Then Round((F2_PBRUTO / (COUNT(D2_COD))),2)
		Else 0 
	End As Peso_Item

From GXG010 GXG With(Nolock)

	Inner Join GXH010 GXH With(Nolock)
	On GXG_FILIAL = GXH_FILIAL
	And GXG_NRIMP = GXH_NRIMP
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
	
Where GXG.D_E_L_E_T_ = '' and GXH.D_E_L_E_T_ = ''
And GXG_DTEMIS Between '20240501' and '20240531'
--And F2_TIPO = 'N'
Group By GXG_CTE,GXH_DANFE,F2_TIPO,F2_DOC,F2_VALBRUT,F2_VALMERC,F2_PLIQUI,F2_PBRUTO
