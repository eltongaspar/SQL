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
Where B2_COD In ('0900110007') and D_E_L_E_T_ = '' and B2_FILIAL = 'AE01'

Select SUM(B2_QATU)QTDE, B2_COD From SB2010
Where B2_COD In ('0900110007') and D_E_L_E_T_ = '' and B2_FILIAL = 'AE01'
Group By B2_COD

--SB8 - Saldos por Lote
Select B8_PRODUTO,SUM (B8_SALDO)QTDE, B8_LOTECTL  From SB8010
Where B8_FILIAL = 'AE01' and B8_PRODUTO In  ('0900110007') and D_E_L_E_T_='' and B8_SALDO > '0'
Group By B8_PRODUTO,B8_LOTECTL

Select SUM (B8_SALDO)QTDE, B8_PRODUTO From SB8010
Where B8_FILIAL = 'AE01' and B8_PRODUTO In  ('0900110007') and D_E_L_E_T_='' and B8_SALDO > '0'
Group By B8_PRODUTO

Select B8_EMPENHO,B8_EMPENH2,*  From SB8010
Where B8_FILIAL = 'AE01' and B8_PRODUTO In  ('0900110007') and D_E_L_E_T_='' and B8_SALDO > '0'

--Lotes Bloqueados
Select * From SDD010
Where DD_PRODUTO In ('0900110007') and DD_FILIAL = 'AE01' And DD_SALDO > 0 and D_E_L_E_T_=''

--SB9 - Saldos Iniciais
SELECT * FROM SB9010 WHERE B9_FILIAL = 'AE01' AND B9_COD = '0902130001' AND D_E_L_E_T_ = '' And B9_DATA = '20230228'
And B9_QINI > 0

--SBJ - Saldos Iniciais por Lote
SELECT * FROM SBJ010 WHERE BJ_FILIAL = 'AE01' AND BJ_COD = '0902130001' AND D_E_L_E_T_ = '' And BJ_DATA = '20230228'
And BJ_QINI > 0

--SD3 - Movimentacoes Internas
SELECT D3_COD,Sum(D3_QUANT) D3_QTDE,D3_TM FROM SD3010 WHERE D3_FILIAL = 'BA01' AND D3_COD In ('0110020020','0110010251')  AND D_E_L_E_T_ = ''
And D3_EMISSAO Between '20230101' and '20230331' and D3_LOTECTL In ('12220618','12310235')
Group By D3_COD,D3_TM

--SD5 - Requisicoes por Lote
SELECT D5_PRODUTO,Sum(D5_QUANT)D5_QTDE,D5_ORIGLAN FROM SD5010 WHERE D5_FILIAL = 'BA01' AND D5_PRODUTO In ('0110020020','0110010251')  AND D_E_L_E_T_ = ''
And D5_DATA Between '20230101' and '20230331' and D5_LOTECTL  In ('12220618','12310235')
Group By D5_PRODUTO,D5_ORIGLAN

--SB7 - Lancamentos do Inventario
Select * From SB7010
Where B7_FILIAL ='AE01' and B7_COD = '0902130001' and B7_DATA Between '20230101' and '20230331' and D_E_L_E_T_ ='' 

--SD1 - Entrada Itens NF
SELECT D1_COD,Sum(D1_QUANT) D1_QTDE,D1_TES FROM SD1010 WHERE D1_FILIAL = 'BA01' AND D1_COD In ('0110020020','0110010251')  AND D_E_L_E_T_ = ''
And D1_DTDIGIT Between '20230101' and '20230331' and D1_LOTECTL In ('12220618','12310235')
Group By D1_COD,D1_TES

--SD2 - Saida Itens NF
SELECT D2_COD,Sum(D2_QUANT) D2_QTDE,D2_TES FROM SD2010 WHERE D2_FILIAL = 'BA01' AND D2_COD In ('0110020020','0110010251')  AND D_E_L_E_T_ = ''
And D2_EMISSAO Between '20230101' and '20230331' and D2_LOTECTL In ('12220618','12310235')
Group By D2_COD,D2_TES


--SD4 - Requisicoes Empenhadas
Select * From SD4010
Where D4_FILIAL = 'AE01' and D4_COD In ('0902130001') And D4_QUANT > 0  And  D_E_L_E_T_ = ''
and D4_LOTECTL In ('7230248','7220248')

Select D4_COD,D4_LOTECTL,Sum(D4_QUANT)QTDE From SD4010
Where D4_FILIAL = 'AE01' and D4_COD = '0902130001' And D4_QUANT > 0  And  D_E_L_E_T_ = ''
Group By D4_COD,D4_LOTECTL

Select D4_COD,Sum(D4_QUANT)QTDE From SD4010
Where D4_FILIAL = 'AE01' and D4_COD = '0902130001' And D4_QUANT > 0  And  D_E_L_E_T_ = ''
Group By D4_COD


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