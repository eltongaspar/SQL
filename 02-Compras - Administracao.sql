-- Pedido Compra
SELECT C7_FILIAL, C7_PRODUTO, C7_NUM, C7_NUMCOT, C7_NUMSC, C7_FORNECE, C7_LOJA, C7_QUJE, C7_CONAPRO, C7_QUANT, * FROM SC7010 
WHERE C7_FILIAL='03' AND C7_NUM >= ('010250') and D_E_L_E_T_ = '' --and C7_PRODUTO = '0210050147'
--UPDATE SC7010 SET C7_FORNECE= '010151', C7_LOJA='01' WHERE C7_FILIAL='BA02' AND C7_NUM='008285'

--Cotações
SELECT C8_FILIAL, C8_PRODUTO, C8_NUMPED,C8_NUM,C8_NUMSC, C8_FORNECE, C8_LOJA, * FROM SC8010 
WHERE C8_FILIAL='03' AND C8_NUM = '000018' AND D_E_L_E_T_='' --and NOT C8_NUMPED = 'XXXXXX' and C8_NUMPED in ('001049')
--AND C8_FORNECE='000299'
--UPDATE SC8010 SET C8_FORNECE='010151', C8_LOJA='01' WHERE C8_FILIAL='BA02' AND C8_NUM='005977' AND D_E_L_E_T_='' --AND C8_FORNECE='000299'

-- Solicitação de compra
Select C1_FILIAL, C1_PRODUTO, C1_PEDIDO, C1_COTACAO, C1_NUM, C1_FORNECE, C1_LOJA, * From SC1010
Where C1_FILIAL = '03' and C1_NUM >= '000010' and D_E_L_E_T_ = '' 


--CADASTRO DE SOLICITANTES
Select * From SAI010
Where AI_FILIAL In ('01','02','03') and D_E_L_E_T_=''

-- Compradores 
Select * From SY1010
Where  D_E_L_E_T_ = ''

--Grupo de Compras
Select * From SAJ010
Where  D_E_L_E_T_ = ''


--SAJ - Grupos de Compras - Validação 
Select Count (AJ_USER) Total, AJ_US2NAME From SAJ010
Where  D_E_L_E_T_ =''
Group By AJ_US2NAME



-- Aprovadores
Select * From SAK010
Where AK_FILIAL In ('01','03') and D_E_L_E_T_=''


-- Perfis Aprovação 
Select * From DHL010
Where DHL_FILIAL In ('01','03')
and D_E_L_E_T_=''

-- Grupo de Aprovadores 
Select * From SAL010
Where AL_FILIAL In ('01','03') and D_E_L_E_T_ = ''


--DBL - Entidades Contabeis X Grp Apr
Select * From DBL010
Where DBL_FILIAL In ('01','03') and D_E_L_E_T_ =''



--Usuários
Select * From SYS_USR
Where USR_CODIGO Like '%evert%'and D_E_L_E_T_=''


-- Parametros 
Select X6_FIL,X6_VAR,X6_DESCRIC,X6_DESC1,X6_DESC2,X6_CONTEUD,* From SX6010
Where X6_VAR In ('MV_COTFILT','MV_SELFOR')
and D_E_L_E_T_ =''



-- Logs SC COT PC 

--COH - LOG do processo de Pedido de Compra
Select * From COI010

--COI  - LOG do Processo de Solicitação de Compra
Select * From COH010

--COK - LOG por Solicitação de compra do fornecedor
Select * From COK010


Select * From COI010
Where COI_NUMSC = '145050' and D_E_L_E_T_ =''

--COH - LOG do processo de Pedido de Compra
--COI  - LOG do Processo de Solicitação de Compra
--COK - LOG por Solicitação de compra do fornecedor