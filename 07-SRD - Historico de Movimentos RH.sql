-- SRD - Historico de Movimentos - RH - Soma Valores ++
Select SUM (RD_VALOR) Valor From SRD010
Where RD_FILIAL = 'CA01' and RD_PD = 'B78' and RD_DATARQ = '202201' and D_E_L_E_T_ =''
Group By RD_FILIAL

-- SRD - Historico de Movimentos - RH
Select * From SRD010
Where RD_FILIAL = 'CA01' and RD_PD = 'B78' and RD_DATARQ = '202201' and D_E_L_E_T_ =''


--SRR - Itens de Ferias e Rescisoes
Select * From SRR010
Where RR_FILIAL = 'CA01' and RR_PD = 'B78' and RR_PERIODO = '202201' and D_E_L_E_T_ =''

--SRR - Itens de Ferias e Rescisoes - Soma++
Select SUM (RR_VALOR) Valor From SRR010
Where RR_FILIAL = 'CA01' and RR_PD = 'B78' and RR_PERIODO = '202201' and D_E_L_E_T_ =''
Group By RR_FILIAL