-- Saldos a produzir durante o m�s antes do fechamento mensal

SELECT D3_FILIAL, D3_COD, B1_DESC, D3_QUANT, D3_EMISSAO, D3_USUARIO, D3_TM, F5_TEXTO FROM SD3010
INNER JOIN SB1010 ON B1_COD=D3_COD AND SB1010.D_E_L_E_T_=''
INNER JOIN SF5010 ON F5_FILIAL=D3_FILIAL AND F5_CODIGO=D3_TM AND SF5010.D_E_L_E_T_=''
WHERE F5_TEXTO LIKE 'GERA SALDO'
  AND D3_ESTORNO=' '
  AND SD3010.D_E_L_E_T_=''
  AND SD3010.D_E_L_E_T_=''
  AND D3_EMISSAO BETWEEN '20230101' AND '20230131' --AND D3_FILIAL = 'FE01'
  ORDER BY D3_FILIAL

  --SD3 - Movimentacoes Internas
  Select * From SD3010
  Where D3_EMISSAO >= '20220808' and D3_TM In ('041','549')

  --SF5 - Tipos de Movimentacao
  --Select * From SF5010