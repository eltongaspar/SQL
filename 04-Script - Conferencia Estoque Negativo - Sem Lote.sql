
Declare @D3_TMENT Real, @D3_TMSAI Real, @D5_TMENT Real, @D5_TMSAI Real,
@D1_ENT Real, @D2_SAI Real , @SDD_QTDE Real, @B9_QTDEINI Real, @BJ_QTDEINI Real,
@PRODINI Char(10), @FILINI Char(4), @DTINI Char(8), @DTFIM Char(8), @DTREF Char(8), @PRODFIM Char(10) , @FILFIM Char(4)

Set @PRODINI = '0000000000'
Set @PRODFIM = '9999999999'
Set @FILINI = 'AA01'
Set @FILFIM = 'ZZ99'
Set @DTINI = '20230401'
Set @DTFIM = '20230431'
Set @DTREF = '2020331'

-- Saldo Fisico e Financeiro (Estoque)
Select B2_FILIAL, B2_COD,B1_RASTRO,B1_TIPO,B1_TIPOCQ,B1_NOTAMIN, B1_DESC, B2_LOCAL, B2_QATU,

--SD3 - Movimentacoes Internas
D3_TMENT = (SELECT Sum(D3_QUANT) FROM SD3010 WHERE D3_FILIAL Between @FILINI And @FILFIM AND D3_COD Between @PRODINI And @PRODFIM
AND D_E_L_E_T_ = '' And D3_EMISSAO Between @DTINI and @DTFIM and D3_TM <= '500' And D3_ESTORNO = ''),

--SD3 - Movimentacoes Internas
D3_TMSAI = (SELECT Sum(D3_QUANT) FROM SD3010 WHERE D3_FILIAL Between @FILINI And @FILFIM AND D3_COD Between @PRODINI And @PRODFIM
AND D_E_L_E_T_ = '' And D3_EMISSAO Between @DTINI and @DTFIM and D3_TM >= '500' and D3_ESTORNO = ''),

--SD1 - Itens das NF de Entrada
D1_ENT = (SELECT Sum(D1_QUANT) FROM SD1010 WHERE D1_FILIAL Between @FILINI And @FILFIM AND D1_COD Between @PRODINI And @PRODFIM
AND D_E_L_E_T_ = '' And D1_DTDIGIT Between @DTINI and @DTFIM),

--SD2 - Itens de Venda da NF
D2_SAI = (Select Sum(D2_QUANT) FROM SD2010 WHERE D2_FILIAL Between @FILINI And @FILFIM AND D2_COD Between @PRODINI And @PRODFIM
AND D_E_L_E_T_ = '' And D2_EMISSAO Between @DTINI and @DTFIM),

--SB9 - Saldos Iniciais
B9_QTDEINI = (SELECT Sum(B9_QINI) FROM SB9010 WHERE B9_FILIAL Between @FILINI And @FILFIM AND B9_COD Between @PRODINI And @PRODFIM
AND D_E_L_E_T_ = '' And B9_DATA = @DTREF And B9_QINI > 0)


From SB2010 SB2


--SB1 - Cadastro de Produtos
Inner Join SB1010 SB1
ON B1_COD = B2_COD	
And SB1.D_E_L_E_T_ = ''

Where B2_COD Between @PRODINI And @PRODFIM And SB2.D_E_L_E_T_ = '' and B2_FILIAL Between @FILINI And @FILFIM  And B2_QATU < 0
And B1_DESC Not Like ('%MOD%')
GROUP BY B2_FILIAL, B2_COD,B1_DESC,B1_RASTRO,B1_TIPOCQ,B1_NOTAMIN, B1_TIPO, B2_LOCAL, B2_QATU,B1_UM




-----------------------------------------------------------------------------

SELECT B2_FILIAL, B2_COD,B1_DESC B2_LOCAL, B2_QATU,
	
Case 
When B2_QATU < 0 Then 'Errado'
Else 'Certo'
End AS Status_

FROM SB2010 
	INNER JOIN SB1010 SB1
	ON B1_COD=B2_COD 
	AND SB1.D_E_L_E_T_='' 
	
WHERE  SB2010.D_E_L_E_T_='' AND B2_QATU <0 and B2_COD Not Like ('%MOD%')
GROUP BY B2_FILIAL, B2_COD,B1_DESC, B2_LOCAL, B2_QATU
ORDER BY 1