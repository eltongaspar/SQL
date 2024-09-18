-- Saldo Fisico e Financeiro (Estoque)
Select B2_QEMP, B2_QATU, * From SB2010
Where B2_COD = '0100040035' and D_E_L_E_T_ = '' and B2_FILIAL = 'BA01'

--

-- Requisições Empenhadas - Total Empenhado
Select D4_COD, SUM (D4_QTDEORI) From SD4010
Where D4_FILIAL = 'BA01' and D4_COD in ('3211805') and D_E_L_E_T_ = '' and D4_QUANT > '0'
Group By (D4_COD)

-- Requisições Empenhadas - Consulta
Select D4_OP, * From SD4010
Where D4_FILIAL = 'BA01' and D4_COD in ('0100040035') and D_E_L_E_T_ = '' and D4_QUANT > '0' 
and D4_OP in ('0010951001', '0010961001')

-- SC2 - Ordens de Producao
Select * From SC2010
Where C2_FILIAL = 'BA11' and C2_PRODUTO = '0210050045' and C2_QUJE > '0'

--Tabela SCP - Solicitacoes ao Armazem
Select * From SCP010
Where CP_FILIAL = 'BA02' and CP_PRODUTO = '0210050045' and CP_STATUS = 'E' and D_E_L_E_T_ = ''

-- Tabela SC6 - Itens dos Pedidos de Venda
Select * From SC6010
Where C6_FILIAL = 'BA03' and C6_PRODUTO = '0210050151' and D_E_L_E_T_ = ''

--Tabela SB8 - Saldos por Lote
SELECT * FROM SB8010 
WHERE B8_PRODUTO='0100040035' AND B8_FILIAL='BA01' AND B8_SALDO > 0 and B8_LOTEFOR = '3211805'


-- SB9 - Saldos Iniciais
Select * From SB9010
Where B9_COD ='0660080506' and B9_FILIAL = 'BA11'


-- Tabela SG1 - Estruturas dos Produtos
Select * From SG1010
Where G1_FILIAL = 'BA11' and G1_COD = '0400700021'

-- NF de Entrada - Itens
Select * From SD1010 
--Where D1_COD = '5701000501' and D1_FILIAL = 'EA01' and D1_DTDIGIT > '20211201'
Where D1_PEDIDO = '000872' and D1_COD = '5701000501'

-- Cadastro de Produtos
Select * From SB1010
Where B1_COD = '0100040035'

-- Saldos Iniciais
Select * From SB9010
Where B9_COD = '0660080569'

--Livros Fiscais por item da NF
Select * From SFT010
Where FT_PRODUTO = '0660080569'