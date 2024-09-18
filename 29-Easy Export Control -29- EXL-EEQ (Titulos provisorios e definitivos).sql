--Pra resolver, precisamos excluir o frete adicional EXL e seu respectivo na SE2.



--TITULO PROVISORIO (sem data de embarque)

SELECT * FROM EXL010 WHERE EXL_PREEMB Like '23/057-SC' and D_E_L_E_T_ =''



--TITULO DEFINITIVO (com dt embarque)

SELECT EEQ_FINNUM,* FROM EEQ010 WHERE EEQ_PREEMB='23/057-SC' and D_E_L_E_T_ =''


--SE2 - Contas a Pagar
SELECT * FROM SE2010 WHERE E2_NUM = '200003222' and D_E_L_E_T_ =''



--**Feito a exclusão da EXL e SE2, foi recolocado o frete adicional e a data de averbação ( que é apagada junto com a EXL) e finalizado com data de embarque. Fechou  normalmente.


-- Despesas
Select * From SYB010
Where YB_DESP In ('958','425')