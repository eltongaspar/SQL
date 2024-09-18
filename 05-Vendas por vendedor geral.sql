-- Vendas por vendedor geral

--Select Sum(C5_COMIS1),C5_VEND1 From SC5010
--Where C5_NOTA <> '' and C5_EMISSAO > '20210101' and D_E_L_E_T_=''
--Group By C5_VEND1

--SA3 - Vendedores
--Select * From SA3010 Where D_E_L_E_T_='' Order By A3_COD


--SF4 - Tipos de Entrada e Saida
-- Select * From SF4010

--SD2 - Itens de Venda da NF
-- Select * From SD2010

--SC5 - Pedidos de Venda
--Select * From SC5010 


Select C5_VEND1, A3_NOME,A3_FILIAL, Sum(D2_TOTAL) TOTAL
From SC5010

Inner Join SA3010 SA3 With (NOLOCK)
ON A3_COD = C5_VEND1
AND SA3.D_E_L_E_T_ = ''

Inner Join SD2010 With (NOLOCK)
ON D2_PEDIDO=C5_NUM
And SD2010.D_E_L_E_T_ =''

INNER JOIN SF4010 SF4 WITH (NOLOCK)
ON F4_FILIAL = ' '
AND F4_CODIGO=D2_TES
AND F4_DUPLIC='S'
AND SF4.D_E_L_E_T_=''

Where 
D2_EMISSAO > '20180101'

Group By 
C5_VEND1, A3_NOME, A3_FILIAL

Order By
C5_VEND1, A3_NOME

