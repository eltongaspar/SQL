Select * From MPMENU_FUNCTION


	Left Join MPMENU_I18N I18N
	On N_PAREN_ID = F_ID

Where F_FUNCTION In ('FINA050','MATA100','FINA565','MATA460A')

Order By F_FUNCTION


--Parte 1
/*Filtro ID menu ( M_ID ) */
SELECT * FROM MPMENU_MENU MPN WHERE M_NAME LIKE '%SIGACOM%'

--Parte 2

 SELECT
 M_ID, I_ID, I_TP_MENU, I_ITEMID, I_FATHER, F_FUNCTION, I_STATUS, I_ORDER, I_TABLES, I_ACCESS, I_DEFAULT, I_RESNAME, I_TYPE, I_OWNER, F_DEFAULT
 , I_MODULE, I18N1.N_DESC N_PT, I18N2.N_DESC N_ES, I18N3.N_DESC N_EN, KW1.K_DESC K_PT, KW2.K_DESC K_ES, KW3.K_DESC K_EN
 FROM MPMENU_MENU MPN
 INNER JOIN MPMENU_ITEM MPI ON I_ID_MENU = M_ID AND MPI.D_E_L_E_T_ = ' '
 LEFT JOIN MPMENU_FUNCTION MPF ON F_ID = I_ID_FUNC AND MPF.D_E_L_E_T_ = ' '
 INNER JOIN MPMENU_I18N I18N1 ON I18N1.N_PAREN_ID = I_ID AND I18N1.N_LANG = '1' AND I18N1.D_E_L_E_T_ = ' '
 INNER JOIN MPMENU_I18N I18N2 ON I18N2.N_PAREN_ID = I_ID AND I18N2.N_LANG = '2' AND I18N2.D_E_L_E_T_ = ' '
 INNER JOIN MPMENU_I18N I18N3 ON I18N3.N_PAREN_ID = I_ID AND I18N3.N_LANG = '3' AND I18N3.D_E_L_E_T_ = ' '
 LEFT JOIN MPMENU_KEY_WORDS KW1 ON KW1.K_ID_ITEM = I_ID AND KW1.K_LANG = '1' AND KW1.D_E_L_E_T_ = ' '
 LEFT JOIN MPMENU_KEY_WORDS KW2 ON KW2.K_ID_ITEM = I_ID AND KW2.K_LANG = '2' AND KW2.D_E_L_E_T_ = ' '
 LEFT JOIN MPMENU_KEY_WORDS KW3 ON KW3.K_ID_ITEM = I_ID AND KW3.K_LANG = '3' AND KW3.D_E_L_E_T_ = ' '
 WHERE
 F_FUNCTION In ('FINA050','MATA100','FINA565','MATA460A') AND MPN.D_E_L_E_T_ = ' ' 
 ORDER  BY I_ORDER

