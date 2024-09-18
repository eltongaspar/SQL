-- Consulta Qualidade - Resultados por OP.
-- Tabela Laudo de operação
Select * From QPM010
Where QPM_FILIAL = 'FA01' 
and QPM_LOTE like '%21/%'
and QPM_OP = '00002101001' and D_E_L_E_T_ = ''


Select QPM_DESLAU,Count(QPM_DESLAU) From QPM010
Where QPM_FILIAL = 'BA11' 
and QPM_OP = '00002101001' and D_E_L_E_T_ = ''
Group By QPM_DESLAU

Select QPM_PRODUT,Count(QPM_DESLAU) From QPM010
Where QPM_FILIAL = 'BA11' 
and QPM_OP = '00002101001' and D_E_L_E_T_ = ''
Group By QPM_PRODUT