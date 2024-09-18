--SRD - Historico de Movimentos
Select Distinct SRD.RD_FILIAL, COMPANY.M0_FILIAL, SRD.RD_MAT, SRA.RA_NOME, SRD.RD_PD, SRV.RV_DESC, SRD.RD_CC, CTT.CTT_DESC01,
SRD.RD_ROTEIR, SRY.RY_DESC, SRD.RD_HORAS, SRD.RD_VALOR, SRD.RD_DATARQ, SRD.RD_DATARQ, SQB.QB_DEPTO, SQB.QB_DESCRIC
From SRD010 SRD

	-- Empresas
	Inner Join SYS_COMPANY COMPANY With(Nolock)
	ON COMPANY.M0_CODFIL = SRD.RD_FILIAL
	And COMPANY.D_E_L_E_T_ =''

	-- Funcionarios
	Inner Join SRA010 SRA With(Nolock)
	ON SRA.RA_MAT = SRD.RD_MAT
	And SRA.RA_FILIAL = SRD.RD_FILIAL
	And SRA.D_E_L_E_T_ = ''

	-- SRV - Verbas
	Inner Join SRV010 SRV With(Nolock)
	On SRV.RV_COD = SRD.RD_PD
	Or SRV.RV_FILIAL = SRD.RD_FILIAL
	And SRV.D_E_L_E_T_ =''

	-- Centro de Custo
	Inner Join CTT010 CTT With (NOLOCK)
	On CTT.CTT_CUSTO = SRD.RD_CC
	and CTT.D_E_L_E_T_ =''

	-- Departamentos
	Left Join SQB010 SQB With (NOLOCK)
	On SQB.QB_DEPTO = SRD.RD_DEPTO
	and SQB.D_E_L_E_T_ =''

	-- Roteiro
	Inner Join SRY010_T SRY With (Nolock)
	On SRY.RY_CALCULO = SRD.RD_ROTEIR
	And SRY.D_E_L_E_T_ = ''

Where RD_FILIAL = 'BA01' and RD_DATARQ = '202302' and RD_PD <> '' and RD_MAT In ('000562')
and SRD.D_E_L_E_T_=''

-- Tabelas 
-- SRV - Historicos de Movimentos RH
-- Sys.Company - Empresas
-- SRA - Funcionário 
-- SRV - Verbas 
-- CTT - Centro de Custo
-- SBQ - Departamentos
-- SRY - Roteiro



/*
Select * From SRV010
Select * FRom SRA010
Select * From SRD010
Select * From CTT010
Select * From SQB010
Select * From SRY010_T
*/

