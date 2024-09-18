-- Ajustes Caasas Decimais SB2 
-- Rotina GeraFatur - Personalizado

SELECT *

--UPDATE SB2010 SET B2_VATU1 = 0, B2_CM1 = 0

--UPDATE SB2010 SET B2_VATU2 = 0, B2_CM2 = 0, B2_VATU3 = 0, B2_CM3 = 0,B2_VATU4 = 0, B2_CM4 = 0, B2_VATU5 = 0, B2_CM5 = 0

FROM SB2010

WHERE B2_FILIAL  = '03'

AND B2_LOCAL = '01'

AND D_E_L_E_T_ = ''