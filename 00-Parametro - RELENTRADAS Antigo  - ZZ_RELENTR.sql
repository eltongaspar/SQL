--Usuarios que enxergam versao velha do RELENTRADAS 
--Tabela Parametros
Select * From SX6010
Where X6_VAR In ('ZZ_RELENTR')

-- Consulta usuário
Select USR_NOME, USR_EMAIL, USR_TIMEOUT, * From SYS_USR
Where USR_CODIGO Like  'wellington%'
