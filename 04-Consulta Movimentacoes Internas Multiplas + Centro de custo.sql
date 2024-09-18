--Movimentações internas
Select * From SD3010
Where D3_FILIAL = 'FK01' and D3_COD in ('5402000702','5402000715','5402000704') and D3_EMISSAO >= '20211203' 
and D3_TM in ('020','999') and D3_ESTORNO = ''

-- Centro de custo
Select * From C1P010
Where C1P_FILIAL = 'BA01'

--SH6 – Movimentações da Produção
Select * From SH6010
Where  H6_FILIAL = 'BA01'and H6_PRODUTO = '041007002' And D_E_L_E_T_=''