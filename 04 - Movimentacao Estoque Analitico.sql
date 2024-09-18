-- Cadastro de Produtos
Select B1_RASTRO, B1_TIPOCQ , B1_NOTAMIN, * From SB1010
Where B1_COD In ('0900110007') and D_E_L_E_T_=''

--Indicador de Produtos
Select * From SBZ010
Where BZ_FILIAL = 'AE01' and D_E_L_E_T_ ='' and BZ_COD In ('0900110007')

--Dados adicionais Produto
Select * From SB5010
Where B5_FILIAL = 'BA01' and D_E_L_E_T_='' and B5_COD In ('0110020020','0110010251')


-- Consulta Estoque Terceiros 
Select * From SB6010
Where B6_FILIAL = 'AE01' and B6_PRODUTO in('0900110007') and B6_SALDO > 0

Select B6_PRODUTO, Sum (B6_SALDO) Total From SB6010
Where B6_FILIAL = 'AE01' and B6_PRODUTO in ('0900110007') and B6_SALDO > 0
Group By B6_PRODUTO


---- Saldo Fisico e Financeiro (Estoque)
Select B2_QEMP,B2_QEMPSA ,B2_QATU,B2_RESERVA, * From SB2010
Where B2_COD In ('1231300801') and D_E_L_E_T_ = '' and B2_FILIAL = '01'

Select SUM(B2_QATU)QTDE, B2_COD From SB2010
Where B2_COD In ('1231300801') and D_E_L_E_T_ = '' and B2_FILIAL = '01'
Group By B2_COD

--SB8 - Saldos por Lote
Select B8_PRODUTO,SUM (B8_SALDO)QTDE, B8_LOTECTL  From SB8010
Where B8_FILIAL = '01' and B8_PRODUTO In  ('MC15001830') and D_E_L_E_T_='' and B8_SALDO > '0'
Group By B8_PRODUTO,B8_LOTECTL

Select SUM (B8_SALDO)QTDE, B8_PRODUTO From SB8010
Where B8_FILIAL = '01' and B8_PRODUTO In  ('MC15001830') and D_E_L_E_T_='' and B8_SALDO > '0'
Group By B8_PRODUTO

Select B8_EMPENHO,B8_EMPENH2,*  From SB8010
Where B8_FILIAL = '01' and B8_PRODUTO In  ('MC15001830') and D_E_L_E_T_='' and B8_SALDO > '0'


--SBF - Saldos por Endereco
Select BF_PRODUTO,SUM (BF_QUANT)QTDE, BF_LOCALIZ  From SBF010
Where BF_FILIAL = '01' and BF_PRODUTO In  ('1231300801') and D_E_L_E_T_='' and BF_QUANT > '0'
Group By BF_PRODUTO,BF_LOCALIZ

Select SUM (BF_QUANT)QTDE, BF_PRODUTO From SBF010
Where BF_FILIAL = '01' and BF_PRODUTO In  ('1231300801') and D_E_L_E_T_='' and BF_QUANT > '0'
Group By BF_PRODUTO

Select BF_EMPENHO,BF_EMPEN2,*  From SBF010
Where BF_FILIAL = '01' and BF_PRODUTO In  ('1231300801') and D_E_L_E_T_='' and BF_QUANT > '0'


--SDB - Movimentos de Distribuicao

Select DB_PRODUTO,SUM (DB_QUANT)QTDE, DB_LOCALIZ  From SDB010
Where DB_FILIAL = '01' and DB_PRODUTO In  ('1231300801') and D_E_L_E_T_='' and DB_QUANT > '0'
And DB_LOCALIZ = 'PROD_PCF'  and DB_TM <= 499
Group By DB_PRODUTO,DB_LOCALIZ

Select SUM (DB_QUANT)QTDE, DB_PRODUTO From SDB010
Where DB_FILIAL = '01' and DB_PRODUTO In  ('1231300801') and D_E_L_E_T_='' and DB_QUANT > '0'
And DB_LOCALIZ = 'PROD_PCF' and DB_LOCAL = '20' and DB_TM <= 499
Group By DB_PRODUTO

Select *  From SDB010
Where DB_FILIAL = '01' and DB_PRODUTO In  ('1231300801') and D_E_L_E_T_='' and DB_QUANT > '0'
And DB_LOCALIZ = 'PROD_PCF' and DB_TM <= 499
Order By DB_DATA


--Lotes Bloqueados
Select * From SDD010
Where DD_PRODUTO In ('0900110007') and DD_FILIAL = 'AE01' And DD_SALDO > 0 and D_E_L_E_T_=''

--SB9 - Saldos Iniciais
SELECT * FROM SB9010 WHERE B9_FILIAL = 'AE01' AND B9_COD = '0902130001' AND D_E_L_E_T_ = '' And B9_DATA = '20230228'
And B9_QINI > 0

