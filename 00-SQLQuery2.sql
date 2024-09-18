--CTT - Centro de Custo
--Voltar lançamento exluido
--1 - achar lançamento por Filial, Data e Valor e localizar o CT2_SEQUEN
Select CT2_SEQUEN,CT2_HIST, CT2_VALOR, CT2_ZZDOC, * From CT2010
Where CT2_FILORI  = 'BA21' and CT2_DATA = '20220429' and D_E_L_E_T_='*' and CT2_VALOR In ('963.45','620.30') 
and CT2_ZZDOC In ('000000150','000000153')
and CT2_SEQUEN = '0001147349'
--and CT2_DEBITO <> '' 

-- 2 - pelo CT2_SEQUEN ahar as qtde de linhas excluidas e voltar o lancamento 
Select CT2_HIST, CT2_SEQUEN, CT2_VALOR, * From CT2010
Where CT2_FILORI = 'BA21' and CT2_DATA = '20220429' and D_E_L_E_T_='*' and CT2_SEQUEN In('0001157482','0001157830')

-- SE5 - Mov. Bancaria 
Select * From SE5010
Where E5_FILORIG = 'BA03' and E5_DATA = '20220131' and E5_VALOR = '20043.75'





-- Pedido Compra
SELECT C7_FILIAL, C7_PRODUTO, C7_NUM, C7_NUMCOT, C7_NUMSC, C7_FORNECE, C7_LOJA, C7_QUJE, C7_CONAPRO, C7_QUANT, C7_RESIDUO, C7_ENCER, * FROM SC7010 
WHERE C7_FILIAL='BA07' AND C7_NUM in ('000612') and D_E_L_E_T_ = ''

--Cotações
SELECT C8_FILIAL, C8_PRODUTO, C8_NUMPED,C8_NUM,C8_NUMSC, C8_FORNECE, C8_LOJA, * FROM SC8010 
WHERE C8_FILIAL='BA07' AND C8_NUM = '000636' AND D_E_L_E_T_='' and NOT C8_NUMPED = 'XXXXXX' and C8_NUMPED in ('000612')

-- Solicitação de compra
Select C1_FILIAL, C1_PRODUTO, C1_PEDIDO, C1_COTACAO, C1_NUM, C1_FORNECE, C1_LOJA, * From SC1010
Where C1_FILIAL = 'BA07' and C1_NUM = '000587' and D_E_L_E_T_ = '' and C1_PEDIDO = '000612'

-- Consulta Clientes
--SELECT * FROM SA1010 WHERE A1_COD='000582'

--Consulta Fornecedores
--SELECT * FROM SA2010 WHERE A2_COD in ('013464','013733') and D_E_L_E_T_ = ''

--Consulta Fornecedores CNPJ/CPF
--SELECT * FROM SA2010 WHERE A2_CGC = '08028659000168' and D_E_L_E_T_ = ''
