--ajuste na tela de pedido de compras para o nome do centro de custo e nome da conta contabil

UPDATE
SC7010 SET C7_ZZCCDES = CTT_DESC01 FROM SC7010 SC7 
INNER JOIN CTT010 CTT ON CTT_FILIAL = C7_FILIAL AND CTT_CUSTO =  C7_CC AND CTT.D_E_L_E_T_ = ''
WHERE
SC7.D_E_L_E_T_ = ''

UPDATE
SC7010 SET C7_ZZCTDES = CT1_DESC01 FROM SC7010 SC7 
INNER JOIN CT1010 CT1 ON CT1_CONTA =  C7_CONTA AND CT1.D_E_L_E_T_ = ''
WHERE
SC7.D_E_L_E_T_ = ''