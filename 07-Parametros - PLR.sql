-- Parametro para Configurar PLR Portal RH 
-- https://centraldeatendimento.totvs.com/hc/pt-br/articles/360044237214-RH-Linha-Protheus-MEU-RH-Qual-a-regra-para-exibir-os-Demonstrativos-de-Pagamento-recibos-holerites

Select * From SX6010
Where X6_VAR = 'MV_TCFDEXT'

--Define o dia do mês a partir do qual os valores   
--extras e PLR estão liberados para consulta no RH Online.                                               