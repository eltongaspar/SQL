-- Histrico de movimentos funcionarios (Verbas)
Select * From SRD010
Where RD_FILIAL = 'BA06' and RD_MAT in ('000130','000131','000132') and RD_DATARQ = '202110' and RD_PD = 'D04'


-- Consulta Verbas (RH)
Select * From SRV010
Where RV_FILIAL = 'BA' and RV_COD = 'D04'

-- Consulta apontamentos funcionários
Select * From SPH010
Where PH_FILIAL = 'BA06' and PH_MAT = '000132'