--SBJ - Saldos Iniciais por Lote
SELECT * FROM SBJ010 WHERE BJ_FILIAL = 'AE01' AND BJ_COD = '0902130001' AND D_E_L_E_T_ = '' And BJ_DATA = '20230228'
And BJ_QINI > 0

--SBK - Saldos Iniciais por Endereco
SELECT * FROM SBK010 WHERE BK_FILIAL = '01' AND BK_COD = '0902130001' AND D_E_L_E_T_ = '' And BK_DATA = '20230228'
And BK_QINI > 0



--SD3 - Movimentacoes Internas
SELECT D3_COD,Sum(D3_QUANT) D3_QTDE,D3_TM FROM SD3010 WHERE D3_FILIAL = '01' AND D3_COD In ('MC15001830')  AND D_E_L_E_T_ = ''
And D3_EMISSAO Between '20230801' and '20230831' --and D3_LOTECTL In ('12220618','12310235')
Group By D3_COD,D3_TM

--SD5 - Requisicoes por Lote
SELECT D5_PRODUTO,Sum(D5_QUANT)D5_QTDE,D5_ORIGLAN FROM SD5010 WHERE D5_FILIAL = 'BA01' AND D5_PRODUTO In ('0110020020','0110010251')  AND D_E_L_E_T_ = ''
And D5_DATA Between '20230101' and '20230331' and D5_LOTECTL  In ('12220618','12310235')
Group By D5_PRODUTO,D5_ORIGLAN

--SD7 - Movimetações CQ

Declare @PROD Char(10), @NUMCQ Char(10)
Set @PROD = 'MC15001830'
Set @NUMCQ = 'SK1PUR'

Select D7_PRODUTO,
--Entradas
D7_ENT = (Select Isnull(Sum(D7_SALDO),'') From SD7010 SD72 
Where D7_TIPO = '0' And D7_PRODUTO = @PROD  and D7_ESTORNO  In ('S','')
And D_E_L_E_T_ = '' ),

-- Saidas
D7_SAI = (Select Isnull(Sum(D7_QTDE),'') From SD7010 SD73 
Where D7_TIPO In ('1') And D7_PRODUTO = @PROD  and D7_ESTORNO  = ''
And D_E_L_E_T_ = '' ),

--Rejeitados
Rejeicao = (Select Isnull(Sum(D7_SALDO),'') From SD7010 SD72 
Where D7_TIPO = '6' And D7_PRODUTO = @PROD  and D7_ESTORNO  = ''
And D_E_L_E_T_ = '' ),

-- Devolução
Devolucao = (Select Isnull(Sum(D7_SALDO),'') From SD7010 SD72 
Where D7_TIPO = '7' And D7_PRODUTO = @PROD  and D7_ESTORNO  = 'S'
And D_E_L_E_T_ = '' ),

--Estornos Qtde
Qtde_Estornos = (Select Isnull(Count(D7_TIPO),'') From SD7010 SD72 
Where D7_TIPO = '6' And D7_PRODUTO = @PROD  and D7_ESTORNO  = 'S'
And D_E_L_E_T_ = '' ),

Total_Estornos = (Select Isnull(Sum(D7_TIPO),'') From SD7010 SD72 
Where D7_TIPO = '6' And D7_PRODUTO = @PROD  and D7_ESTORNO  = 'S'
And D_E_L_E_T_ = '' ),

-- Calculos Estoques
-- Entradas
Estoques = (Select Isnull(Sum(D7_SALDO),'') From SD7010 SD72 
Where D7_TIPO = '0' And D7_PRODUTO = @PROD  and D7_ESTORNO  In ('S','')
And D_E_L_E_T_ = '' ) -

--Saidas
(Select Sum (D7_QTDE) From SD7010 SD73 
Where D7_TIPO In ('1') And D7_PRODUTO = @PROD  and D7_ESTORNO  = ''
And D_E_L_E_T_ = '' ) - 

(Select Isnull(Sum(D7_SALDO),'') From SD7010 SD72 
Where D7_TIPO = '7' And D7_PRODUTO = @PROD  and D7_ESTORNO  = 'S'
And D_E_L_E_T_ = '' ) 
FRom SD7010 SD7

Where D7_PRODUTO = @PROD  and D7_ESTORNO  = ''
And D_E_L_E_T_ = '' 
Group By D7_PRODUTO


--SB7 - Lancamentos do Inventario
Select * From SB7010
Where B7_FILIAL ='AE01' and B7_COD = '0902130001' and B7_DATA Between '20230101' and '20230331' and D_E_L_E_T_ ='' 

--SD1 - Entrada Itens NF
SELECT D1_COD,Sum(D1_QUANT) D1_QTDE,D1_TES FROM SD1010 WHERE D1_FILIAL = '01' AND D1_COD In ('MC15001830')  AND D_E_L_E_T_ = ''
And D1_DTDIGIT Between '20230801' and '20230831' --and D1_LOTECTL In ('12220618','12310235')
Group By D1_COD,D1_TES

