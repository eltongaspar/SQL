/*==============================================================
 Consulta de Parâmetros por Ambiente (Empresa)

 Objetivo:
 Verificar a configuração dos parâmetros MV_CSTGXML e MV_RTC55
 em todas as empresas do ambiente Protheus.

 Parâmetros analisados:
 - MV_CSTGXML : Tratamento de CST conforme XML da NF-e.
 - MV_RTC55   : Configurações relacionadas à NF-e modelo 55.

 Tabelas consultadas:
 - SX6010 = Empresa 01
 - SX6020 = Empresa 02
 - SX6030 = Empresa 03
 - SX6040 = Empresa 04
 - SX6050 = Empresa 05

 Observação:
 UNION ALL é utilizado para retornar todos os registros de
 todas as empresas sem eliminar duplicidades.
==============================================================*/

-- Empresa 01
SELECT *
FROM SX6010
WHERE X6_VAR IN ('MV_CSTGXML', 'MV_RTC55')

UNION ALL

-- Empresa 02
SELECT *
FROM SX6020
WHERE X6_VAR IN ('MV_CSTGXML', 'MV_RTC55')

UNION ALL

-- Empresa 03
SELECT *
FROM SX6030
WHERE X6_VAR IN ('MV_CSTGXML', 'MV_RTC55')

UNION ALL

-- Empresa 04
SELECT *
FROM SX6040
WHERE X6_VAR IN ('MV_CSTGXML', 'MV_RTC55')

UNION ALL

-- Empresa 05
SELECT *
FROM SX6050
WHERE X6_VAR IN ('MV_CSTGXML', 'MV_RTC55');

/*
Resultado esperado:
- Identificar em quais empresas os parâmetros existem.
- Conferir os respectivos valores configurados.
- Validar divergências entre filiais/empresas.
- Apoiar auditorias fiscais e diagnósticos de NF-e.
*/