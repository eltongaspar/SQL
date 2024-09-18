-- Lançamentos Contabeis não integrando 
-- Contas a pagar / Movemento Bancario

--Flag de integrado retirado do lançamento
-- Campos E5_LA = ''
--Descricao: Ident.Lanc/Depos Cheque
-- E2_LA = ''
--Descricao: Identificador de LA .


--SE5 - Movimentacao Bancaria
SELECT E5_LA, E5_NUMERO, * FROM SE5010 WHERE E5_FILORIG='BA10' AND E5_VALOR='12000' and D_E_L_E_T_ =''
--UPDATE SE5010 SET E5_LA='' WHERE E5_FILORIG='BA10' AND E5_VALOR='12901'


--SE2 - Contas a Pagar
SELECT E2_LA, * FROM SE2010 WHERE E2_FILORIG='BA10' AND E2_NUM='000002041'

--UPDATE SE2010 SET E2_LA='' WHERE E2_FILORIG='BA10' AND E2_NUM='000001957'