--SE2 - Contas a Pagar
Select E2_LA, * From SE2010
Where E2_NUM In ('000001730') and E2_FORNECE = '009805' and D_E_L_E_T_ = ''


--SE5 - Movimentacao Bancaria
Select E5_LA,  * From SE5010
Where E5_NUMERO In ('000001730') and E5_FORNECE = '009805' and D_E_L_E_T_ =''