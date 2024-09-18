-- Voltar pedido de venda com resíduo eliminado
--Ajuste na SC5 e SC6 conforme abaixo.
-- SC5 - Pedidos de venda 
-- SC6 - Itens do Pedido de venda

SELECT C5_LIBEROK,C5_NOTA,* FROM SC5010 WHERE C5_NUM = '000097' AND C5_FILIAL = 'FB02'

--UPDATE SC5010 SET C5_LIBEROK='', C5_NOTA WHERE C5_NUM = '000097' AND C5_FILIAL = 'FB02' 


SELECT C6_BLQ, * FROM SC6010 WHERE C6_NUM = '000097' AND C6_FILIAL = 'FB02'

--UPDATE SC6010 SET C6_BLQ='' WHERE C6_NUM = '000097' AND C6_FILIAL = 'FB02' 