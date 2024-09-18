--Grupo de Compras
Select * From SAJ010
Where AJ_USER = '000000'

Select Count(AJ_GRCOM),AJ_GRCOM From SAJ010
Group By AJ_GRCOM
