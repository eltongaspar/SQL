--CTT - Centro de Custo
--Voltar lançamento exluido
--1 - achar lançamento por Filial, Data e Valor e localizar o CT2_SEQUEN
Select CT2_SEQUEN,* From CT2010
Where CT2_FILIAL = 'BA06' and CT2_DATA = '20220304' and D_E_L_E_T_='*' and CT2_VALOR ='598'

-- 2 - pelo CT2_SEQUEN ahar as qtde de linhas excluidas e voltar o lancamento 
Select CT2_HIST,* From CT2010
Where CT2_FILIAL = 'BA06' and CT2_DATA = '20220304' and D_E_L_E_T_='' and CT2_SEQUEN In('0001126422')