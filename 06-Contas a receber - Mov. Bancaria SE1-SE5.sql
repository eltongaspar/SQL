--SE1 - Contas a Receber
Select * From SE1010
Where E1_NUM Like '%11973'  and E1_FILORIG = 'FA01' and E1_VALOR = '2535.18'
and D_E_L_E_T_ = ''

--SE5 - Movimentacao Bancaria
Select E5_NUMERO, E5_VALOR, E5_LA, E5_HISTOR,  * From SE5010
Where E5_NUMERO Like  '%11973' and E5_DATA > '20211201' and E5_VALOR = '2535.18' and D_E_L_E_T_='' and E5_LA='' 