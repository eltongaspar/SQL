--Conta Contabil 
Select * From CT1010
Where CT1_CONTA = ('1103010001') and D_E_L_E_T_ =''

-- Compradores 
Select * From SY1010
Where Y1_USER = '000836'

--Centro de custos
Select * From CTT010
Where CTT_CUSTO In ('509700') and D_E_L_E_T_ =''

--Grupo de Aprovacao 
Select * From SAL010 
Where AL_FILIAL = 'BA03'  and D_E_L_E_T_ =''

--DBL - Entidades Contabeis X Grp Apr
Select * From DBL010
Where DBL_CC In ('900418') and D_E_L_E_T_ =''

Select * From DBL010
Where DBL_FILIAL In ('BA03') and D_E_L_E_T_ =''


--User
Select * From SYS_USR 
Where USR_ID In ('000599')

Select * From SYS_USR 
Where USR_CODIGO Like ('%dias%')