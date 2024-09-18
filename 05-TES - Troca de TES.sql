-- TES - Troca de TES
--TIPOS DE ENTRADA E SAIDA (TES)
Select F4_PODER3,* From SF4010
Where F4_CODIGO in ('723','903') and D_E_L_E_T_=''


-- Saldo Fisico e Financeiro (Estoque)
Select B2_QEMP, B2_QATU, B2_QEMPSA, * From SB2010
Where B2_COD = '0100030035' and D_E_L_E_T_ = '' and B2_FILIAL = 'BA01'

--Tabela SB8 - Saldos por Lote
SELECT * FROM SB8010 
WHERE B8_PRODUTO='0100030035' AND B8_FILIAL='BA01' AND B8_SALDO > 0 and D_E_L_E_T_='' and B8_LOTECTL = '3211616'

-- Consulta Estoque Terceiros 
Select * From SB6010
Where B6_FILIAL = 'AC01' and B6_PRODUTO in ('1090060798') and B6_SALDO > 0


-- NF de Saida - Cabeçalho
Select F2_CLIENTE, F2_LOJA, F2_HORA, * From SF2010 
Where F2_FILIAL = 'AC01' and F2_DOC = '000012298'

-- NF de Saida - itens 
Select D2_LOJA, D2_CLIENTE, D2_DOC, D2_PEDIDO, * From SD2010 
Where D2_FILIAL = 'AC01'and D2_DOC = '000012298' 
and D2_EMISSAO >= '20211129' and D2_COD = '0200500001'


-- NF de Entrada - cabeçalho
Select * From SF1010
Where F1_FILIAL = 'EC01' and F1_DOC = '000038085'

-- NF de Entrada - itens 
Select * From SD1010 
Where D1_FILIAL = 'EC01' and D1_DOC = '000038085'

--Livros Fiscais por item da NF
Select * From SFT010
Where FT_PRODUTO = '0200500001' and FT_NFISCAL = '000007574' and FT_FILIAL = 'BA03'


--MOVIMENTAÇÕES INTERNAS
Select * from SD3010
Where D3_FILIAL = 'BA03' and D3_COD = '0200500001' and D3_ESTORNO = '' and D_E_L_E_T_='' and D3_PARCTOT = 'T'

-- Contas a receber
Select * From SE1010
Where E1_FILIAL = 'BA' and E1_NUM = '000007574'


-- Consulta produto se possui controle de lote
--Consulta Código Produto
Select B1_RASTRO,* From SB1010
Where B1_COD = '1090060798' 


-- SB9 - Saldos Iniciais
Select * From SB9010
Where B9_COD ='1090060798' and B9_FILIAL = 'AC01' and D_E_L_E_T_=''
