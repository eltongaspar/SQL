--  SYS_USR - Tabelas de usuários do sistema
--SYS_USR_MODULE -  Tabelas de acessos módulos dos usuários 
-- SYS_USR_ACCESS - Tabelas de codigo de acesso dos usuários

-- Consulta acessos a modulos dos usuários 
Select USR_ID From SYS_USR_MODULE 
Where USR_MODULO in ('94','95') and D_E_L_E_T_=''
Group By USR_ID

Select * From SYS_USR_MODULE 

-- Consultas usuários do sistema
Select * From SYS_USR
Where USR_MSBLQL = '2'


--Consulta codigo de acesso dos usuários
Select * From SYS_USR_ACCESS


-- Scritp para verificar acessos a módulos 
-- Cruzando Tabelas SYS_USR com SYS_USR_MODULO
Select Distinct SYS_USR.USR_ID ID,
	           SYS_USR.USR_CODIGO CODIGO,
			   SYS_USR.USR_NOME NOME
From SYS_USR_MODULE, SYS_USR

	Inner Join SYS_USR_MODULE USR_MOD WITH (NOLOCK)
	ON USR_MOD.USR_ID = SYS_USR.USR_ID

Where USR_MOD.USR_MODULO in ('94','95') and SYS_USR.D_E_L_E_T_='' and SYS_USR.USR_MSBLQL = '2'


-- Qtde de Filiais por usuario 
SELECT DISTINCT
	F.USR_CODEMP EMPRESA
	FROM SYS_USR U
INNER JOIN SYS_USR_MODULE M ON M.USR_ID=U.USR_ID AND M.USR_ACESSO='T' AND M.D_E_L_E_T_=''
LEFT JOIN MPMENU_MENU MENU ON MENU.M_ID = M.USR_ARQMENU AND MENU.D_E_L_E_T_=''
LEFT JOIN MPMENU_ITEM ITEM ON MENU.M_ID = ITEM.I_ID_MENU AND ITEM.D_E_L_E_T_=''
LEFT JOIN MPMENU_FUNCTION FUNC ON FUNC.F_ID = ITEM.I_ID_FUNC AND ITEM.D_E_L_E_T_=''
LEFT JOIN SYS_USR_FILIAL F ON F.USR_ID=U.USR_ID AND F.USR_ACESSO='T' AND F.D_E_L_E_T_=''
WHERE U.USR_MSBLQL='2' AND U.D_E_L_E_T_=''  
AND F_FUNCTION IS NOT NULL
AND U.USR_CODIGO='elton.moura'
ORDER BY 1

SELECT * FROM SYS_USR_FILIAL WHERE USR_ID='000087'