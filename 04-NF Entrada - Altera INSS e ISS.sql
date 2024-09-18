--SE2 - Contas a Pagar
Select E2_BASEINS,E2_INSS,E2_VRETINS,E2_PARCINS,E2_TITINS,E2_INSSRET,E2_BASEISS,E2_PRETINS,E2_PRINSS,E2_RETINS,E2_ISS,E2_PARCISS,E2_FORNISS,E2_LOJAISS,E2_VENCISS,E2_VBASISS,E2_MDRTISS,E2_FRETISS,E2_TRETISS,E2_CODISS,E2_PRISS,E2_BTRISS,E2_LA, E2_SALDO, E2_VALOR,E2_VLCRUZ,E2_BASECOF,E2_BASEPIS,E2_BASECSL,E2_BASEINS,E2_BASEIRF,E2_BASEISS, * From SE2010
Where E2_FILORIG= 'EC01' and E2_NUM In ('000000640','000000647') and D_E_L_E_T_ = '' 
and E2_FORNECE = '000675'

--NF Entrada Cab.
Select F1_INSS,F1_BASEINS,F1_ISS,F1_RECISS,F1_INCISS,F1_DTCPISS,D_E_L_E_T_,F1_EMISSAO, F1_DTLANC, * From SF1010
Where F1_FILIAL = 'EC01' and F1_DOC In ('000000640','000000647') and D_E_L_E_T_='' and F1_EMISSAO >= '20220101'
and F1_FORNECE = '000675'

--NF Entrada Itens
Select D1_BASEINS,D1_VALINS,D1_BASEISS,D1_ALIQISS,D1_VALISS,D1_CODISS,D1_ABATISS,D1_ABATINS,D_E_L_E_T_,D1_EMISSAO,D1_NFORI, D1_CC,D1_DOC, * From SD1010
Where D1_FILIAL ='EC01' and D1_DOC In ('000000640','000000647') and D_E_L_E_T_ ='' and D1_EMISSAO >= '20220101'
and D1_FORNECE = '000675'