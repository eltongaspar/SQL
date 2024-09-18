-- Saldo Fisico e Financeiro (Estoque)
Select B2_QEMP,B2_QEMPSA ,B2_RESERVA,B2_QATU, * From SB2010
Where B2_COD = '0200500001' and D_E_L_E_T_ = '' and B2_FILIAL = 'BA11'

--

-- Requisições Empenhadas - Total Empenhado
Select D4_COD, SUM (D4_QTDEORI) From SD4010
Where D4_FILIAL = 'BA11' and D4_COD in ('0200500001') and D_E_L_E_T_ = '' and D4_QUANT > '0'
Group By (D4_COD)

-- Requisições Empenhadas - Consulta
Select D4_OP, * From SD4010
Where D4_FILIAL = 'BA11' and D4_COD in ('0200500001') and D_E_L_E_T_ = '' and D4_QUANT > '0' 
and D4_OP in ('0010951001', '0010961001')

-- SC2 - Ordens de Producao
Select * From SC2010
Where C2_FILIAL = 'BA11' and C2_PRODUTO = '0200500001' and C2_QUJE = 0  and C2_DATRF = ''

--Tabela SCP - Solicitacoes ao Armazem
Select * From SCP010
Where CP_FILIAL = 'BA11' and CP_PRODUTO = '0200500001' and CP_STATUS = 'E' and D_E_L_E_T_ = ''

-- Tabela SC6 - Itens dos Pedidos de Venda
Select C6_RESERVA,C6_QTDEMP,* From SC6010
Where C6_FILIAL = 'BA11' and C6_PRODUTO = '0200500001' and D_E_L_E_T_ = '' and C6_QTDVEN <> C6_QTDENT

--Tabela SB8 - Saldos por Lote
SELECT * FROM SB8010 
WHERE B8_PRODUTO='0200500001' AND B8_FILIAL='BA11' AND B8_SALDO > 0 --and B8_LOTEFOR = '3211805'


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