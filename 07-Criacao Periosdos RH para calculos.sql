
-- Criação de perídos para calculos RH

-- Tabela Periodos (RH)
Select * From RCF010
Where RCF_FILIAL = 'BA15'

-- Tabela Periodo de Calculo (RH)
Select * From RCH010
Where RCH_FILIAL = 'BA15'

-- Cadastros de Periodos (RH)
Select * From RFQ010
Where RFQ_FILIAL = 'BA15'

-- Parametros 
Select * From SX6010
Where X6_FIL = 'BA15' and X6_VAR In ('MV_PAPONTA')

--SP9 - EVENTOS
Select * From SP9010
Where P9_FILIAL = 'BA15'

--SP4 - TIPO DE HORA EXTRA
Select * From SP4010
Where P4_FILIAL = 'BA15'

--SR6 - TURNO
Select * From SR6010
Where R6_FILIAL = 'BA15'

--SPJ - HORARIO PADRAO
Select * From SPJ010
Where PJ_FILIAL = 'BA15'