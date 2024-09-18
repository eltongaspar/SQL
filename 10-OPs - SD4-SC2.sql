--Mapear produtos com custos médio estoutados na APSDU
-- Multiplicar Qtde Atual x Custo 

--SD4 - Requisicoes Empenhadas
Select * From SD4010
Where D4_FILIAL = 'BA11' and D4_OP Like '002299%'

--SC2 - Ordens de Producao
Select * From SC2010
Where C2_FILIAL = 'BA11' and C2_NUM = '002299'