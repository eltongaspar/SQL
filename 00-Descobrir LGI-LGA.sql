-- Descobrir usu�rio que inclui ou alterou um dado

SELECT 
SUBSTRING(DC_USERLGI, 3, 1) + SUBSTRING(DC_USERLGI, 7, 1) +
SUBSTRING(DC_USERLGI, 11, 1) + SUBSTRING(DC_USERLGI, 15, 1) +
SUBSTRING(DC_USERLGI, 2, 1) + SUBSTRING(DC_USERLGI, 6, 1) +
SUBSTRING(DC_USERLGI, 10, 1) + SUBSTRING(DC_USERLGI, 14, 1) +
SUBSTRING(DC_USERLGI, 1, 1) + SUBSTRING(DC_USERLGI, 5, 1) +
SUBSTRING(DC_USERLGI, 9, 1) + SUBSTRING(DC_USERLGI, 13, 1) +
SUBSTRING(DC_USERLGI, 17, 1) + SUBSTRING(DC_USERLGI, 4, 1) +
SUBSTRING(DC_USERLGI, 8, 1) USUARIO_INCLUSAO,
SUBSTRING(DC_USERLGA, 3, 1) + SUBSTRING(DC_USERLGA, 7, 1) +
SUBSTRING(DC_USERLGA, 11, 1) + SUBSTRING(DC_USERLGA, 15, 1) +
SUBSTRING(DC_USERLGA, 2, 1) + SUBSTRING(DC_USERLGA, 6, 1) +
SUBSTRING(DC_USERLGA, 10, 1) + SUBSTRING(DC_USERLGA, 14, 1) +
SUBSTRING(DC_USERLGA, 1, 1) + SUBSTRING(DC_USERLGA, 5, 1) +
SUBSTRING(DC_USERLGA, 9, 1) + SUBSTRING(DC_USERLGA, 13, 1) +
SUBSTRING(DC_USERLGA, 17, 1) + SUBSTRING(DC_USERLGA, 4, 1) +
SUBSTRING(DC_USERLGA, 8, 1) USUARIO_ALTERACAO
FROM  SDC010
Where DC_FILIAL = '02' and DC_PRODUTO = '1520604401'and DC_QUANT > 0
and D_E_L_E_T_ ='' and DC_PEDIDO In ('000032') and DC_LOCALIZ = 'B00389'


SELECT 
SUBSTRING(ZE_USERLGI, 3, 1) + SUBSTRING(ZE_USERLGI, 7, 1) +
SUBSTRING(ZE_USERLGI, 11, 1) + SUBSTRING(ZE_USERLGI, 15, 1) +
SUBSTRING(ZE_USERLGI, 2, 1) + SUBSTRING(ZE_USERLGI, 6, 1) +
SUBSTRING(ZE_USERLGI, 10, 1) + SUBSTRING(ZE_USERLGI, 14, 1) +
SUBSTRING(ZE_USERLGI, 1, 1) + SUBSTRING(ZE_USERLGI, 5, 1) +
SUBSTRING(ZE_USERLGI, 9, 1) + SUBSTRING(ZE_USERLGI, 13, 1) +
SUBSTRING(ZE_USERLGI, 17, 1) + SUBSTRING(ZE_USERLGI, 4, 1) +
SUBSTRING(ZE_USERLGI, 8, 1) USUARIO_INCLUSAO,
SUBSTRING(ZE_USERLGA, 3, 1) + SUBSTRING(ZE_USERLGA, 7, 1) +
SUBSTRING(ZE_USERLGA, 11, 1) + SUBSTRING(ZE_USERLGA, 15, 1) +
SUBSTRING(ZE_USERLGA, 2, 1) + SUBSTRING(ZE_USERLGA, 6, 1) +
SUBSTRING(ZE_USERLGA, 10, 1) + SUBSTRING(ZE_USERLGA, 14, 1) +
SUBSTRING(ZE_USERLGA, 1, 1) + SUBSTRING(ZE_USERLGA, 5, 1) +
SUBSTRING(ZE_USERLGA, 9, 1) + SUBSTRING(ZE_USERLGA, 13, 1) +
SUBSTRING(ZE_USERLGA, 17, 1) + SUBSTRING(ZE_USERLGA, 4, 1) +
SUBSTRING(ZE_USERLGA, 8, 1) USUARIO_ALTERACAO
From SZE010
Where ZE_FILIAL In ('02') and ZE_PRODUTO In ('1520604401') and D_E_L_E_T_ ='' and ZE_STATUS Not in  ('F','C')
And ZE_NUMBOB = '2085868'


/*
Select * From SYS_USR
Where USR_ID In ('000077','000093','000820')