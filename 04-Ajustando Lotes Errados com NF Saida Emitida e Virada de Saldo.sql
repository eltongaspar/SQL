
--Ajustando Lotes Errados com NF Saida Emitida e Virada de Saldo 
-- O procedimento abaixo somente altera Qtde Lotes e n�o Qtdes Gerais , Custos e Custos M�dios


--AJUSTE NA SD2 (CODIGO DO LOTE E VALIDADE)

SELECT D2_DOC,* FROM SD2010 WHERE D2_FILIAL='BA03' AND D2_LOTECTL IN ('7221158')

--UPDATE SD2010 SET D2_LOTECTL='7221058', D2_DTVALID='20230531' WHERE D2_FILIAL='BA03' AND D2_LOTECTL IN ('7221158')

SELECT D2_DOC,* FROM SD2010 WHERE D2_FILIAL='BA03' AND D2_LOTECTL IN ('7221159')

--UPDATE SD2010 SET D2_LOTECTL='7221059', D2_DTVALID='20230531' WHERE D2_FILIAL='BA03' AND D2_LOTECTL IN ('7221159')





--AJUSTE NA SD5 (CODIGO DO LOTE E VALIDADE)

SELECT * FROM SD5010 WHERE D5_FILIAL='BA03' AND D5_LOTECTL IN ('7221158') AND D5_DOC='000056123'

--UPDATE SD5010 SET D5_LOTECTL='7221058', D5_DTVALID='20230531' WHERE D5_FILIAL='BA03' AND D5_LOTECTL IN ('7221158') AND D5_DOC='000056123'

SELECT * FROM SD5010 WHERE D5_FILIAL='BA03' AND D5_LOTECTL IN ('7221159') AND D5_DOC='000056123'

--UPDATE SD5010 SET D5_LOTECTL='7221059', D5_DTVALID='20230531' WHERE D5_FILIAL='BA03' AND D5_LOTECTL IN ('7221159') AND D5_DOC='000056123'





--AJUSTE NA SBJ DEVIDO A NOTA SER ANTES DA ULTIMA VIRADA DE SALDO

--ZERAR ESTOQUE NA BJ_QINI

SELECT * FROM SBJ010 WHERE BJ_FILIAL='BA03' AND BJ_DATA='20221031' AND BJ_COD='0100039201' AND BJ_LOTECTL IN ('7221058','7221059')

--UPDATE SBJ010 SET BJ_QINI='0' WHERE BJ_FILIAL='BA03' AND BJ_DATA='20221031' AND BJ_COD='0100039201' AND BJ_LOTECTL IN ('7221058','7221059')

--VOLTAR ESTOQUE NA BJ_QINI

SELECT * FROM SBJ010 WHERE BJ_FILIAL='BA03' AND BJ_DATA='20221031' AND BJ_COD='0100039201' AND BJ_LOTECTL IN ('7221158','7221159')

--UPDATE SBJ010 SET BJ_QINI='10' WHERE BJ_FILIAL='BA03' AND BJ_DATA='20221031' AND BJ_COD='0100039201' AND BJ_LOTECTL IN ('7221158','7221159')



--RODAR REFAZ SALDO



--CONFERIR B2 X B8



SELECT * FROM SB2010 WHERE B2_FILIAL='BA03' AND B2_COD='0100039201'



SELECT * FROM SB8010 WHERE B8_FILIAL='BA03' AND B8_PRODUTO='0100039201' AND B8_SALDO>0 AND D_E_L_E_T_='' ORDER BY B8_LOTECTL