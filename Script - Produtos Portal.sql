
--Script para analise de Produtos duplicados no Portal 
-- Especialidade + Cor
SELECT DISTINCT Z4_COD    AS 	ID, 	
Z4_DETALHE				  AS	TEXT 		
FROM SB1010 SB1 -- Produtos		
INNER JOIN SZ4010 SZ4 -- Especialidade	
ON B1_FILIAL			= Z4_FILIAL 	
AND B1_ESPECIA			= Z4_COD 			
AND SB1.D_E_L_E_T_	= SZ4.D_E_L_E_T_ 	
INNER JOIN SZ3010 SZ3 -- Cor 
ON B1_FILIAL			= Z3_FILIAL  		
AND B1_COR				= Z3_COD  		
AND SB1.D_E_L_E_T_	= SZ3.D_E_L_E_T_ 
WHERE
B1_FILIAL				= '' 	
AND B1_COD	LIKE '11505%' -- Especialidade + Cor
AND B1_XPORTAL IN ('S','E') -- Ativo no Portal Produto - S-Sim E-Especial N-Não
AND Z3_XPORTAL IN ('S','E') -- Ativo no Portal - Cor - S-Sim E-Especial N-Não
AND B1_MSBLQL			<> '1' 	--Produto Bloqueado = 1-Bloqueado / 2- Não Bloqueado			
AND SB1.D_E_L_E_T_	= '' 		
ORDER BY Z4_COD 	

--Script  2 

SELECT 
    B1_COD,B1_DESC,B1_ROLO,B1_BOBINA,B1_XPORTAL,*,
	SUBSTRING(B1_COD, 8, 1) AS CLASSE
FROM 
    SB1010 SB1
WHERE
    B1_FILIAL = ''
    AND B1_COD LIKE '1150505%'
    AND B1_ESPECIA = '01'
    AND B1_XPORTAL IN ('S', 'E')
    AND B1_MSBLQL <> '1'
    AND SB1.D_E_L_E_T_ = ''
ORDER BY 
    B1_CLASENC DESC
