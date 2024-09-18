--Isso acontece porque tem SE5 pendente de integração contábil (E5_LA='N')

--Basta passar o E5_LA que estiver 'N' para 'S' que resolve e permite o cancelamento.


--SE5 - Movimentacao Bancaria
SELECT E5_LA, D_E_L_E_T_,* FROM SE5010 WHERE E5_FILIAL='AC' AND E5_NUMERO='000012378' AND E5_DATA='20220214'

--UPDATE SE5010 SET 