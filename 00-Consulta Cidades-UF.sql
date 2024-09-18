-- Consulta Cidade UFs

--SX5 - Tabelas
Select * From SX5010
Where X5_DESCRI in ('UNIDADE FEDERATIVA') and X5_TABELA = '00'  and X5_CHAVE = '12'

--CC2 - Tabelas de municipios do IBGE
Select *  From CC2010
Where CC2_EST in ('SP') and D_E_L_E_T_=''

--CC2 - Tabelas de municipios do IBGE
Select CC2_EST,Count(CC2_MUN)  From CC2010
Where CC2_EST in ('TO') and D_E_L_E_T_=''
Group By CC2_EST

--CC2 - Tabelas de municipios do IBGE
Select * From CC2010
--Where CC2_EST in ('') and D_E_L_E_T_=''
Order By CC2_MUN 
