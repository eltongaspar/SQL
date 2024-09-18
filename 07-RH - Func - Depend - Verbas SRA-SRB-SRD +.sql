-- Consulta Funcionários
Select * From SRA010
Where --A_FILIAL = 'BA01' and RA_MAT = '' and 
RA_NOME Like ('%Ali%')

-- Consulta Matricula e Filial
Select * From SRA010
Where RA_FILIAL = 'FF01' and RA_MAT = '000079'

-- Consulta Depedentes
Select * FRom SRB010
Where RB_FILIAL = 'BA01' and RB_MAT = '' and  D_E_L_E_T_ = ''

--SRD - Historico de Movimentos
Select * From SRD010
Where RD_FILIAL = 'BA02' and RD_MAT = '000217' and RD_DATARQ >= '202201' and RD_PD = '676'

-- SRR - Itens de Ferias e Rescisoes
Select * From SRR010
Where RR_FILIAL = 'BA02' and RR_MAT in ('000217') and RR_PERIODO >= '202201' and RR_PD in ('D02','D04')

-- Consulta Verbas (RH)
Select * From SRV010
Where RV_FILIAL = 'BA' and RV_COD = 'D04'

-- Consulta apontamentos funcionários
Select * From SPH010
Where PH_FILIAL = 'BA02' and PH_MAT = '000217' and PH_DATA >= '20220201'