--Analise Renegociação com Industrialização 

--PV Itens 
SELECT C6_QTDENT, C6_QTDVEN, C6_ZZPVORI,C6_XNEGOC, *
FROM SC6010 (NOLOCK)
WHERE C6_FILIAL = '02'
AND C6_NUM = '113054'
AND C6_ITEM = '19'
AND D_E_L_E_T_ = ''

-- PV Liberados 
SELECT C9_ITEM,C9_ITEMREM,*
FROM SC9010 (NOLOCK)
WHERE C9_FILIAL = '02'
AND C9_PEDIDO = '113054'
AND (C9_ITEM = '19' or C9_ITEMREM = '19')
AND D_E_L_E_T_ = ''

-- PV Itens Industrialização 
SELECT C6_QTDENT, C6_QTDVEN, C6_ZZPVORI,C6_XNEGOC, *
FROM SC6010 (NOLOCK)
WHERE C6_FILIAL = '01'
AND C6_NUM = '419493'
AND C6_ITEM = '01'
AND D_E_L_E_T_ = ''

-- PV Liberados Industrializados 
SELECT C9_ITEM,C9_ITEMREM,*
FROM SC9010 (NOLOCK)
WHERE C9_FILIAL = '01'
AND C9_PEDIDO = '419493'
AND C9_ITEM = '01'
AND D_E_L_E_T_ = ''

-- Renegociação - Industrialização 
SELECT *
FROM ZZV010 (NOLOCK)
WHERE (ZZV_FILIAL = '01'
AND ZZV_PEDIDO = '419493')
Or (ZZV_FILIAL = '02'
AND ZZV_PEDIDO = '113054')
AND D_E_L_E_T_ = ''

-- Composição do Empenho - Industrialização em Renegociação 
SELECT *
FROM SDC010 (NOLOCK)
WHERE DC_FILIAL = '01'
AND DC_ORIGEM = 'ZZV'
AND DC_PEDIDO = '006087'
AND D_E_L_E_T_ = ''

---- Composição do Empenho - Industrialização com Aceite
SELECT *
FROM SDC010 (NOLOCK)
WHERE DC_FILIAL = '01'
AND DC_PEDIDO = '419493'
AND D_E_L_E_T_ = ''


---- Composição do Empenho - Industrialização com Aceite
SELECT *
FROM SDC010 (NOLOCK)
WHERE DC_FILIAL = '02'
AND DC_PEDIDO = '113054'
AND D_E_L_E_T_ = ''