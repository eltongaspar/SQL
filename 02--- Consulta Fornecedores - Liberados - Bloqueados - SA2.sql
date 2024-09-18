-- Consulta Fornecedores - Liberados / Bloqueados 
-- A2_MSBLQL(1 = Bloqueado / 2 = Liberado)

Select A2_MSBLQL, * From SA2010
Where A2_MSBLQL = '1'


-- Consulta Amarracao ProdutoxFornecedor
Select A5_SITU, Count (A5_SITU) Qtde  From SA5010
--Where A5_SITU <> ''
Group By A5_SITU
Order By A5_SITU ASC