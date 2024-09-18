-- ZE_CTRLE = ZZV_ID
Select ZE_NUMBOB,ZE_CTRLE,DC_PEDIDO,DC_LOCALIZ,BF_QUANT,BF_EMPENHO,ZZV_SUPER,A3_NOME,A3_CGC,A3_DEMISS,ZZV_STATUS,
C9_PEDIDO,C6_QTDVEN,C9_QTDLIB,C6_ITEM,C9_NFISCAL,C6_DATFAT,A1_COD, A1_NOME,D2_DOC,D2_ITEM, E1_NUM, E1_BAIXA,E1_PARCELA
From SZE010 SZE

	 --SDC - Composicao do Empenho
	 Inner Join SDC010 SDC
	 On DC_FILIAL = ZE_FILIAL
	 And DC_PRODUTO = ZE_PRODUTO
	 And DC_PEDIDO = ZE_CTRLE
	 And SDC.D_E_L_E_T_ ='' 

	 --SBF - Saldos por Endereco
	 Inner Join SBF010 SBF
	 On BF_FILIAL= DC_FILIAL
	 And BF_PRODUTO = DC_PRODUTO
	 And BF_LOCALIZ = DC_LOCALIZ
	 And SBF.D_E_L_E_T_ ='' 

	 --CONTROLE NEGOCIO VENDAS 
	 Inner Join ZZV010 ZZV
	 On ZZV_FILIAL = ZE_FILIAL
	 And ZZV_PRODUT = ZE_PRODUTO
	 And ZZV_ID = ZE_CTRLE
	 And ZZV_NUMBOB = ZE_NUMBOB
	 And ZZV.D_E_L_E_T_ ='' 

	 -- Vendedores
	 Inner Join SA3010 SA3
	 On	A3_COD = ZZV_SUPER
	 And SA3.D_E_L_E_T_ ='' 

	 --PV Liberado 
	 Left Join SC9010 SC9
	 On C9_FILIAL = ZZV_FILIAL
	 And C9_PEDIDO = ZZV_PEDIDO
	 And C9_PRODUTO =  ZZV_PRODUT
	 And C9_ITEM = ZZV_ITEM
	 And SC9.D_E_L_E_T_ ='' 

	 --PV Itens
	 Inner Join SC6010 SC6
	 On C6_FILIAL = ZZV_FILIAL
	 And C6_NUM = ZZV_PEDIDO
	 And C6_PRODUTO =  ZZV_PRODUT
	 And C6_ITEM = ZZV_ITEM
	 And SC6.D_E_L_E_T_ ='' 

	 -- Clientes 
	 Inner Join SA1010 SA1
	 On A1_COD = C6_CLI
	 And A1_LOJA = C6_LOJA
	 And SA3.D_E_L_E_T_ ='' 

	 -- Itens NF Saida 
	 Left Join SD2010 D2
	 On D2_FILIAL = C6_FILIAL
	 And D2_LOJA = C6_LOJA
	 And D2_COD = C6_PRODUTO
	 And D2_DOC = C6_NOTA
	 And D2_ITEMPV = C6_ITEM
	 And D2.D_E_L_E_T_ ='' 

	 -- Contas a Receber 
	 Left Join SE1010 SE1
	 On E1_FILIAL = D2_FILIAL
	 And E1_LOJA = D2_LOJA
	 And E1_CLIENTE = D2_CLIENTE
	 And E1_NUM = D2_DOC
	 And E1_PARCELA In ('1','A')
	 And SE1.D_E_L_E_T_ = ('') 
	 
Where ZE_FILIAL In ('02') and ZE_PRODUTO In ('1520604401') and ZE_STATUS Not in  ('F','C')
And ZE_NUMBOB = '2085868'
and SZE.D_E_L_E_T_ =''


