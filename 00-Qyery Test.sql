SELECT  
    '  + cPedido +  '                          AS PEDIDO, 
     (ZP6.ZP6_NOME + ZP6.ZP6_BITOLA)           AS PRODUTO,  
     SZ1.Z1_DESC                               AS FAMILIA_PRODUTO,  
     SZ2.Z2_DESC                               AS BITOLA_PRODUTO,  
     Sum(Distinct ZP6.ZP6_PRCTAB)              AS PRECO_TABELA,  
     Sum(Distinct ZP6.ZP6_PRCSUG)              AS PRECO_SUGERIDO,  
     Sum(Distinct ZP6.ZP6_PRCAPR)              AS PRECO_APROVADO,  
     Sum(Distinct ZP6.ZP6_PRCSUG) - AVG(ZP6_PRCAPR)     AS DIF_SUG_APROVADO,  
     CASE  
     WHEN SUM(ZP6.ZP6_TOTSUG) > 0  
     THEN  
      ((SUM(ZP6.ZP6_TOTSUG * 100) /  SUM(((ZP6.ZP6_TOTSUG * 100) / (ZP6.ZP6_RGSUG + 100)))  ) - 100)  
      ELSE 0  
     END AS RG_SUGERIDO,  
       CASE  
     WHEN SUM(ZP6.ZP6_TOTAPR) > 0  
     THEN  
     ((SUM(ZP6.ZP6_TOTAPR * 100) /  SUM(((ZP6.ZP6_TOTAPR * 100) / (ZP6.ZP6_RGAPR + 100)))  ) - 100)   
     ELSE 0  
     END AS RG_APROVADO,  
     
	 SUM(DISTINCT ZP6.ZP6_TOTSUG)                       AS TOTAL_SUGERIDO,  
     SUM(DISTINCT ZP6.ZP6_TOTAPR)                       AS TOTAL_APROVADO,  

     Sum(Distinct SB1.B1_PESCOB)                        AS PESO_COBRE,  
     SUM(ZP9.ZP9_QUANT * ZP6.ZP6_QTACON)				AS QTD_VENDIDA,  
     Sum(Distinct SB1.B1_PESCOB) * SUM(ZP9.ZP9_QUANT * ZP6.ZP6_QTACON)  AS TOTAL_COBRE  
     
	 FROM ZP6010 ZP6  
     INNER JOIN SZ1010 SZ1 ON '' = SZ1.Z1_FILIAL AND ZP6.ZP6_NOME = SZ1.Z1_COD AND ZP6.D_E_L_E_T_ = SZ1.D_E_L_E_T_  
     INNER JOIN SZ2010 SZ2 ON '' = SZ2.Z2_FILIAL AND ZP6.ZP6_BITOLA = SZ2.Z2_COD AND ZP6.D_E_L_E_T_ = SZ2.D_E_L_E_T_  
     INNER JOIN ZP9010 ZP9 ON      ZP6.ZP6_FILIAL = ZP9.ZP9_FILIAL AND ZP6.ZP6_NUM = ZP9.ZP9_NUM AND ZP6.ZP6_ITEM = ZP9.ZP9_ITEM AND ZP6.D_E_L_E_T_ = ZP9.D_E_L_E_T_  
     INNER JOIN SB1010 SB1 ON '' = SB1.B1_FILIAL AND SB1.B1_COD = ZP9.ZP9_CODPRO AND ZP9.D_E_L_E_T_ = SB1.D_E_L_E_T_   
     WHERE ZP6.ZP6_NUM = '358260' 
     AND SZ1.D_E_L_E_T_ = '' 
     GROUP BY (ZP6.ZP6_NOME + ZP6.ZP6_BITOLA), SZ1.Z1_DESC, SZ2.Z2_DESC, SUBSTRING(SB1.B1_COD, 1,5) 
