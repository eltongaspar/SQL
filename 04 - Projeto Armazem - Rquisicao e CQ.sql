-- CQ - Projeto
-- Parametros 

-- Projeto Armazem - Requisição e CQ
-- Calcula Necessidade com Qtde Min e Estoque Seguranca
-- Projeto CQ + Qtde min Produtos
-- Cadastro Produtos 
Select B1_NOTAMIN,B1_TIPOCQ,B1_NUMCQPR,B1_ZZINSPE,
B1_ESTFOR,B1_EMIN,B1_ESTSEG, * From SB1010
--B1_ESTFOR - Fórmula para cálculo do estoque desegurança. Se este campo estiverpreenchido, sobrepöe o valor do campoEstoque segurança.
--B1_EMIN - Ponto de pedido. Quantidade mínima pré-estabelecida que, uma vez atingida,gera emissão automática de uma solicitação de compras ou ordem de produção.
-- B1_ESTSEG - Estoque de segurança. Quantidade mínimade produto em estoque para evitar a falta do mesmo entre a solicitação de compra ou produção e o seu recebimento.
--B1_NOTAMIN - Nota minima do Produto para Controle de Qualidade.
--B1_TIPOCQ - Define se a Movimentação do Controle de Qualidade será feito através do Módulo SIGAEST (Materiais) ou do SIGAQIE (Quality).
-- B1_NUMCQPR - Preencher com o Intervalo de Producoes a ser considerado p/o Envio do Produto ao CQ (Ex.: Se preenchido com 10, a cada 10 producoes, uma será envida ao CQ).
-- B1_ZZINSPE - Personalizado.
Where B1_COD = 'MC15000053'
And D_E_L_E_T_ = ''



--Parametros
Select * From SX6010
Where X6_VAR = 'MV_CQ'

-- Produtos
Select B1_LOCALIZ,* From SB1010
Where B1_COD = 'MC15001830'
And D_E_L_E_T_ = ''

Select B1_LE,B1_ESTSEG,B1_EMIN,* From SB1010
Where B1_COD = 'MC15000053'
and D_E_L_E_T_ =''

-- Estoque 
Select * From SB2010
Where B2_COD = 'MC15001830'
And D_E_L_E_T_ = ''


--SBF - Saldos por Endereco
Select * From SBF010
Where BF_PRODUTO = 'MC15001830'
And D_E_L_E_T_ = ''

--SDC - Composicao do Empenho
Select * From SDC010
Where DC_PRODUTO = 'MC15001830'
And D_E_L_E_T_ = ''

-- Cadastro de Endereço 
Select * From SDA010
Where DA_PRODUTO = 'MC15001830' and DA_SALDO > 0
And D_E_L_E_T_ = ''

--SDB – Movimentos de Distribuição
Select * From SDB010
Where DB_PRODUTO = 'MC15001830' and DB_ESTORNO = '' and DB_ORIGEM = 'SD1'
And D_E_L_E_T_ = ''


--SBE - Cadastro de Endereços
Select * From SBE010
Where BE_LOCAL = 'A0'
And D_E_L_E_T_ = ''

-- Movimentações Internas 
Select D3_NUMSEQ,* From SD3010
Where D3_COD = 'MC15001830' and D3_ESTORNO = ''
--And D3_NUMSEQ In ('SK1PU1''SK1PU2')
And D_E_L_E_T_ = ''

-- PC
Select  * From SC7010
Where C7_NUM = '008640'
And D_E_L_E_T_ = ''

-- SC
Select  * From SC1010
Where C1_NUM In ('146294','145053')
And D_E_L_E_T_ = ''

--Cotação 
Select  * From SC8010
Where C8_NUM In ('006799')
And D_E_L_E_T_ = ''

--SD4 - Requisicoes Empenhadas
Select * From SD4010
Where D4_COD = 'MC15001830'

--TES
Select * From SF4010
Where F4_CODIGO = '169'


