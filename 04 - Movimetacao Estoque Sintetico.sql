Declare @D3_TMENT Real, @D3_TMSAI Real, @D5_TMENT Real, @D5_TMSAI Real,
@D1_ENT Real, @D2_SAI Real , @SDD_QTDE Real, @B9_QTDEINI Real, @BJ_QTDEINI Real,
@PROD Char(10), @FIL Char(4), @DTINI Char(8), @DTFIM Char(8), @DTREF Char(8)

Set @PROD = '1140902401'
Set @FIL = '01'
Set @DTINI = '20231231'
Set @DTFIM = '20231201' 
Set @DTREF = '20231231'

-- Saldo Fisico e Financeiro (Estoque)
Select B2_FILIAL, B2_COD,B1_LOCALIZ,B1_RASTRO,B1_TIPO,B1_TIPOCQ,B1_NOTAMIN, B1_DESC, B2_LOCAL, B2_QATU,  Isnull(SUM(B8_SALDO),'') B8_SOMA,B1_UM,


BF_ENT = (Select  Isnull(Sum(BF_QUANT),'') FROM SBF010 With(NoLock)
			WHERE BF_FILIAL = @FIL AND BF_PRODUTO = @PROD  AND D_E_L_E_T_ = ''
			and BF_LOCAL = B2_LOCAL),

 BF_EMP = (Select  Isnull(Sum(BF_EMPENHO),'') FROM SBF010 With(NoLock)
			WHERE BF_FILIAL = @FIL AND BF_PRODUTO = @PROD  AND D_E_L_E_T_ = ''
			and BF_LOCAL = B2_LOCAL),

D3_TMENT = (SELECT  Isnull(Sum(D3_QUANT),'') FROM SD3010 With(NoLock) 
			WHERE D3_FILIAL = @FIL AND D3_COD = @PROD  AND D_E_L_E_T_ = ''
			And D3_EMISSAO Between @DTINI and @DTFIM and D3_TM <= '500' And D3_ESTORNO = '' And D3_LOCAL = B2_LOCAL),

D3_TMSAI = (SELECT  Isnull(Sum(D3_QUANT),'') FROM SD3010 With(NoLock) 
			WHERE D3_FILIAL = @FIL AND D3_COD = @PROD  AND D_E_L_E_T_ = ''
			And D3_EMISSAO Between @DTINI and @DTFIM and D3_TM >= '500' and D3_ESTORNO = '' and D3_LOCAL = B2_LOCAL),

D5_TMENT = (SELECT  Isnull(Sum(D5_QUANT),'') FROM SD5010 With(NoLock) 
			WHERE D5_FILIAL = @FIL AND D5_PRODUTO = @PROD  AND D_E_L_E_T_ = ''
			And D5_DATA Between @DTINI and @DTFIM and D5_ORIGLAN <= '500' And D5_ESTORNO = '' and D5_LOCAL = B2_LOCAL),

D5_TMSAI = (SELECT  Isnull(Sum(D5_QUANT),'') FROM SD5010 With(NoLock) 
			WHERE D5_FILIAL = @FIL AND D5_PRODUTO = @PROD  AND D_E_L_E_T_ = ''
			And D5_DATA Between @DTINI and @DTFIM and D5_ORIGLAN >= '500' And D5_ESTORNO = '' and D5_LOCAL = B2_LOCAL),

D1_ENT = (SELECT  Isnull(Sum(D1_QUANT),'') FROM  SD1010 With(NoLock) 
			WHERE D1_FILIAL = @FIL AND D1_COD = @PROD  AND D_E_L_E_T_ = ''
			And D1_DTDIGIT Between @DTINI and @DTFIM and D1_LOCAL = B2_LOCAL),

D2_SAI = (Select  Isnull(Sum(D2_QUANT),'') FROM SD2010 With(NoLock) 
			WHERE D2_FILIAL = @FIL AND D2_COD = @PROD  AND D_E_L_E_T_ = ''
			And D2_EMISSAO Between @DTINI and @DTFIM and D2_LOCAL = B2_LOCAL),

DB_ENT = (Select  Isnull(Sum(DB_QUANT),'') FROM SDB010 With(NoLock)
			WHERE DB_FILIAL = @FIL AND DB_PRODUTO = @PROD  AND D_E_L_E_T_ = ''
			And DB_DATA Between @DTINI and @DTFIM and DB_TM < '500' And DB_ESTORNO = '' and DB_LOCAL = B2_LOCAL),

DB_SAI = (Select  Isnull(Sum(DB_QUANT),'') FROM SDB010 WHERE DB_FILIAL = @FIL AND DB_PRODUTO = @PROD  AND D_E_L_E_T_ = ''
And DB_DATA Between @DTINI and @DTFIM and DB_TM >= '500' And DB_ESTORNO = '' and DB_LOCAL = B2_LOCAL),

DA_ENT = (Select  Isnull(Sum(DA_SALDO),'') FROM SDA010 With(NoLock) 
			WHERE DA_FILIAL = @FIL AND DA_PRODUTO = @PROD  AND D_E_L_E_T_ = ''
			And DA_DATA Between @DTINI and @DTFIM And DA_SALDO > 0 and DA_LOCAL = B2_LOCAL ),

