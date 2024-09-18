-- Diferenças de qtde de produtos em estoque 
-- Rodar Refaz Emp. Especifico (Mod. 97)
-- SB2xSB8 tem que estarem iguais

--SB2 - Saldos Fisico e Financeiro
SELECT B2_QEMP, B2_QEMPSA, * FROM SB2010 
WHERE B2_COD='1090061267' AND D_E_L_E_T_='' AND B2_FILIAL In ('FA01','FF01')

 -- Saldos Iniciais 
 Select * From SB9010
 Where B9_FILIAL = 'CA01' and B9_COD = '0120710154' and D_E_L_E_T_='' and B9_DATA >= '20220501'

-- Consulta Estoque Terceiros 
Select * From SB6010
Where B6_FILIAL In ('FA01','FF01') and B6_PRODUTO in ('1090061267') and B6_SALDO > 0

Select Sum(B6_SALDO) TOTAL, B6_FILIAL From SB6010
Where B6_FILIAL In ('FA01','FF01') and B6_PRODUTO in ('1090061267') and B6_SALDO > 0
Group By B6_FILIAL

--SB8 - Saldos por Lote
SELECT B8_EMPENHO, * FROM SB8010 
WHERE B8_PRODUTO='0660080014' AND D_E_L_E_T_='' AND B8_FILIAL='BA11' AND B8_SALDO>0

SELECT SUM (B8_SALDO) FROM SB8010 
WHERE B8_PRODUTO='0660080014' AND D_E_L_E_T_='' AND B8_FILIAL='BA11' AND B8_SALDO>0

--SB8 - Saldos por Lote
Select SUM (B8_SALDO), B8_LOTECTL,B8_LOCAL,B8_DTVALID  From SB8010
Where B8_FILIAL = 'BA01' and B8_PRODUTO In  ('0110010049') and D_E_L_E_T_='' and B8_SALDO > '0'
Group By B8_LOTECTL, B8_LOCAL,B8_DTVALID



--SD7 - Movimentacoes de CQ
Select * From SD7010
Where D7_FILIAL In ('BA01') and D7_PRODUTO In ('0210050088') and D7_LOTECTL In ('AUTO060007') and D_E_L_E_T_=''


--SDD - Bloqueio de Lotes
SELECT DD_OBSERVA, * FROM SDD010 
WHERE DD_FILIAL='BA11' AND DD_PRODUTO='0660080014 ' AND D_E_L_E_T_=''

--SD4 - Requisicoes Empenhadas
Select * From SD4010
Where D4_FILIAL = 'BA01' and D4_COD = '0660080014' and D4_QUANT > '0' and D_E_L_E_T_ =''

--SD4 - Requisicoes Empenhadas
Select SUM (D4_QUANT) TOTAL_EMPENHADO From SD4010
Where D4_FILIAL = 'BA01' and D4_COD = '0660080014' and D4_QUANT > '0' and D_E_L_E_T_ =''


--Tabela SCP - Solicitacoes ao Armazem
Select * From SCP010
Where CP_FILIAL = 'BA01' and CP_PRODUTO = '0660080014' and CP_STATUS = 'E' and D_E_L_E_T_ = ''


--SG1 - Estruturas dos Produtos
SELECT * FROM SG1010 WHERE G1_FILIAL='BA11' AND G1_COMP LIKE '010%'

SELECT * FROM SG1010 WHERE G1_FILIAL='BA11' AND G1_COD = '0660080014'

-- Cadastro de Produtos
Select B1_RASTRO, B1_NOTAMIN, B1_TIPOCQ,B1_IMPORT,* From SB1010
Where B1_COD = '0210050088'



-- SE4 - Condicoes de Pagamento
Select * From SE4010 
Where E4_TIPO = '1' and D_E_L_E_T_='' and E4_DESCRI Like '%90 DIAS FORA%'