-- Testes 
-- Movimentacao CQ 
Select D7_NUMERO,* FRom SD7010
Where D7_PRODUTO = 'MC15001830'  --and D7_ESTORNO  = ''
And D_E_L_E_T_ = '' and D7_NUMERO = 'SK1PU2'
Order By 1,D7_SEQ












-- Testes 
-- Movimentacao CQ 
Select D7_NUMERO,* FRom SD7010
Where D7_PRODUTO = 'MC15001830' -- and D7_ESTORNO  = ''
And D_E_L_E_T_ = ''and D7_NUMERO = 'SK1PU8'
Order By 1,D7_SEQ


Declare @PROD Char(10), @NUMCQ Char(10)
Set @PROD = 'MC15001830'
Set @NUMCQ = 'SK1PUR'

Select D7_PRODUTO,
--Entradas
D7_ENT = (Select Isnull(Sum(D7_SALDO),'') From SD7010 SD72 
Where D7_TIPO = '0' And D7_PRODUTO = @PROD  and D7_ESTORNO  In ('S','')
And D_E_L_E_T_ = '' and D7_NUMERO = @NUMCQ),

-- Saidas
D7_SAI = (Select Isnull(Sum(D7_QTDE),'') From SD7010 SD73 
Where D7_TIPO In ('1') And D7_PRODUTO = @PROD  and D7_ESTORNO  = ''
And D_E_L_E_T_ = '' and D7_NUMERO = @NUMCQ),

--Rejeitados
Rejeicao = (Select Isnull(Sum(D7_SALDO),'') From SD7010 SD72 
Where D7_TIPO = '6' And D7_PRODUTO = @PROD  and D7_ESTORNO  = ''
And D_E_L_E_T_ = '' and D7_NUMERO = @NUMCQ),

-- Devolução
Devolucao = (Select Isnull(Sum(D7_SALDO),'') From SD7010 SD72 
Where D7_TIPO = '7' And D7_PRODUTO = @PROD  and D7_ESTORNO  = 'S'
And D_E_L_E_T_ = '' and D7_NUMERO = @NUMCQ),

--Estornos Qtde
Qtde_Estornos = (Select Isnull(Count(D7_TIPO),'') From SD7010 SD72 
Where D7_TIPO = '6' And D7_PRODUTO = @PROD  and D7_ESTORNO  = 'S'
And D_E_L_E_T_ = '' and D7_NUMERO = @NUMCQ),

Total_Estornos = (Select Isnull(Sum(D7_TIPO),'') From SD7010 SD72 
Where D7_TIPO = '6' And D7_PRODUTO = @PROD  and D7_ESTORNO  = 'S'
And D_E_L_E_T_ = '' and D7_NUMERO = @NUMCQ),

-- Calculos Estoques
-- Entradas
Estoques = (Select Isnull(Sum(D7_SALDO),'') From SD7010 SD72 
Where D7_TIPO = '0' And D7_PRODUTO = @PROD  and D7_ESTORNO  In ('S','')
And D_E_L_E_T_ = '' and D7_NUMERO = @NUMCQ) -

--Saidas
(Select Sum (D7_QTDE) From SD7010 SD73 
Where D7_TIPO In ('1') And D7_PRODUTO = @PROD  and D7_ESTORNO  = ''
And D_E_L_E_T_ = '' and D7_NUMERO = @NUMCQ) - 

(Select Isnull(Sum(D7_SALDO),'') From SD7010 SD72 
Where D7_TIPO = '7' And D7_PRODUTO = @PROD  and D7_ESTORNO  = 'S'
And D_E_L_E_T_ = '' and D7_NUMERO = @NUMCQ)

FRom SD7010 SD7

Where D7_PRODUTO = @PROD  and D7_ESTORNO  = ''
And D_E_L_E_T_ = '' and D7_NUMERO = @NUMCQ
Group By D7_PRODUTO


Select B1_TIPO,B1_DESC,B1_LOCPAD,* From SB2010 SB2
	Inner Join SB1010 SB1
	On B1_COD = B2_COD
	 and SB1.D_E_L_E_T_ =''

where B2_LOCAL = '98' and B2_QATU > 0  and SB2.D_E_L_E_T_ =''