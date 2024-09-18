-- Erro módulo 29 - Easy Export Control

--EET - Despesas de Exportacao
Select * From EET010
Where EET_FILIAL = 'BA01' and EET_PEDIDO = '23/108-SC'  and D_E_L_E_T_ =''
Order By EET_DESPES
--and EET_FINNUM = '200004362'

--EEB - Agentes de um Pedido
Select * From EEB010
Where EEB_FILIAL = 'BA01' and EEB_PEDIDO = '23/108-SC' and D_E_L_E_T_ =''


-- Despesas
Select * From SYB010
Where YB_DESP In ('958','425')
