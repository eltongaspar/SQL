
--Parametro Compras
--Indica si mantenimiento de los Pedidos de Compra restrito ao seu grupo de compras/compradores.     
Select * From SX6010
Where X6_VAR = 'MV_RESTPED'

--Email de Copia de WF Compras (Processo Completo)
Select * From SX6010
Where X6_VAR = 'ZZ_WFCC'
