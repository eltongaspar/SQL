SELECT ZZR_PRODUT, ZZR_ITEMPV, ZZR_LOCALI,ZZR_DOC,SUM(ZZR_QUAN)
	FROM ZZR010 ZZR WITH(NOLOCK) 
		WHERE ZZR_FILIAL	= '03' 
		AND ZZR_PEDIDO		= '005373'
		--AND ZZR_ITEMPV		= D2_ITEMPV 
		AND ZZR_SEQOS		= '04' 
		--AND ZZR_DOC	 = ''
		AND D_E_L_E_T_ = ''
GROUP BY ZZR_PRODUT, ZZR_ITEMPV, ZZR_LOCALI, ZZR_DOC

Select * From SD2010

-- PV Itens 
Select C9_ITEMREM,C9_SEQOS,* From SC9010  With (Nolock)
Where C9_PEDIDO In ('005373')
And C9_FILIAL = '03'
And C9_SEQOS = '04'
And D_E_L_E_T_ = ''
Order By C9_ITEM


   

Select D2_FILIAL,C9_PRODUTO,C9_SEQOS,C9_SEQUEN,D2_COD,C9_NFISCAL,D2_DOC,C9_PEDIDO,D2_PEDIDO,C9_ITEM,D2_ITEMPV,
* From SD2010 SD2 With (Nolock)

Inner Join SC9010 SC9 With (Nolock)
	On D2_FILIAL = C9_FILIAL
	And C9_NFISCAL = D2_DOC
	And C9_PEDIDO = D2_PEDIDO
	And C9_ITEM = D2_ITEMPV
	And C9_PRODUTO = D2_COD
	And SC9.D_E_L_E_T_ = ''

Where C9_SEQUEN > '1' and C9_SEQOS > '1'
And SD2.D_E_L_E_T_ = ''
Order By 1,8,2
