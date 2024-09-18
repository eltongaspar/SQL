--Script de Conferência - Controle Multifilial
SELECT SC5.C5_FILIAL AS [FILORI],                                
SC5.C5_NUM AS [PEDORI],                                          
SC6.C6_PRODUTO AS [PRODUTO],                                     
SC6.C6_ACONDIC AS [ACONDIC],                                     
SC6.C6_LANCES AS [LANCES],                                       
SC6.C6_METRAGE AS [METRAGE],                                     
SUM(SC9.C9_QTDLIB) AS [QTD],                                     
SC6.R_E_C_N_O_ AS [SC6REC],									   
SC6.C6_LOCAL AS [LOCAL],                                         
SC6.C6_TES AS [TES],		                                       
SB1.B1_PESCOB AS [PESCOB],                                       
SC6.C6_ITEM AS [ITEM],	                                       
SC6.C6_PRCVEN AS [PRCVEN]	                                       
FROM SC5010 SC5                                                  
INNER JOIN SC6010 SC6 ON SC5.C5_FILIAL		= SC6.C6_FILIAL    
						AND SC5.C5_NUM		= SC6.C6_NUM           
						AND SC5.D_E_L_E_T_	= SC6.D_E_L_E_T_       
INNER JOIN SC9010 SC9 ON SC6.C6_FILIAL		= SC9.C9_FILIAL    
						AND SC6.C6_NUM		= SC9.C9_PEDIDO        
						AND SC6.C6_ITEM		= SC9.C9_ITEM          
						AND SC6.D_E_L_E_T_	= SC9.D_E_L_E_T_       
INNER JOIN SB1010 SB1 ON ''					= SB1.B1_FILIAL    
						AND SC6.C6_PRODUTO	= SB1.B1_COD           
						AND SC6.D_E_L_E_T_	= SB1.D_E_L_E_T_       
INNER JOIN SF4010 SF4 ON ''					= SF4.F4_FILIAL    
						AND SC6.C6_TES		= SF4.F4_CODIGO        
						AND SC6.D_E_L_E_T_	= SF4.D_E_L_E_T_       
WHERE SC5.C5_FILIAL = '01'
AND SC5.C5_NUM = '398596'
AND SF4.F4_ESTOQUE = 'S'                                         
AND SB1.B1_TIPO = 'PA'                                           
AND SC9.C9_BLCRED = ''                                           
AND SC9.C9_BLEST  = '02'                                         
AND SC5.D_E_L_E_T_ = ''                                          
GROUP BY SC5.C5_FILIAL,SC5.C5_NUM,SC6.C6_PRODUTO,SC6.C6_ACONDIC, 
SC6.C6_LANCES, SC6.C6_METRAGE,SC6.R_E_C_N_O_, SC6.C6_LOCAL, 	   
SC6.C6_TES, SB1.B1_PESCOB, SC6.C6_ITEM, SC6.C6_PRCVEN			   

