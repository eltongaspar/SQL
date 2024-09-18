-- Consulta Produto Estoque 
Select * From SB2010
Where B2_FILIAL = 'BA03' and B2_COD in ('0210050151')

-- Consulta Estoque Terceiros 
Select * From SB6010
Where B6_FILIAL = 'BA03' and B6_PRODUTO in ('0210050151') and B6_SALDO > 0

Select Sum (B6_SALDO) Total From SB6010
Where B6_FILIAL = 'BA03' and B6_PRODUTO in ('0210050151') and B6_SALDO > 0
Group By B6_PRODUTO