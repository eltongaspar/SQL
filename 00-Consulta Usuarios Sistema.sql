Select * From SYS_USR
-- Consulta usu�rio
Select USR_NOME, USR_EMAIL, USR_TIMEOUT, * From SYS_USR
Where USR_CODIGO Like  'wellington%'


-- Consulta Usu�rio Timeout
Select USR_NOME, USR_EMAIL, USR_TIMEOUT, * From SYS_USR
Where USR_TIMEOUT >'0' and USR_MSBLQD = '' and D_E_L_E_T_ = ''