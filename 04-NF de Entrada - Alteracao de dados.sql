-- Cabeçalho da NF
Select * From SF1010 
Where F1_FILIAL = 'BA15'and F1_FORNECE = '010192' and F1_DOC = '000000683' and D_E_L_E_T_=''

-- Itens da NF de entrada 
Select D1_PEDIDO, * From SD1010 
Where D1_FILIAL = 'BA15' and D1_FORNECE = '010192' and D1_DOC = '000000683' and D_E_L_E_T_=''
--Consulta Pedido 
Select D1_PEDIDO, * From SD1010 
Where D1_FILIAL = 'BA15' and D1_PEDIDO = '000754' and D_E_L_E_T_=''

-- Livro Fiscal por item
Select * From SFT010 
Where FT_FILIAL = 'BA15'and FT_CLIEFOR = '010192' and FT_NFISCAL = '000000683' and D_E_L_E_T_=''

-- Livro Fiscal 
Select * From SF3010
Where F3_CLIEFOR = '010192' and F3_NFISCAL = '000000683' and D_E_L_E_T_=''

 --Contas a pagar (Financeiro)
Select * From SE2010
Where E2_FILORIG = 'BA15' and E2_FORNECE = '010192' and E2_NUM = '000000683' and D_E_L_E_T_=''

-- Consulta Fornecedor
Select A2_MSBLQL, * From SA2010
Where A2_COD = '010192' or A2_CGC = '17469701002897'

--SC7 - Ped.Compra / Aut.Entrega
Select C7_QUJE,C7_NUM,* From SC7010
Where C7_FILIAL = 'BA15' and C7_NUM = '000754'
