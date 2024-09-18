-- TES - Troca de TES
--TIPOS DE ENTRADA E SAIDA (TES)
--FA01
Select F4_PODER3,* From SF4010
Where F4_CODIGO in ('700','804') and D_E_L_E_T_=''

--FF01
Select F4_PODER3,* From SF4010
Where F4_CODIGO in ('471','387') and D_E_L_E_T_=''

Select F4_PODER3,* From SF4010
Where F4_CODIGO in ('804','387') and D_E_L_E_T_=''

-- NF de Saida - Cabeçalho
Select F2_CLIENTE, F2_LOJA, F2_HORA,F2_NFORI,F2_SERIORI, * From SF2010 
Where F2_FILIAL = 'FA01' and F2_DOC In ('000012112') and D_E_L_E_T_=''

-- NF de Saida - itens 
Select D2_LOJA, D2_CLIENTE, D2_DOC, D2_PEDIDO,D2_NFORI, D2_SERIORI,D2_IDENTB6, * From SD2010 
Where D2_FILIAL = 'FA01'and D2_DOC In ('000012112','000001899') and D_E_L_E_T_=''
--and D2_EMISSAO >= '20211129' and D2_COD = '0200500001'


-- NF de Entrada - cabeçalho
Select F1_NFORIG,F1_SERORIG,F1_ID* From SF1010
Where F1_FILIAL = 'FF01' and F1_DOC In ('000012112','000001889') and D_E_L_E_T_=''

-- NF de Entrada - itens  - 9AHFVO - antes 9AI2ON
Select D1_NFORI,D1_SERIORI, D1_IDENTB6, * From SD1010 
Where D1_FILIAL = 'FF01' and D1_NFORI <>'' and D1_DOC In ('000012112','000001889') and D_E_L_E_T_=''

--Livros Fiscais por item da NF
Select FT_NFORI, FT_SERORI,* From SFT010
Where FT_PRODUTO = '1090061267' and FT_NFISCAL = '000012112' and FT_FILIAL In ('FA01','FF01') and D_E_L_E_T_=''

--SF3 - Livros Fiscais
Select * From SF3010
Where F3_NFISCAL = '000012112' and F3_FILIAL In ('FA01','FF01') and D_E_L_E_T_=''


-- Saldo Fisico e Financeiro (Estoque)
Select B2_QEMP, B2_QATU, B2_QEMPSA, * From SB2010
Where B2_COD = '1090061267' and D_E_L_E_T_ = '' and B2_FILIAL In ('FA01','FF01')

-- Consulta Estoque Terceiros 
Select B6_SALDO,* From SB6010
Where B6_FILIAL In ('FA01','FF01') and B6_PRODUTO in ('1090061267') and B6_SALDO > 0 and B6_DOC In ('000012112','000001899') and D_E_L_E_T_=''

-- Consulta Estoque Terceiros 
Select B6_SALDO,* From SB6010
Where B6_FILIAL In ('FA01','FF01') and B6_PRODUTO in ('1090061267') and B6_DOC In ('000001899','000012112') and D_E_L_E_T_=''

-- Consulta Estoque Terceiros 
Select B6_SALDO,* From SB6010
Where B6_IDENTB6 = '9AI2ON'