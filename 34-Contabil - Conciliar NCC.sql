
--SE2 - Contas a Pagar
Select E2_LA, * From SE2010
Where E2_FILORIG= 'BA01' and E2_NUM In ('000072417') and D_E_L_E_T_ = ''
--and E2_FORNECE

--SE5 - Movimentacao Bancaria
Select E5_LA, E5_DATA,E5_DTDIGIT, E5_DTDISPO, E5_VALOR, E5_HISTOR, * From SE5010
Where E5_FILORIG ='BA01'  and E5_NUMERO In ('000072417') and D_E_L_E_T_=''

--SE5 - Movimentacao Bancaria - Achar o titulo NCC
--Obs: A composição do Numero do NCC (Nota Credito do cliente) está no campo E5_Documen do Titulo a pagar original
--Titulo original BA01 Num -000072417 Campo E5_Document = '2  000151431001NCC01'
-- Numero do NCC na SE5 fica E5_Num = 000151431 (Retira os caracteres '2' e os '001NCC01'
-- Limpar Flags Titulo Original e NCC E5_LA = ''
-- Ordenar select por R_E_C_N_O_ e limpar o de valor maior
SELECT E5_LA,* FROM SE5010 
WHERE E5_NUMERO='000151431' AND D_E_L_E_T_='' 
ORDER BY R_E_C_N_O_

--SE1 - Contas a Receber
Select E1_LA,E1_VALOR, E1_HIST, * From SE1010
Where E1_FILORIG= 'BA01' and E1_NUM In ('000072417') and D_E_L_E_T_ = ''


--Pesquisa NF Entrada e Saida*******
--NF Ent Cab.
Select D_E_L_E_T_,F1_DTLANC,F1_EMISSAO,* From SF1010
Where F1_DOC ='000072417' and D_E_L_E_T_='' and F1_DTDIGIT >= '20220302'
--F1_FILIAL ='BA01' and F1_DOC ='000072417 ' and D_E_L_E_T_='' and F1_DTDIGIT >= '20220302'

--NF Saida Cab. DT_LANC = 20220309
Select D_E_L_E_T_,F2_EMISSAO, F2_DTLANC, * From SF2010
Where F2_DOC ='000072417' 
--F2_FILIAL ='BA01' and F2_DOC ='000072417' 

--NF Saida Itens
Select D_E_L_E_T_, D2_EMISSAO, * From SD2010
Where D2_DOC ='000072417' and D_E_L_E_T_=''