--SAJ - Grupos de Compras
Select * From SAJ010
Where AJ_USER In ('000847','000678','000670','000523','000677') and D_E_L_E_T_ =''
Order By AJ_USER

--SAJ - Grupos de Compras - Validação 
Select Count (AJ_USER) Total, AJ_US2NAME From SAJ010
Where AJ_USER In ('000847','000678','000670','000523','000677') and D_E_L_E_T_ =''
Group By AJ_US2NAME


--SY1 - Compradores
Select * From SY1010
Where Y1_USER In ('000847','000678','000670','000523','000677') and D_E_L_E_T_ =''
Order By Y1_USER

-- Aprovadores
Select * From SAK010
Where AK_USER In ('000847','000599') and D_E_L_E_T_=''


-- Grupo de Aprovaodres 
Select * From SAL010
Where AL_FILIAL In ('FA03') and AL_USER In ('000847','000599')


--Usuários
Select * From SYS_USR
Where USR_CODIGO Like '%maria%'and D_E_L_E_T_=''


--CADASTRO DE SOLICITANTES
Select * From SAI010
Where AI_FILIAL In ('FA03') and AI_USER In ('000530') and D_E_L_E_T_=''

-- Cadastro de Produtos
Select B1_RASTRO, B1_GRUPO,* From SB1010
Where B1_COD In ('0200500001','0200500002') and D_E_L_E_T_=''

-- Grup de produtos 
Select BM_ZZMSG,* From SBM010
Where BM_GRUPO In ('1001')And D_E_L_E_T_ =''

