--Controle Requisito Ensaio     
SELECT QPS_MEDICA,*

FROM QPR010 QPR

INNER JOIN QPS010 QPS ON QPS_FILIAL = QPR_FILIAL AND QPS_CODMED = QPR_CHAVE AND QPS.D_E_L_E_T_ = ''

INNER JOIN SB8010 SB8  ON B8_FILIAL = QPR_FILIAL AND B8_PRODUTO = QPR_PRODUT AND B8_LOTECTL = SUBSTRING(QPR_LOTE,1,10) 

AND B8_SALDO > 0 AND SB8.D_E_L_E_T_ = ''

WHERE 1=1

  AND QPR_FILIAL = 'BA01'

  AND QPR_PRODUT = '0110010221'

  AND QPR_ENSAIO = 'SOC00052'

  AND QPR.D_E_L_E_T_ <> '*'

  ORDER BY SUBSTRING(QPR_LOTE,1,10) 

  --Parametro Controle de Requisitos
  --Select * From SX6010
  --Where X6_VAR = 'ZZ_MTA455M'

 --Controle Requisito Ensaio     
-- Select * From ZZY010

  --Tabelas 
 -- Select * From SX2010
  --Where X2_CHAVE = 'ZZY'