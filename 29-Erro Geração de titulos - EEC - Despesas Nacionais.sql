--Acontece o erro pois n�o existe um lan�amento no financeiro deste processo.

--Localizar na tabela de Despesas de Exporta��o (EET) o pedido e apagar o numero do documento do financeiro e a data de emiss�o.

--AJUSTE DENTRO DO DESPESAS NACIONAIS, DENTRO DO EMBARQUE

SELECT * FROM EET010 WHERE EET_PEDIDO='23/005-B-RB'  AND D_E_L_E_T_='' AND EET_FINNUM='200012314'

--UPDATE EET010 SET EET_FINNUM='', EET_ZZDTEM='' WHERE EET_PEDIDO='23/005-B-RB'  AND D_E_L_E_T_='' AND EET_FINNUM='200012314'

