--SRD - Historico de Movimentos
Select Distinct RA_FILIAL, M0_FILIAL, RA_MAT, RA_NOME, RD_VALOR, RV_COD, RV_DESC, RY_CALCULO, RY_DESC,CTT_CUSTO, CTT_DESC01, RD_HORAS,
RD_DATARQ, RD_DATPGT
From SRD010 SRD
	
	Inner Join SYS_COMPANY COM With (Nolock)
	ON M0_CODFIL = RD_FILIAL
	And COM.D_E_L_E_T_ =''
	
	Inner Join SRA010 SRA With (Nolock)
	On RA_FILIAL = RD_FILIAL
	And RA_MAT = RD_MAT
	AND SRA.D_E_L_E_T_ =''
	
	Inner Join SRV010 SRV With (Nolock)
	On RV_COD = RD_PD
	And SRV.D_E_L_E_T_ =''

	Inner Join SRY010_T SRY With (Nolock)
	On RY_CALCULO = RD_ROTEIR
	And SRY.D_E_L_E_T_ = ''

	Inner Join CTT010 CTT With (Nolock)
	On CTT_FILIAL = RD_FILIAL
	And CTT_CUSTO = RD_CC
	And CTT.D_E_L_E_T_ = ''
	
	Where RD_FILIAL = 'CA01' and RD_PD In ('676') and RD_MAT In ('002338') 
	and SRD.D_E_L_E_T_ ='' and RD_DATARQ = '202303'

/*
--SRA - Funcionarios
Select * From SRA010
Where RA_MAT = '001520' and RA_FILIAL = 'FI01'

Select * From SRA010
Where RA_NOME Like ('%Elton%') 


-- SRV - Verbas 
Select * From SRV010
Where RV_FILIAL = 'FI'


--SRD - Historico de Movimentos
Select * From SRD010
Where RD_FILIAL = 'FI01' And RD_MAT = '001520' and D_E_L_E_T_ =''

--SRY Roteiros de Cálculo
Select * From SRY010_T

-- CTT Centro de custo 
Select * From CTT010

-- SYS_COMPANY - Empresas
Select * From SYS_COMPANY
*/
