-- Consultas Clientes, Fornecedores, Transportadoras e Produtos Bloqueados 
-- Bloqueio por tela - MSBLQL


-- Cadastro de Produtos
Select B1_RASTRO, B1_MSBLQL,* From SB1010
Where B1_COD In ('0660130502','0660130503') and D_E_L_E_T_=''

-- Cadastro de Produtos
Select B1_MSBLQL, COUNT(B1_COD) Total From SB1010
Where  D_E_L_E_T_=''
Group By B1_MSBLQL

Select B1_RASTRO, B1_MSBLQL,* From SB1010
Where B1_COD In ('0660130502','0660130503') and D_E_L_E_T_=''

--Clientes
Select * From SA1010
Select A1_MSBLQL, COUNT(A1_COD) Total From SA1010
Where  D_E_L_E_T_=''
Group By A1_MSBLQL

Select A1_MSBLQL, A1_RISCO, A1_SITUA, * From SA1010
Where A1_COD In ('0660130502','0660130503') and D_E_L_E_T_=''

-- Fornecedores 
Select A2_MSBLQL, COUNT(A2_COD) Total From SA2010
Where  D_E_L_E_T_=''
Group By A2_MSBLQL

Select A2_MSBLQL, A2_OK, A2_DATBLO, * From SA2010
Where A2_COD In ('0660130502','0660130503') and D_E_L_E_T_=''


-- Transportadoras  
Select A4_MSBLQL, COUNT(A4_COD) Total From SA4010
Where  D_E_L_E_T_=''
Group By A4_MSBLQL

Select A4_MSBLQL,* From SA4010