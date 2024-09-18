-- NF de Saida - cabeçalho
Select * From SF2010
Where F2_FILIAL = 'BA12' and F2_DOC = '000000003' and D_E_L_E_T_ ='' and F2_CLIENTE = '005922'

-- NF de Saida - itens 
Select * From SD2010 
Where D2_FILIAL = 'BA12' and D2_DOC = '000000003' and D_E_L_E_T_ = '' and D2_CLIENTE = '005922'

-- Consulta Cliente
Select * From SA1010
Where A1_COD = '005922' and A1_LOJA = '01' and D_E_L_E_T_=''

--SE1 - Contas a receber
Select E1_LA, * From SE1010
Where E1_NUM In ('000000003') and E1_FILIAL = 'BA' and E1_PREFIXO = '' and E1_FILORIG = 'BA12' and E1_CLIENTE = '005922' and D_E_L_E_T_ = ''

--SE5 - Movimentacao Bancaria
Select E5_LA,  * From SE5010
Where E5_NUMERO In ('000000003') and E5_FILORIG = 'BA12' and E5_FORNECE = '005922' and D_E_L_E_T_ =''

--CT2 - Lancamentos Contabeis
Select CT2_DOC, CT2_LINHA, CT2_VALOR, CT2_HIST, * From CT2010
Where CT2_FILIAL = 'BA12' and CT2_DOC = '000003' and D_E_L_E_T_ = ''


