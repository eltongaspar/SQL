SELECT 
    D2_FILIAL, 
	D2_CLIENTE, 
	A1_NOME, 
	SUM(D2_TOTAL) TOTAL
	                                                                                                                                                                                                                           
FROM 
    SD2010 

	INNER JOIN SA1010 SA1 WITH (NOLOCK)
	ON A1_FILIAL= ' '
	AND A1_COD=D2_CLIENTE
	AND	A1_LOJA=D2_LOJA
	AND SA1.D_E_L_E_T_=''
		
	INNER JOIN SF4010 SF4 WITH (NOLOCK)
	ON F4_FILIAL = ' '
	AND F4_CODIGO=D2_TES
	AND F4_DUPLIC='S'
	AND SF4.D_E_L_E_T_=''
	
WHERE 
        SD2010.D_E_L_E_T_='' 
	AND D2_EMISSAO BETWEEN '20180501' AND '20190430'
	AND D2_FILIAL IN ('BA06')
	AND D2_TIPO IN ('N','C')
	AND D2_EST NOT IN ('EX')

GROUP BY
    D2_FILIAL, 
	D2_CLIENTE, 
	A1_NOME

ORDER BY
	D2_FILIAL,
	TOTAL DESC

