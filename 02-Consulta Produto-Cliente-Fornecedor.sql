--Consulta Código Produto
Select * From SB1010
Where B1_COD = '0100030035' 
--or B1_DESC = 'GLICERINA BI-DESTILADA'


-- Consulta Cliente
Select * From SA1010
Where A1_COD = '000276' and A1_LOJA = '01'

Select * From SA1010
Where A1_CGC = '60369295000361'

-- Consulta Fornecedor
Select * From SA2010
Where A2_COD = '000276' and A2_LOJA = '01'

Select * From SA2010
Where A2_CGC = '60369295000361'

-- Tabela SA5 - Amarracao Produto x Fornecedor
Select * From SA5010
Where A5_PRODUTO = '0100030035'