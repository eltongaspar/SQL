-- SC5 - Pedidos de Venda
Select * From SC5010
Where C5_FILIAL = 'BA15' and C5_NUM = '000275'

--SA4 - Transportadoras
Select * From SA4010
Where A4_COD = '000730'

--SA2 - Fornecedores
Select * From SA2010
Where A2_CGC = '10408408000150' and D_E_L_E_T_ =''

--GU3 - EMITENTES DE TRANSPORTE
Select GU3_CDTERP, GU3_CDERP, * From GU3010
Where GU3_CDEMIT = '000011063' or GU3_CDTERP = '000730'

--SA1 - Clientes
Select * From SA1010
Where A1_COD = '000276' and A1_LOJA = '11'

-- GW1 - DOCUMENTOS DE CARGA
Select * From GW1010
Where GW1_FILIAL = 'BA15'

--SX6 - Parametros
Select * From SX6010
Where X6_FIL Like 'BA%' and 
X6_VAR In ('MV_INTGFE','MV_INTGFE2')


