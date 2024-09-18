-- Tabela Contas a Pagar
Select E2_NUM, E2_HIST, * From SE2010
Where E2_FILIAL = 'FA' and E2_FILORIG = 'FA01' and D_E_L_E_T_ = ''
--and E2_VENCTO = '20210201' and E2_NUM = '010221'
and E2_HIST = 'DISTRIBUIÇÃO DE LUCROS'
and E2_VALOR = '31675' 
-- E2_NUM '010321' and '010421'