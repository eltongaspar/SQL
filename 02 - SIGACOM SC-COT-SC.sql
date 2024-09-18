Declare @FILIAL Char(4), @NUMPC Char(6), @NUMCOT Char(6), @NUMSC Char(6)
SET @FILIAL = '01' 
SET @NUMPC = '008488'
SET @NUMCOT = '006880'
SET @NUMSC = '146326'

-- NF de Entrada - itens
-- Veficar se PC n�o teve movimenta��es Fiscais de Entrada
Select D1_TES, D1_PEDIDO,D_E_L_E_T_, * From SD1010 
Where D1_FILIAL = @FILIAL and D1_PEDIDO In (@NUMPC) and D_E_L_E_T_='' 

Select Sum (D1_QUANT) AS Total From SD1010 
Where D1_FILIAL = @FILIAL and D1_PEDIDO in (@NUMPC) and D_E_L_E_T_='' 

-- Pedido Compra
SELECT C7_EMISSAO,C7_FILIAL, C7_PRODUTO, C7_NUM, C7_NUMCOT, C7_NUMSC, C7_FORNECE, C7_LOJA, C7_QUJE, C7_CONAPRO, C7_QUANT, C7_RESIDUO, C7_ENCER, * FROM SC7010 
WHERE C7_FILIAL = @FILIAL AND C7_NUM in (@NUMPC) and D_E_L_E_T_ = ''

SELECT Sum (C7_QUANT) AS QUANT, Sum (C7_QUJE) as Entrega   FROM SC7010 
WHERE C7_FILIAL=@FILIAL AND C7_NUM in (@NUMPC) and D_E_L_E_T_ = ''

--Cota��es
SELECT C8_EMISSAO,C8_FILIAL, C8_PRODUTO, C8_NUMPED,C8_NUM,C8_NUMSC, C8_FORNECE, C8_LOJA, * FROM SC8010 
WHERE C8_FILIAL=@FILIAL AND C8_NUM = @NUMCOT AND D_E_L_E_T_='' and NOT C8_NUMPED = 'XXXXXX' and C8_NUMPED in (@NUMPC)

-- Solicita��o de compra
Select C1_EMISSAO,C1_FILIAL, C1_PRODUTO, C1_PEDIDO, C1_COTACAO, C1_NUM, C1_FORNECE, C1_LOJA, * From SC1010
Where C1_FILIAL = @FILIAL and C1_NUM = @NUMSC and D_E_L_E_T_ = '' and C1_PEDIDO = @NUMPC

--SCR - Documentos com Alcada
Select CR_DATALIB, CR_EMISSAO,* From SCR010
Where CR_FILIAL = @FILIAL and CR_NUM = @NUMPC and D_E_L_E_T_ =''
--CR_STATUS - 01=Aguardando nivel anterior;02=Pendente;03=Liberado;04=Bloqueado;05=Liberado outro aprov.;06=Rejeitado;07=Rej/Bloq outro aprov.

--DBM - Itens de Doc. com Al�ada
Select * From DBM010
Where DBM_FILIAL = @FILIAL and DBM_NUM = @NUMPC and D_E_L_E_T_ =''


SELECT C1_NUM,C1_APROV FROM SC7010
INNER JOIN SC1010 ON C1_FILIAL=C7_FILIAL AND C1_NUM=C7_NUMSC AND C1_ITEM=C7_ITEMSC AND C1_PRODUTO=C7_PRODUTO
WHERE C7_FILIAL='01' AND C7_NUM='00848' AND SC7010.D_E_L_E_T_=''


