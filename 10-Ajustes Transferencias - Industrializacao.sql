-- Pedido de Vendas Liberado
-- Verificar PC x Prddutos no Estoque SC9xSB2
-- Campos Custo Medio e Valor Atual Estourados
-- Calculos Valor Atual D2_Custo1 Aproximado

Select C9_PRODUTO,
Sum(C9_QTDLIB*C9_PRCVEN) as VAL_TOTAL_VENDA, 
Sum(C9_QTDLIB) As C9_QTDLIB, 
Sum(SB2.B2_CM1*C9_QTDLIB)/Sum(C9_QTDLIB) AS CUS_MED,
Sum(SC9.C9_QTDLIB * SB2.B2_VATU1) As D2_CUSTO1,
Sum(SC9.C9_QTDLIB * SB2.B2_VATU1)-Sum(B2_VATU1) As VAL_ATUALIZADO,

Len(Sum(SC9.C9_QTDLIB * SB2.B2_VATU1)) As DEC_D2_CUSTO1,
Len(Sum(SC9.C9_QTDLIB * SB2.B2_VATU1)-Sum(B2_VATU1)) As DEC_VAL_ATUALIZADO,

Count(C9_PRODUTO) As Cont
From SC9010 SC9

	Inner Join SB2010 SB2
	On SB2.B2_COD = C9_PRODUTO
	And SB2.B2_FILIAL = C9_FILIAL 
	And SB2.B2_LOCAL = C9_LOCAL
	And SB2.D_E_L_E_T_ =''

Where C9_FILIAL = '01' and C9_PEDIDO In ('394156','394097','394195','394248','394250','394333','394486','394806','394643','394682','394996','395270',
'395630','395349','395780','395694','395885','395889','396097','396110','396448','396274','396265','396827','396829','396421','396528','396964','397076',
'396818','396791','396784','396848') 
and SC9.D_E_L_E_T_ =''
Group By C9_PRODUTO
Order By 7 Desc



-- Pedido de Vendas Liberado x Estoques
-- SC9xSB2
Select C9_PRODUTO,C9_QTDLIB,C9_PRCVEN,SB2.B2_CM1,SB2.B2_VATU1,SB2.B2_QATU
From SC9010 SC9

	Inner Join SB2010 SB2
	On SB2.B2_COD = C9_PRODUTO
	And SB2.B2_FILIAL = C9_FILIAL 
	And SB2.B2_LOCAL = C9_LOCAL
	And SB2.D_E_L_E_T_ =''

Where C9_FILIAL = '01' and C9_PEDIDO In ('394156','394097','394195','394248','394250','394333','394486','394806','394643','394682','394996','395270',
'395630','395349','395780','395694','395885','395889','396097','396110','396448','396274','396265','396827','396829','396421','396528','396964','397076',
'396818','396791','396784','396848') 
and SC9.D_E_L_E_T_ =''
Order By 1 Desc



-- Estoque de Terceiros
-- Zerando Campos SB6 - Produtos Empenhados na Transferencias 
-- B6_QULIB
SELECT B6_QULIB, *
--UPDATE SB6010 SET B6_QULIB = 0
FROM SB6010
WHERE B6_FILIAL = '01'
AND B6_PRODUTO = '2010000000'
AND B6_SALDO <> 0
AND B6_QULIB <> 0
AND D_E_L_E_T_ = ''

Select * From SB2010
Where B2_COD = '1200603401'


-- Estoque 
--  Zerandos Campos Custos Medio (1,2,3,4,5) e Valor Atual (1,2,3,4,5)
SELECT *
--UPDATE SB2010 SET B2_VATU1 = 0, B2_CM1 = 0
--UPDATE SB2010 SET B2_VATU2 = 0, B2_CM2 = 0, B2_VATU3 = 0, B2_CM3 = 0,B2_VATU4 = 0, B2_CM4 = 0, B2_VATU5 = 0, B2_CM5 = 0
FROM SB2010
WHERE B2_FILIAL  = '01'
AND B2_LOCAL = '01'
AND D_E_L_E_T_ = ''


-- Estoque de Terceiros
-- Zerando Campos SB6 - Produtos Empenhados na Transferencias 
-- B6_QULIB
SELECT B6_QULIB, *
--UPDATE SB6010 SET B6_QULIB = 0
FROM SB6010
WHERE B6_FILIAL = '01'
AND B6_PRODUTO = '2010000000'
AND B6_SALDO <> 0
AND B6_QULIB <> 0
AND D_E_L_E_T_ = ''


