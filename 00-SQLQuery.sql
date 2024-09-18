--Select * From SC1010
--Where C1_UM = 'HR' And C1_PRODUTO = 'MOD300109' Or C1_QUANT <> '0'

--Select * From SC8010
--Where C8_FILIAL = 'BA01' and C8_PRODUTO ='0210050059' and C8_UM > '30000' and C8_PRECO > '3.35'


-- Consulta Código Produto
Select * From SB1010
Where B1_COD = '5402000724' 
--or B1_DESC = 'GLICERINA BI-DESTILADA'

--Select * From SB2010 
--Where B2_FILIAL = 'BA01' and B2_COD = '0210050059'

--Select * From SE1010 
--Where E1_FILIAL = 'BA' and E1_NUM = '250913' and E1_CLIENTE = '000546'

--Select * From SE5010
--Where E5_NUMERO = '250913' and E5_FILIAL = 'AE'

--Select * From SA2010 
--Where A2_COD = '000029'

--Select * From SA5010 
--Where A5_FORNECE = '000029'

--Select * From SA5010
--Where A5_FORNECE = '000029'


-- Consuta Produto Qtde Atual (Estoque)
--Select * From SB2010
--Where B2_COD = '0210050007' --consulta produto especifico
--and B2_FILIAL = 'BA01' --consulta filial especifica
--and B2_QATU > '0' --consulta quantidade de estqoue especifica < = > <>

-- Consulta Perdas por Operação
--Select * From SBC010
--Where BC_PRODUTO = '0210050122'

--Select * From SC7010
--Where C7_FILIAL = 'BA01' and C7_QTDACLA = '0' and C7_NUM = '000001'

-- Consulta Verbas (RH)
--Select * From SRV010
--Where RV_FILIAL = 'FA' and RV_COD = '676'

-- Consulta apontamentos funcionários
Select * From SPH010
--Where P8_FILIAL = 'FA03' and P8_MAT = '000705'