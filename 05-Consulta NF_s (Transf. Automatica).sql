--Consulta Cadastros - Transferencias Automaticas
Select ZB_FILORIG, ZB_FILDEST, ZB_TESDEST, * From SZB010
Where D_E_L_E_T_ = '' and ZB_PRODUTO In ('5170000001') and ZB_FILORIG = 'BA07' and ZB_FILDEST = 'BA01'
Order By 1

--SF4 - Tipos de Entrada e Saida
Select * From SF4010
Where F4_CODIGO = '096'

-- NF de Saida - Cabeçalho
Select F2_CLIENTE, F2_LOJA, F2_HORA, * From SF2010 
Where F2_FILIAL = 'BA07' and F2_DOC in ('000000272') and D_E_L_E_T_=''

-- NF de Saida - itens 
Select D2_LOJA, D2_CLIENTE, D2_DOC, D2_PEDIDO,D2_TES, * From SD2010 
Where D2_FILIAL = 'BA07' and D2_DOC in ('000000272') and D_E_L_E_T_ =''
--and D2_EMISSAO >= '20211201' and D2_COD = '0120010792'


-- NF de Entrada - cabeçalho
Select * From SF1010
Where F1_FILIAL = 'BA01' and F1_DOC in ('000000272') and D_E_L_E_T_='' and F1_EMISSAO >= '20230101'
--and F1_CHVNFE = '35220171449201000119550010008817161623014347'

-- NF de Entrada - itens 
Select D1_TES,* From SD1010 
Where D1_FILIAL = 'BA01' and D1_DOC in ('000000272') and D_E_L_E_T_='' and D1_EMISSAO >= '20230101'

--Consulta Código Produto
Select * From SB1010
Where B1_COD In ('0100130050','0100120050')  
--or B1_DESC = 'GLICERINA BI-DESTILADA'


-- Consulta Cliente
Select * From SA1010
Where A1_COD = '000276' and A1_LOJA = '05'

-- Consulta Fornecedor
Select * From SA2010
Where A2_COD = '000108' and A2_LOJA = '03'

-- SB9 - Saldos Iniciais
Select * From SB9010
Where B9_COD ='0660080506' and B9_FILIAL = 'BA11'