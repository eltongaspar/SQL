-- Easy Export Control

--EE9 - Itens Embarque
SELECT EE9_VLFRET, * FROM EE9010 
WHERE EE9_PREEMB = ('23/108-SC') 

-- EE7 Capara da Exportacao
Select * From EE7010
Where EE7_FILIAL = 'BA01' and EE7_PEDIDO = '035619'

--EE8 Itens do Pedido de Exportação
Select * From EE8010
Where EE8_FILIAL = 'BA01' and EE8_PEDIDO = '044833'

--EEC Capa do Embarque de Exportação
Select * From EEC010
Where EEC_FILIAL = 'BA01' and EEC_PREEMB = '23/108-SC'


--EET - Despesas de Exportacao
Select EET_FINNUM,* From EET010
Where EET_FILIAL = 'BA01' and EET_PEDIDO = '23/108-SC' and D_E_L_E_T_ ='' 
--and EET_FINNUM = '200004362' and D_E_L_E_T_ =''

--EEB - Agentes de um Pedido
Select * From EEB010
Where EEB_FILIAL = 'BA01' and EEB_PEDIDO = '23/108-SC' and D_E_L_E_T_ =''


--TITULO PROVISORIO (sem data de embarque)
SELECT * FROM EXL010 WHERE EXL_PREEMB Like '23/108-SC' and D_E_L_E_T_ =''


--TITULO DEFINITIVO (com dt embarque)
SELECT EEQ_FINNUM, * FROM EEQ010 
WHERE EEQ_PREEMB='23/108-SC' and D_E_L_E_T_ =''


--SE2 - Contas a Pagar
SELECT E2_HIST,* FROM SE2010 
WHERE E2_NUM='200007919' or E2_HIST Like ('%23/108-SC') and D_E_L_E_T_ =''


--EXP - Capa da Invoice
SELECT * FROM EXP010 WHERE EXP_PREEMB='23/108-SC'
--UPDATE EXP010 SET EXP_FRPREV='3976', EXP_TOTPED='80024' WHERE EXP_PREEMB='22/085-SG'

--EXR - Detalhes das Invoices
SELECT * FROM EXR010 WHERE EXR_PREEMB='23/108-SC' 
--UPDATE EXR010 SET EXR_PRCTOT='40012', EXR_VLFRET='1988' WHERE EXR_PREEMB='22/085-SG' 