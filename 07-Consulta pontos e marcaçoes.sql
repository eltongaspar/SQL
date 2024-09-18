-- Consulta pontos e marca�oes


--SRA - Funcionarios
Select * From SRA010
Order By RA_NOME

--C9V - Dados do Trabalhador
Select * From C9V010


--RFB - Cabecalho de Pre-Leitura
Select * From RFB010
Where RFB_FILIAL IN ('FA01','FK01','FJ01','BA04') and D_E_L_E_T_ ='' and RFB_DTHRG >= '2206090000'

--DESCRI��O DO RELOGIO DE PONTO
Select * From SPO010

--MARCA��ES
Select * FRom SP8010
Where P8_FILIAL In ('FA01','FK01','FJ01','BA04') and D_E_L_E_T_ ='' and P8_DATA >= '20220609'
Order By P8_FILIAL, P8_DATA

--EXCE��ES
Select * From SP2010

--Feriados
Select * From SP3010

-- Tipos de horas extras
Select * From SP4010

--Apontamentos
Select * From SPC010

--Acumulado de marca��es
Select * From SPG010

--Acumulao de pontos
Select * From SPH010