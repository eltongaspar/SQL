Select X6_VAR,X6_VAR, X6_TIPO, X6_DESCRIC, X6_DESC1, * From SX6010
Where X6_VAR In ('MV_CMPDEVV','MV_NATNCC','MV_NCCRESI','MV_TXMOENC')


-- NF de Saida - Cabeçalho
Select F2_CLIENTE, F2_LOJA, F2_HORA, * From SF2010 
Where F2_CLIENTE = '000546' and D_E_L_E_T_=''

-- NF de Saida - itens 
Select D2_LOJA, D2_CLIENTE, D2_DOC, D2_PEDIDO, * From SD2010 
Where D2_CLIENTE = '000546' and D_E_L_E_T_='' and D2_TES = '782'

Select D2_TES, COUNT (D2_TES) QTDE  From SD2010 
Where D2_CLIENTE = '000546' and D_E_L_E_T_=''
Group BY  (D2_TES)
Order By (D2_TES)



-- NF de Entrada - cabeçalho
Select * From SF1010
Where F1_FORNECE = '000546'

-- NF de Entrada - itens 
Select * From SD1010 
Where D1_FORNECE = '000546' and D_E_L_E_T_ =''

Select D1_TES,COUNT (D1_TES) QTDE From SD1010 
Where D1_FORNECE = '000546' and D_E_L_E_T_ =''
Group BY (D1_TES)


--TIPOS DE ENTRADA E SAIDA (TES)
Select F4_PODER3,* From SF4010
Where F4_CODIGO In ('220','221','254','323','320','440')
--Where F4_CODIGO In ('703','669','994','677','741','783','629''504','578','687','710','915','507','782','632','649','634','625','682')
--and F4_PODER3 In ('R','D') 
and F4_DUPLIC = 'S'


-- Consulta Cliente
Select * From SA1010
Where A1_COD = '000546' and A1_LOJA = '01' and D_E_L_E_T_=''

-- Consulta Fornecedor
Select * From SA2010
Where A2_COD = '000546' and A2_LOJA = '01' and D_E_L_E_T_=''