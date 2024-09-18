-- 17 - EIC
--SYQ - Vias de Transporte
Select * From SYQ010
Where YQ_VIA = '02' and D_E_L_E_T_ =''

--SYR - Taxas de Frete
Select * From SYR010
Where YR_VIA = '02' and YR_ORIGEM In ('TOR') and YR_DESTINO In ('GRU')
and D_E_L_E_T_ =''

--SY9 - Portos/Aeroportos - Origem e Destino
Select * From SY9010
Where Y9_COD In ('00097','41068') and D_E_L_E_T_ =''

--SYA - Paises - Pais Origem 
Select * From SYA010
Where YA_DESCR Like ('%TOR%') or YA_CODGI = '149' and D_E_L_E_T_ =''

--ELO - Cod.Pais Orig.Item Com.ISO3166
Select * From ELO010
Where ELO_DESC Like ('%TOR%') and D_E_L_E_T_ =''
