--SC5 - Pedidos de Venda
Select C5_ZZREFIM,C5_PREPEMB, * From SC5010
Where C5_FILIAL ='BA02'and  C5_NUM In ('006013') and D_E_L_E_T_=''

--SC6 - Itens dos Pedidos de Venda
Select C6_ZZREFIM, * From SC6010
Where C6_FILIAL ='BA03'and  C6_NUM In ('006013') and D_E_L_E_T_=''

--SC9 - Pedidos Liberados ###Integracao EEC não gera SC9###
SELECT C9_LOTECTL, * FROM SC9010 
WHERE C9_FILIAL='BA03' AND C9_PEDIDO In ('006013') AND D_E_L_E_T_=''



-- EE7 Capa Exportacao
Select EE7_REFIMP,* From EE7010
Where EE7_FILIAL = 'BA02' and (EE7_PEDIDO = '' or EE7_REFIMP = '23/009-SG') 

--EE8 Itens do Pedido de Exportação
Select * From EE8010
Where EE8_FILIAL = 'BA02' and EE8_PEDIDO = '006013'


--EXP - Capa da Invoice
SELECT EXP_TOTPED,* FROM EXP010 
WHERE EXP_FILIAL In  ('BA02') and EXP_PREEMB In ('23/009-SG')
Order By EXP_FILIAL, EXP_PREEMB


--SE1 - Contas a Receber
SELECT E1_FILORIG, E1_VALOR, E1_SALDO, E1_ZZPREEM,E1_CCUSTO, * FROM SE1010
WHERE E1_FILORIG In ('BA02') and  E1_ZZPREEM In ('23/009-SG') and E1_BAIXA='' AND D_E_L_E_T_=''
Order By 1,4


--EEQ - Valor das Parcelas do Embarque
SELECT EEQ_VL, EEQ_FINNUM, * FROM EEQ010
WHERE EEQ_FILIAL In ('BA02') and  EEQ_PREEMB In('23/009-SG') AND D_E_L_E_T_='' 
Order By EEQ_FILIAL, EEQ_PREEMB

--EET - Despesas de Exportacao
Select * From EET010
Where EET_FILIAL = 'BA02' and EET_PEDIDO  In('006013') AND D_E_L_E_T_='' 

--EE9 - Itens Embarque
Select * FRom EE9010
Where EE9_FILIAL = 'BA02' and EE9_PREEMB In ('23/009-SG') and D_E_L_E_T_ =''



-- Easy Export Control

--EE9 - Itens Embarque
SELECT EE9_VLFRET, * FROM EE9010 
WHERE EE9_PREEMB = ('23/053-RB') 


--EEC Capa do Embarque de Exportação
Select * From EEC010
Where EEC_FILIAL = 'BA03' and EEC_PREEMB = '23/053-RB'


--EET - Despesas de Exportacao
Select EET_FINNUM,* From EET010
Where EET_FILIAL = 'BA03' and EET_PEDIDO = '23/053-RB' and D_E_L_E_T_ ='' 
--and EET_FINNUM = '200004362' and D_E_L_E_T_ =''

--EEB - Agentes de um Pedido
Select * From EEB010
Where EEB_FILIAL = 'BA03' and EEB_PEDIDO = '23/053-RB' and D_E_L_E_T_ =''


-- EXL - TITULO PROVISORIO (sem data de embarque)
SELECT * FROM EXL010 WHERE EXL_PREEMB Like '23/053-RB' and D_E_L_E_T_ =''


--TITULO DEFINITIVO (com dt embarque)
SELECT EEQ_FINNUM, * FROM EEQ010 
WHERE EEQ_PREEMB='23/053-RB' and D_E_L_E_T_ =''




--SE2 - Contas a Pagar
SELECT E2_HIST,* FROM SE2010 
WHERE E2_HIST Like ('%23/009-SG') and D_E_L_E_T_ =''




-- Condicao de pagamento Modulo 29 - Easy Export
--SY6 - Condicoes de Pagamento
Select Y6_CODERP, Y6_SIGSE4,Y6_DESC_P,Y6_DESC_I,* From SY6010
Where Y6_COD = '00022' and D_E_L_E_T_ ='' 


--SE4 - Condiçoes de pagamento 
Select * From SE4010
Where E4_CODIGO = '060' and D_E_L_E_T_ =''

--EE2 - Multi-Idiomas
Select * From EE2010
Where EE2_TEXTO In ('000036','354864') and D_E_L_E_T_ = ''

--SYP - Descricoes dos Campos Memo
Select * From SYP010
Where YP_CHAVE In ('000036','354864') And YP_CAMPO Like ('%Y6_DESC%') and YP_FILIAL = '' and D_E_L_E_T_ =''


--SX5 - Tabelas 
Select * From SX5010
Where X5_FILIAL = 'BA03' and X5_TABELA = '21' And D_E_L_E_T_ =''