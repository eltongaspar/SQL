-- NF Saida Itens 
Select Distinct D2_DOC,D2_PEDIDO, D2_TES,F4_TEXTO,F4_FORMULA COD_FORMULA_TES, SM4TES.M4_FORMULA FORMULA_TES,
				F2_FORMUL COD_FORMULA_NFCab, SM4NFSCab.M4_FORMULA FORMULA_NFCab,
				SA1.A1_MENPAD COD_FORMULA_CLI, SM4CLI.M4_FORMULA FORMULA_CLIENTE,
				SC5.C5_MENPAD COD_FORMULA_PV, SM4PV.M4_FORMULA FORMULA_PV,
				D2_CLIENTE,D2_LOJA, SA1.A1_NOME

From SD2010 SD2
 
    -- TES
	Inner Join SF4010 SF4 With(Nolock)
	ON SF4.F4_CODIGO = D2_TES
	And SF4.D_E_L_E_T_ = ''

	 -- Formulas TES 
	LEFT Join SM4010 SM4TES With(Nolock)
	ON SM4TES.M4_CODIGO = F4_FORMULA
	And SM4TES.D_E_L_E_T_ = ''

	 -- NF Saida Cab.
	LEFT Join SF2010 SF2 With(Nolock)
	ON SF2.F2_FILIAL = D2_FILIAL
	And SF2.F2_LOJA = D2_LOJA
	And SF2.F2_DOC = D2_DOC
	And SF2.D_E_L_E_T_ = ''

    -- TES NF Saida Cab
	Left Join SM4010 SM4NFSCab With(Nolock)
	ON SM4NFSCab.M4_CODIGO = SF2.F2_FORMUL
	And SM4NFSCab.D_E_L_E_T_ = ''

	 -- Clientes 
	LEFT Join SA1010 SA1 With(Nolock)
	ON SA1.A1_COD = SD2.D2_CLIENTE
	And SA1.D_E_L_E_T_ = ''

	-- Formulas Clientes
	LEFT Join SM4010 SM4CLI With(Nolock)
	ON SM4CLI.M4_CODIGO = SA1.A1_MENPAD
	And SM4CLI.D_E_L_E_T_ = ''

	-- Pedidos de Vendas Itens 
	LEFT Join SC6010 SC6 With(Nolock)
	ON SC6.C6_NOTA = SD2.D2_DOC
	And SC6.C6_FILIAL = SD2.D2_FILIAL
	And SC6.C6_LOJA = SD2.D2_LOJA
	And SC6.D_E_L_E_T_ = ''

	-- Pedidos de Vendas Cab.
	LEFT Join SC5010 SC5 With(Nolock)
	ON SC5.C5_NOTA = SD2.D2_DOC
	And SC5.C5_FILIAL = SD2.D2_FILIAL
	And SC5.C5_LOJACLI = SD2.D2_LOJA
	And SC5.D_E_L_E_T_ = ''

		-- Formulas PV
	LEFT Join SM4010 SM4PV With(Nolock)
	ON SM4PV.M4_CODIGO = SC5.C5_MENPAD
	And SM4PV.D_E_L_E_T_ = ''
		

Where D2_FILIAL = '01' and D2_DOC In ('000366590') and SD2.D_E_L_E_T_ =''
Order By 1

