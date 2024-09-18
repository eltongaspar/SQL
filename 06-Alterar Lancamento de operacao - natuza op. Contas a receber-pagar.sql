-- Contas a receber
Select E1_VALOR, * From SE1010
Where E1_FILIAL = 'ED' and E1_FILORIG = 'ED20'
and E1_NUM in ('000003233', '000003265','000003280','000003281','000003294','000003293','000003299','000003304','000002584','000003310',
'000003316','000003323','000003346','000003347','000003351')
and E1_CLIENTE = '005504' 
and E1_PREFIXO = '20'

-- Alterar Lançamento de operacação -  Natureza da Operãção E1_NATUREZ

-- Contas a pagar 
Select * From SE2010
Where E2_FILIAL = 'ED' and E2_FILORIG = 'ED20' and D_E_L_E_T_=''
-- and E2_NUM in ('000003233')
 and E2_FORNECE = '005732'