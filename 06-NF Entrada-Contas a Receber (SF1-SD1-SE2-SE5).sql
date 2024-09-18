-- NF de Entrada - cabeçalho
Select * From SF1010
Where F1_FILIAL = 'BA12' and F1_DOC = '000000003' and D_E_L_E_T_ ='' and F1_FORNECE = '005922'

-- NF de Entrada - itens 
Select * From SD1010 
Where D1_FILIAL = 'BA12' and D1_DOC = '000000003' and D_E_L_E_T_ = '' and D1_FORNECE = '005922'

-- Consulta Fornecedor
Select * From SA2010
Where A2_COD = '005922' and A2_LOJA = '01' and D_E_L_E_T_=''

--SE2 - Contas a Pagar
Select E2_LA, * From SE2010
Where E2_NUM In ('000000003') and E2_FILIAL = 'BA' and E2_PREFIXO = '' and E2_FILORIG = 'BA12' and E2_FORNECE = '005922' and D_E_L_E_T_ = ''

--SE5 - Movimentacao Bancaria
Select E5_LA,  * From SE5010
Where E5_NUMERO In ('000000003') and E5_FILORIG = 'BA12' and E5_FORNECE = '005922' and D_E_L_E_T_ =''

--CT2 - Lancamentos Contabeis
Select CT2_DOC, CT2_LINHA, CT2_VALOR, CT2_HIST, * From CT2010
Where CT2_FILIAL = 'BA12' and CT2_DOC = '000003' and D_E_L_E_T_ = ''


