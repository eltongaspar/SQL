-- Alteracao ISS de NF e Titulos a pagar
-- NF Cabeçaho e Itens
-- Contas a Pagar
-- Mov. Bancaria, caso titulo tenha Saldo diferente <> do Valor Original

--NF Entrada Cab.
Select F1_ISS,F1_RECISS, F1_INCISS, F1_DTCPISS, * From SF1010
Where F1_FILIAL = 'BA14' and F1_DOC = '000000071' and D_E_L_E_T_='' and F1_EMISSAO >= '20221201'

--SF1 - NF Entrada Cabeçalho 
--F1_ISS- Valor do ISS ***
--F1_RECISS - Recolhe ISS ? 1-Sim/2-Não
--F1_INCISS - Munic. de Incid. do ISS
--F1_DTCPISS - Desc. Data Competencia

--NF Entrada Itens
Select D1_NFORI,D1_DOC,D1_BASEISS,D1_ALIQISS,D1_VALISS,D1_CODISS,D1_ABATISS,   * From SD1010
Where D1_FILIAL ='BA14' and D1_DOC ='000000071' and D_E_L_E_T_ ='' and D1_EMISSAO >= '20221201'

--SD1 - NF Entrada Itens 
--D1_BASEISS - Base de calculo do ISS ***
--D1_ALIQISS - Aliquota de ISS ***
--D1_VALISS - Valor do ISS ***
--D1 _CODISS - Codigo de Servico do ISS
--D1_ABATISS - Valor abatimento / ISS



--SE2 - Contas a Pagar
Select E2_FILORIG,E2_SALDO,E2_VALOR,E2_VLCRUZ,E2_BAIXA,E2_ISS,E2_PARCISS,E2_VRETISS,E2_VENCISS,E2_VBASISS,E2_MDRTISS,
E2_MDRTISS,E2_FRETISS,E2_TRETISS,E2_BASEISS,E2_PRISS,E2_BTRISS,E2_VRETBIS, * From SE2010
Where E2_FILORIG In ('BA14') and E2_NUM In ('000000071') and D_E_L_E_T_ = '' 
and E2_EMISSAO >= '20221201'


/*SE2 - Contas a pagar 
E2_SALDO - Saldo a Receber ***
E2_VALOR - Valor do Titulo ***
E2_VLCRUZ - Valor na moeda nacional ***
E2_BAIXA - Data de Baixa do Titulo *** 
E2_ISS - Valor do ISS ***
E2_PARCISS - Parcela do ISS ***
E2_VRETISS - Valor Retido - ISS ***
E2_VENCISS - Vencimento ISS
E2_VBASISS - Valor Acumulado Servicos
E2_MDRTISS - Modo de Retencao de ISS
E2_FRETISS - Forma de retencao do ISS	
E2_TRETISS - Retencao do ISS
E2_BASEISS - Base ISS	***
E2_PRISS - Provisao de - ISS
E2_BTRISS - Bitributacao do ISS CPOM
E2_VRETBIS - Vlr. Retencao ISS Bitrib.*/




--SE5 - Movimentacao Bancaria
Select E5_FILORIG,E5_HISTOR,E5_NUMERO,E5_VRETISS,E5_PRISS, * From SE5010
Where E5_FILORIG ='BA14'  and E5_NUMERO In ('000000071') and D_E_L_E_T_ = ''
and E5_DTDIGIT >= '20221201'

--SE5 - Movimentação Bancária 
--E5_VRETISS - Valor Retido ISS
--E5_PRISS - Provisao de - ISS



--Livro Fiscal SF3
Select F3_EMISSAO, F3_CHVNFE, * From SF3010
Where F3_FILIAL ='BA14' and F3_NFISCAL ='000000071' and F3_ENTRADA >= '20221201' and D_E_L_E_T_=''

--Livro Fiscal Itens SFT
Select FT_EMISSAO, FT_CHVNFE, * From SFT010
Where FT_FILIAL ='BA14' and FT_NFISCAL ='000000071' and FT_ENTRADA >= '20221201'  and D_E_L_E_T_=''