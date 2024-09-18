--Após a conferencia acima, deverá habilitar o parâmetro de integração entre o Medicina e Estoque sendo o 
--parâmetro MV_NGMDTES = S  e  MV_NG2SA = N.
--Para isto acesse o configurador ( SIGACFG), no seguinte caminho: Atualizações > Cadastro > Parâmetro.
-- https://centraldeatendimento.totvs.com/hc/pt-br/articles/360050786733-RH-Linha-Protheus-MDT-Entrega-de-EPI-com-baixa-no-estoque



Select * From SX6010
Where X6_VAR In ('MV_NGMDTES','MV_NG2SA')