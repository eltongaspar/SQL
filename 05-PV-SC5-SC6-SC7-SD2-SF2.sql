--SC5 - Pedidos de Venda
Select * From SC5010
Where C5_FILIAL ='BA03'and  C5_NUM ='029791' and D_E_L_E_T_=''

--SC6 - Itens dos Pedidos de Venda
Select C6_LOTECTL,* From SC6010
Where C6_FILIAL ='BA03'and  C6_NUM ='029791' and D_E_L_E_T_=''

--SC9 - Pedidos Liberados
SELECT C9_LOTECTL, * FROM SC9010 
WHERE C9_FILIAL='BA03' AND C9_PEDIDO In ('029833') AND D_E_L_E_T_=''

-- Saldo Fisico e Financeiro (Estoque)
Select B2_QEMP,B2_QEMPSA ,B2_QATU, * From SB2010
Where B2_COD In ('0100019201') and D_E_L_E_T_ = '' and B2_FILIAL = 'BA03'


--SB8 - Saldos por Lote
SELECT B8_EMPENHO, * FROM SB8010 
WHERE B8_PRODUTO='0100019201' AND D_E_L_E_T_='' AND B8_FILIAL='BA03' AND B8_SALDO>0
Order By B8_DATA

SELECT SUM (B8_SALDO) FROM SB8010 
WHERE B8_PRODUTO='0100019201' AND D_E_L_E_T_='' AND B8_FILIAL='BA03' AND B8_SALDO>0

--SDD - Bloqueio de Lotes
SELECT DD_OBSERVA, * FROM SDD010 
WHERE DD_FILIAL='BA03' AND DD_PRODUTO='0100019201' AND D_E_L_E_T_=''



               
--NF Saida Cab.
Select D_E_L_E_T_,F2_EMISSAO, F2_DTLANC, * From SF2010
Where F2_FILIAL ='BA03' and F2_DOC ='000050222' and D_E_L_E_T_=''


--NF Saida Itens
Select D_E_L_E_T_,D2_EMISSAO,D2_NFORI, D2_LOTECTL, * From SD2010
Where D2_FILIAL ='BA03' and D2_COD = '0100019201' and D_E_L_E_T_='' and D2_CLIENTE = '000582' and D2_DOC = '000050222'

               
--NF Entrada Cab.
Select D_E_L_E_T_,F1_EMISSAO, F1_DTLANC, * From SF1010
Where F1_FILIAL ='BA003' and F1_P ='000004705' and D_E_L_E_T_=''

--NF Entrada Itens
Select D_E_L_E_T_,D1_EMISSAO,D1_NFORI, D1_CC,D1_DOC, * From SD1010
Where D1_FILIAL ='BA03' and D1_DOC ='000004705' and D_E_L_E_T_ ='' and D1_EMISSAO >= '20220101'

-- Cadastro de Produtos
Select B1_RASTRO,* From SB1010
Where B1_COD = '0100019201'

