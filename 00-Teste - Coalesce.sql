Select 
Coalesce ((Case When E2_PARCELA = '' Then '***' End),'###') As E2_PARCELA,
(Case When E2_PARCELA = '' Then '***' Else Coalesce(E2_PARCELA,'@@@') End) As E2_PARCELA,
Coalesce (E2_VRETISS,E2_VRETIRF,E2_VRETPIS,E2_VRETINS,E2_VRETCOF,E2_VRETCSL,0),
Coalesce (F1_ISS,F1_VALIRF,F1_INSS,0),
Coalesce (E2_PIS,E2_COFINS,E2_CSLL,0),
Coalesce (F1_VALPIS,F1_VALCOFI,F1_VALCSLL,0)

From SF1010 SF1

	--NF Entrada Cab.
	Left Join SE2010 SE2
	On F1_FILIAL = E2_FILIAL
	And F1_DOC = E2_NUM
	And F1_FORNECE = E2_FORNECE
	And F1_LOJA = E2_LOJA
	And SE2.D_E_L_E_T_ = ''
	
--Where E2_PARCELA In ()
--And SF1.D_E_L_E_T_ = ''

