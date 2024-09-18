-- SE2 - Contas a Pagar
Select E2_FORNECE, E2_LOJA, E2_NUM, E2_VALOR, * From SE2010
Where E2_FILORIG = 'FJ01' and E2_NUM = '291021' and E2_FORNECE = '000406'

--SE5 - Movimentacao Bancaria
Select E5_FORNECE, E5_LOJA, E5_CLIFOR, E5_NUMERO, * From SE5010
Where E5_FILIAL = 'FJ' and E5_NUMERO = '291021' 
and E5_FORNECE = '000406'