DA_SAI = (Select  Isnull(Sum(DA_QTDORI),'') FROM SDA010 With(NoLock) 
			WHERE DA_FILIAL = @FIL AND DA_PRODUTO = @PROD  AND D_E_L_E_T_ = ''
			And DA_DATA Between @DTINI and @DTFIM and  DA_LOCAL = B2_LOCAL),

DC_ENT = (Select  Isnull(Sum(DC_QUANT),'') FROM SDC010 With(NoLock) 
			WHERE DC_FILIAL = @FIL AND DC_PRODUTO = @PROD  AND D_E_L_E_T_ = ''
			And DC_DTLIB Between @DTINI and @DTFIM and DC_QUANT > 0 and DC_LOCAL = B2_LOCAL  ),

DC_ENT = (Select  Isnull(Sum(DC_QTDORIG),'') FROM SDC010 With(NoLock) 
			WHERE DC_FILIAL = @FIL AND DC_PRODUTO = @PROD  AND D_E_L_E_T_ = ''
			And DC_DTLIB Between @DTINI and @DTFIM and DC_LOCAL = B2_LOCAL ),

D7_ENT = (Select Isnull(Sum(D7_SALDO),'') From SD7010 SD72 With(NoLock)
			Where D7_FILIAL = @FIL AND D7_PRODUTO = @PROD  AND D_E_L_E_T_ = ''
			And D7_DATA Between  @DTINI and @DTFIM And D7_TIPO = '0' and D7_ESTORNO  In ('','S')),

D7_SAI = (Select Isnull(Sum(D7_QTDE),'') From SD7010 SD72 With(NoLock)
			Where D7_FILIAL = @FIL AND D7_PRODUTO = @PROD  AND D_E_L_E_T_ = ''
			And D7_DATA Between  @DTINI and @DTFIM And D7_TIPO In ('1') and D7_ESTORNO In ('')) +
		(Select Isnull(Sum(D7_SALDO),'') From SD7010 SD72 With(NoLock) 
			Where D7_FILIAL = @FIL AND D7_PRODUTO = @PROD  AND D_E_L_E_T_ = ''
			And D7_DATA Between  @DTINI and @DTFIM And D7_TIPO In ('6','7') and D7_ESTORNO In ('')),

SDD_QTDE = (Select  Isnull(Sum(DD_QUANT),'') From SDD010 With(NoLock) 
			Where DD_PRODUTO = @PROD and DD_FILIAL = @FIL 
			And DD_SALDO > 0 and D_E_L_E_T_='' and DD_LOCAL = B2_LOCAL),

B9_QTDEINI = (SELECT  Isnull(Sum(B9_QINI),'') FROM SB9010 With(NoLock) 
				WHERE B9_FILIAL = @FIL AND B9_COD = @PROD AND D_E_L_E_T_ = '' 
				And B9_DATA = @DTREF And B9_QINI > 0),

BJ_QTDEIN = (SELECT  Isnull(Sum(BJ_QINI),'') FROM SBJ010 With(NoLock) 
				WHERE BJ_FILIAL = @FIL AND BJ_COD = @PROD AND D_E_L_E_T_ = '' 
				And BJ_DATA = @DTREF And BJ_QINI > 0),

BK_QTDEIN = (SELECT  Isnull(Sum(BK_QINI),'') FROM SBK010 With(NoLock)
				WHERE BK_FILIAL = @FIL AND BK_COD = @PROD AND D_E_L_E_T_ = '' 
				And BK_DATA = @DTREF And BK_QINI > 0)

From SB2010 SB2 With(NoLock)

--SB8 - Saldos por Lote
Left Join SB8010 SB8 With(NoLock)
ON B8_PRODUTO = B2_COD	
And B8_FILIAL = B2_FILIAL
And B8_LOCAL = B2_LOCAL
And SB8.D_E_L_E_T_ = ''

--SB8 - Saldos por Endereço
Left Join SBK010 SBK With(NoLock)
ON BK_COD = B2_COD	
And BK_FILIAL = B2_FILIAL
And BK_LOCAL = B2_LOCAL
And SBK.D_E_L_E_T_ = ''

--SB1 - Cadastro de Produtos
Inner Join SB1010 SB1 With(NoLock)
ON B1_COD = B2_COD	
And SB1.D_E_L_E_T_ = ''

/*--SD3 - Movimentacoes Internas
Inner Join SD3010 SD3
On D3_COD = B2_COD
And D3_FILIAL= B2_FILIAL
And D3_EMISSAO Between '20221101' and '20221130'
And D3_ESTORNO = ''
And SD3.D_E_L_E_T_ =''*/


Where B2_COD In (@PROD) and SB2.D_E_L_E_T_ = '' and B2_FILIAL = @FIL and B2_QATU >= 0
GROUP BY B2_FILIAL, B2_COD,B1_DESC,B1_LOCALIZ,B1_RASTRO,B1_TIPOCQ,B1_NOTAMIN, B1_TIPO, B2_LOCAL, B2_QATU,B1_UM


