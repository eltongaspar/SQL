SELECT
	U.USR_ID ID_USUARIO, 
	U.USR_CODIGO COD_USUARIO, 
	U.USR_NOME NOME_USUARIO ,
	F.USR_GRPEMP GRUPO_EMPRESAS,
	F.USR_CODEMP EMPRESA,
	F.USR_FILIAL FILIAL,
	CASE WHEN U.USR_ALLEMP  ='1' THEN 'SIM' ELSE 'NAO' END TODAS_EMPRESAS,
	M.USR_MODULO CODIGO_MODULO,
	M.USR_CODMOD NOME_MODULO,
	MENU.M_NAME,
	F_FUNCTION
FROM SYS_USR U
INNER JOIN SYS_USR_MODULE M ON M.USR_ID=U.USR_ID AND M.USR_ACESSO='T' AND M.D_E_L_E_T_=''
LEFT JOIN MPMENU_MENU MENU ON MENU.M_ID = M.USR_ARQMENU AND MENU.D_E_L_E_T_=''
LEFT JOIN MPMENU_ITEM ITEM ON MENU.M_ID = ITEM.I_ID_MENU AND ITEM.D_E_L_E_T_=''
LEFT JOIN MPMENU_FUNCTION FUNC ON FUNC.F_ID = ITEM.I_ID_FUNC AND ITEM.D_E_L_E_T_=''
LEFT JOIN SYS_USR_FILIAL F ON F.USR_ID=U.USR_ID AND F.USR_ACESSO='T' AND F.D_E_L_E_T_=''
WHERE U.USR_MSBLQL='2' AND U.D_E_L_E_T_=''  
--AND U.USR_ALLEMP <> '1' AND F.USR_FILIAL LIKE 'AD%'
AND F_FUNCTION IS NOT NULL
AND F_FUNCTION = 'CTBA390'
--AND MENU.M_NAME='MENUSPERSONALIZADOSRBEST_NOVO_DASH'
ORDER BY 1

       