--SD2 - Saida Itens NF
SELECT D2_COD,Sum(D2_QUANT) D2_QTDE,D2_TES FROM SD2010 WHERE D2_FILIAL = '01' AND D2_COD In ('MC15001830')  AND D_E_L_E_T_ = ''
And D2_EMISSAO Between '20230801' and '20230831'-- and D2_LOTECTL In ('12220618','12310235')
Group By D2_COD,D2_TES

--SDB - Movimentos de Distribuicao
Select * From SDB010
Where DB_FILIAL = '01'  and DB_PRODUTO = 'MC15001830'  AND D_E_L_E_T_ = ''
And DB_ESTORNO = ''
And DB_DATA Between '20230801' and '20230831' 

Select DB_PRODUTO,Sum(DB_QUANT)QTDE From SDB010
Where DB_FILIAL = '01' and DB_PRODUTO = 'MC15001830' And DB_TM >= 500   And  D_E_L_E_T_ = ''
And DB_ESTORNO = ''
Group By DB_PRODUTO

Select DB_PRODUTO,Sum(DB_QUANT)QTDE From SDB010
Where DB_FILIAL = '01' and DB_PRODUTO = 'MC15001830' And DB_TM < 500   And  D_E_L_E_T_ = ''
And DB_ESTORNO = ''
Group By DB_PRODUTO

--SD4 - Requisicoes Empenhadas
Select * From SD4010
Where D4_FILIAL = '01' and D4_COD In ('MC15001830') And D4_QUANT > 0  And  D_E_L_E_T_ = ''
and D4_LOCAL In ('7230248','7220248')

Select D4_COD,D4_LOTECTL,Sum(D4_QUANT)QTDE From SD4010
Where D4_FILIAL = 'AE01' and D4_COD = 'MC15001830' And D4_QUANT > 0  And  D_E_L_E_T_ = ''
Group By D4_COD,D4_LOCAL

Select D4_COD,Sum(D4_QUANT)QTDE From SD4010
Where D4_FILIAL = '01' and D4_COD = 'MC15001830' And D4_QUANT > 0  And  D_E_L_E_T_ = ''
Group By D4_COD

--SDA - Saldo a Endereçar
Select * From SDA010
Where DA_FILIAL = '01' and DA_PRODUTO In ('MC15001830') And DA_SALDO > 0  And  D_E_L_E_T_ = ''
and DA_LOCAL In ('66','A0')

Select DA_PRODUTO,DA_LOCAL,Sum(DA_SALDO)QTDE From SDA010
Where DA_FILIAL = '01' and DA_PRODUTO = 'MC15001830' And DA_SALDO > 0  And  D_E_L_E_T_ = ''
Group By DA_PRODUTO,DA_LOCAL

Select DA_PRODUTO,Sum(DA_SALDO)QTDE From SDA010
Where DA_FILIAL = '01' and DA_PRODUTO = 'MC15001830' And DA_SALDO> 0  And  D_E_L_E_T_ = ''
Group By DA_PRODUTO

-- SDC - Reserva de endereços no faturamento
Select * From SDC010
Where DC_FILIAL = '01' and DC_PRODUTO In ('MC15001830') And DC_QUANT > 0  And  D_E_L_E_T_ = ''
and DC_LOCAL In ('66','A0')

Select DC_PRODUTO,DC_LOCAL,Sum(DC_QUANT)QTDE From SDC010
Where DC_FILIAL = '01' and DC_PRODUTO = 'MC15001830' And DC_QUANT > 0  And  D_E_L_E_T_ = ''
Group By DC_PRODUTO,DC_LOCAL

Select DC_PRODUTO,Sum(DC_QUANT)QTDE From SDC010
Where DC_FILIAL = '01' and DC_PRODUTO = 'MC15001830' And DC_QUANT> 0  And  D_E_L_E_T_ = ''
Group By DC_PRODUTO

--SC6 - Itens dos Pedidos de Venda
Select C6_NUM,C6_QTDVEN,C6_QTDLIB,C6_QTDENT,C6_QTDEMP,C6_RESERVA,C6_QTDRESE,C6_LOTECTL, * From SC6010
Where C6_FILIAL ='AE01'and  C6_PRODUTO In ('0900110007') and D_E_L_E_T_='' and C6_QTDEMP > 0

Select C6_FILIAL, C6_PRODUTO, SUM (C6_QTDEMP) EMPENHO From SC6010
Where C6_FILIAL ='AE01'and  C6_PRODUTO In ('0900110007') and D_E_L_E_T_='' and C6_QTDEMP > 0
Group By C6_FILIAL, C6_PRODUTO




--SC5 - Pedidos de Venda
Select C5_ZZREFIM, * From SC5010
Where C5_FILIAL ='BA01'and  C5_NUM In ('035619') and D_E_L_E_T_=''

--SC9 - Pedidos Liberados
SELECT C9_LOTECTL, * FROM SC9010 
WHERE C9_FILIAL='BA01' AND C9_PRODUTO In ('0100030035') AND D_E_L_E_T_=''