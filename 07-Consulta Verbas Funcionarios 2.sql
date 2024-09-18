-- SRR - Itens de Ferias e Rescisoes
Select * From SRR010
Where RR_FILIAL = 'BA13' and RR_MAT in ('000065') and RR_PERIODO = '202111' and RR_PD in ('D02','D04')


-- SRD - Historico de Movimentos
Select * From SRD010
Where RD_FILIAL = 'BA13' and RD_MAT in ('000065') and RD_DATARQ = '202111' and RD_PD in ('D02','D04') and RD_DATPGT = '20211201'
