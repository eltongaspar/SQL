-- Cadastro de Produtos
Select B1_RASTRO,B1_NOTAMIN,B1_TIPOCQ,* From SB1010
Where B1_COD In ('0110010008') and D_E_L_E_T_ =''


-- Saldo Fisico e Financeiro (Estoque)
Select B2_QEMP, B2_QATU, * From SB2010
Where B2_COD = '0110010008' and D_E_L_E_T_ = '' and B2_FILIAL = 'BA01'

--Tabela SB8 - Saldos por Lote
SELECT * FROM SB8010 
WHERE B8_PRODUTO='0110010008' AND B8_FILIAL='BA01' AND B8_SALDO > 0

-- Requisições Empenhadas - Consulta
Select D4_OP, * From SD4010
Where D4_FILIAL = 'BA01' and D4_COD in ('0110010008') and D_E_L_E_T_ = '' and D4_QUANT > '0' 


--Movimentações internas
Select * From SD3010
Where D3_FILIAL = 'BA01' and D3_COD in ('0110010008') and D3_EMISSAO >= '20230101' 
and D3_TM in ('020','999') and D3_ESTORNO = ''

--SD5 - Requisicoes por Lote
Select * FRom SD5010
Where D5_FILIAL = 'BA01' and D5_PRODUTO = '0110010008' and D_E_L_E_T_ =''






-- Produtos Complemento 
Select * From SB5010
Where B5_FILIAL = 'BA01' and B5_COD = '0110010008' and D_E_L_E_T_ =''

-- Produto Indicador
Select * From SBZ010
Where BZ_FILIAL = 'BA01' and BZ_COD = '0110010008' and D_E_L_E_T_ =''



