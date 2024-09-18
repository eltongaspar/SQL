--Limites de Aprovação Resina 
-- Andre é limite Mensal (SAK_TIPO 'M')
SELECT *, Round((VLR_TOTAL - VR_RESIDUO - VR_LIBERADO),2) VR_SALDO   FROM (																
SELECT 																																	
C7_FILIAL  EMP_COMPRA,SYS.M0_FILIAL EMPRESA,																								
Round(SUM(C7_TOTAL),2) VLR_TOTAL,																										
Round(SUM(CASE WHEN C7_CONAPRO = 'B' THEN (C7_QUANT-C7_QUJE)*C7_PRECO ELSE  '' END),2) AS VR_BLOQUEADO,									
Round(SUM(CASE WHEN C7_RESIDUO = 'S' THEN (C7_QUANT-C7_QUJE)*C7_PRECO ELSE  '' END),2) AS VR_RESIDUO,									
Round(SUM(CASE WHEN C7_CONAPRO = 'L' THEN (C7_QUANT-C7_QUJE)*C7_PRECO ELSE  '' END),2) AS VR_LIBERADO,									
Round(SUM(CASE WHEN C7_RESIDUO = 'S' THEN (C7_QUANT-(C7_QUANT-C7_QUJE)) WHEN C7_RESIDUO = ' ' THEN C7_QUANT END),2) AS SALDO_COMPRA		
FROM SC7010 SC7 WITH (NOLOCK)																											
INNER JOIN SYS_COMPANY SYS (NOLOCK) ON M0_CODFIL=C7_FILIAL AND SYS.D_E_L_E_T_= ' '														
INNER JOIN SA2010 SA2 (NOLOCK) ON A2_COD=C7_FORNECE AND A2_LOJA=C7_LOJA AND SA2.D_E_L_E_T_=''											
INNER JOIN SB1010 SB1 (NOLOCK) ON B1_COD=C7_PRODUTO AND SB1.D_E_L_E_T_=''																
INNER JOIN SE4010 SE4 (NOLOCK) ON E4_CODIGO=C7_COND AND SE4.D_E_L_E_T_=''																
INNER JOIN SED010 SED (NOLOCK) ON ED_CODIGO=A2_NATUREZ AND SED.D_E_L_E_T_=''																
																																			
WHERE C7_APROV = '000050' AND SC7.D_E_L_E_T_=' '																							
  AND C7_EMISSAO BETWEEN '20220801' AND '20220831'																							
  GROUP BY C7_FILIAL,M0_FILIAL																											
  ) TMP																																	
ORDER BY 1,2	