 -- Pesagem de materiais - Em estoque sem Reserva/Empenho
Select ZL_NUM,ZL_NUMETIQ,ZL_NUMBOB,ZL_STATUS,ZL_COMENTS,ZL_ZZEID,ZL_UNMOV,
* From SZL010 SZL

	Inner Join SZE010 SZE -- Etiquetas Bobinas
	On ZE_NUMBOB = ZL_NUMBOB
	And ZE_FILIAL = ZL_FILIAL
	And ZE_STATUS Not in  ('F','C') 
	And ZE_PEDIDO In ('000001')
	And SZE.D_E_L_E_T_ = ''
	
Where ZL_STATUS In ('P') And ZL_PEDIDO In ('000001') And ZL_UNMOV > 0
And SZL.D_E_L_E_T_ =' '
Order by 1
-- ZL_NUMBOB - Numero Bobina
--A=A Processar;P=Processado;C=Cancelado;E=Erro Processamento;Q=Bloq. CQ   


---- Etiquetas de Bobinas -- Em estoque sem Reserva/Empenho
Select ZE_SITUACA,ZE_CTRLE,ZE_DTLIB ,
* From SZE010 SZE

	Inner Join SZL010 SZL
	On ZL_NUMBOB = ZE_NUMBOB
	And ZL_FILIAL = ZE_FILIAL
	And ZL_PRODUTO = ZE_PRODUTO
	And ZL_PEDIDO = '000001' 
	And ZL_STATUS = 'P'
	And ZL_UNMOV <> ''
	And SZL.D_E_L_E_T_ = ''

Where ZE_STATUS Not in  ('F','C') And ZE_PEDIDO In ('000001') And ZE_CTRLE = ''
and SZE.D_E_L_E_T_ = ''
Order By 4
--ZE_NUMBOB - Numero Bobina
--I=Import..;C=Canc.;R=Recebida;P=A Liberar;E=Empenh.;F=Faturada;T=Estoque;A=Adiantada;X=Expedida;D=Devolv.;V=Reserv.;N=Res.Conf. 



--CONTROLE NEGOCIO VENDAS  -- Reserva Portal     
Select ZZV_ID,ZZV_NUMBOB,ZZV_STATUS,ZZV_PEDIDO,ZZV_ITEM,ZZV_PRODUT,* From ZZV010 ZZV

	Inner Join SZE010 SZE -- Etiquetas de Bobinas
	On ZZV_ID = ZE_CTRLE
	And ZZV_FILIAL = ZE_FILIAL
	And ZZV_NUMBOB = ZE_NUMBOB
	And ZZV_PRODUT = ZE_PRODUTO
	And ZE_STATUS Not in  ('F','C')
	And SZE.D_E_L_E_T_ = ''

Where ZZV.D_E_L_E_T_ = ''


-- PV Itens -- Itens Empenhados prduzidos
Select C6_QTDVEN,C6_QTDENT,C9_QTDLIB,
(C6_QTDVEN-C6_QTDENT) AS SALDO, (C6_QTDVEN-C9_QTDLIB) As BLOQ,DC_QUANT,BF_QUANT,
ZZF_ID,DC_PEDIDO,C6_NUM,C9_PEDIDO,C5_NUM,BF_LOCALIZ,
* From SC6010 SC6 With(NoLock) -- PV Itens

	Inner Join SC5010 SC5 With(NoLock) -- PV Cab.
	On C5_FILIAL = C6_FILIAL
	And C5_NUM = C6_NUM
	And C5_NOTA Not In ('XXXXXX')
	And C5_NOTA = ('') -- PV em Aberto
	And SC5.D_E_L_E_T_ = ''

	Inner Join SC9010 SC9 With(NoLock) -- PV Liberados 
	On C9_FILIAL = C6_FILIAL
	And C9_PEDIDO = C6_NUM
	And C9_PRODUTO = C6_PRODUTO
	And C9_ITEM = C6_ITEM
	And SC9.D_E_L_E_T_ = ''

	Inner Join SDC010 SDC With(NoLock) --Composição do Empenho     
	On DC_FILIAL = C6_FILIAL
	And DC_PEDIDO = C6_NUM
	And DC_PRODUTO = C6_PRODUTO
	And DC_ITEM = C6_ITEM
	And DC_QUANT > '0'
	And SDC.D_E_L_E_T_ = ''

	Inner Join SBF010 SBF With(NoLock) --Saldos por Endereço      
	On BF_FILIAL = DC_FILIAL 
	And BF_PRODUTO = DC_PRODUTO
	And BF_LOCALIZ = DC_LOCALIZ 
	And BF_QUANT > 0 
	And SBF.D_E_L_E_T_ = ''

	Inner Join SZE010 SZE With(NoLock) -- Etiquetas de Bobinas
	On ZE_FILIAL = C6_FILIAL
	And ZE_PRODUTO = C6_PRODUTO
	And ZE_PEDIDO = C6_NUM 
	And ZE_ITEM = C6_ITEM
	And ZE_STATUS Not in  ('F','C')
	And SZE.D_E_L_E_T_ = ''


	Inner Join SZL010 SZL With(NoLock) -- Pesagem -- Status 
	On ZL_NUMBOB = ZE_NUMBOB
	And ZL_FILIAL = ZE_FILIAL
	And ZL_PRODUTO = ZE_PRODUTO
	And ZL_PEDIDO = ZE_PEDIDO 
	And ZL_ITEMPV = C6_ITEM
	And ZL_STATUS = 'P'
	And ZL_UNMOV <> ''
	And SZL.D_E_L_E_T_ = ''

	Left Join ZZF010 ZZF -- Controle sobre Retrabalho
	On ZZF_FILIAL = C6_FILIAL
	And ZZF_PEDIDO = C6_PEDCLI
	And ZZF_ITEMPV = C6_ITEM
	And ZZF_ID = ZE_CTRLE
	And ZZF.D_E_L_E_T_ = '	'


Where (C6_QTDVEN-C6_QTDENT) > 0 
And SC6.D_E_L_E_T_ = ''
Order By 10

--CTRL SEPARACAO PROATIVA       
Select ZZF_STATUS,ZL_NUM,ZL_NUMBOB,ZE_NUMBOB,ZL_ZZEID,ZZF_ZZEID,
* From ZZF010 ZZF

	Inner Join SZL010 SZL -- -- Pesagem -- Status 
	On ZL_ZZEID = ZZF_ZZEID
	And ZL_FILIAL = ZZF_FILIAL
	And ZL_PRODUTO = ZZF_PRODUT
	And ZL_STATUS = 'P'
	And ZL_UNMOV <> ''
	And SZL.D_E_L_E_T_ = ''

	Inner Join SZE010 SZE -- -- Etiquetas de Bobinas
	On ZE_NUMBOB = ZZF_NUMBOB
	And ZE_FILIAL = ZZF_FILIAL
	And ZE_PRODUTO = ZZF_PRODUT
	And ZE_STATUS Not in  ('F','C')
	And SZE.D_E_L_E_T_ = ''

	Inner Join SC6010 SC6
	On C6_NUM = ZZF_PEDIDO
	And C6_FILIAL = ZZF_FILIAL
	And C6_PRODUTO = ZZF_PRODUT
	And C6_ITEM = ZZF_ITEMPV
	And SC6.D_E_L_E_T_ = ''

Where ZZF.D_E_L_E_T_ = ''
--ZZF_SATATUS - 2=Ag.Sep;3=O.Sep.N.Imp;4=O.Sep.Imp;5=Sep.Parc;6=Sep.Tot;7=O.Ret.Imp;8=Ret.Parc;9=Ret.Tot;A=Dest.Fat                             



 


-- Campos
Select * From SX3010
Where X3_ARQUIVO = 'SZL'

--Tabelas
Select * From SX2010
Where X2_CHAVE = 'SZT'


--Composição do Empenho         
Select * From SDC010 SDC
Where DC_QUANT > '0'
And SDC.D_E_L_E_T_ = ''

--Saldos por Endereço           
Select * From SBF010 SBF
Where BF_QUANT > 0
And SBF.D_E_L_E_T_ = ''

-- PV Itens - Em Abertos
Select * From SC5010 SC5
Where C5_NOTA Not In ('','XXXXXX')
And SC5.D_E_L_E_T_ = ''


-- PV Cab - Itens e Lib
Select C9_QTDLIB,C6_QTDVEN,C6_QTDENT,C6_ITEMIMP,C6_ITEM,* From SC6010 SC6

	Inner Join SC5010 SC5 With(NoLock) -- PV Cab.
	On C5_FILIAL = C6_FILIAL
	And C5_NUM = C6_NUM
	And C5_NOTA Not In ('XXXXXX')
	And C5_NOTA = ('') -- PV em Aberto
	And SC5.D_E_L_E_T_ = ''

	Inner Join  SC9010 SC9 With(NoLock) -- PV Liberados 
	On C9_FILIAL = C6_FILIAL
	And C9_PEDIDO = C6_NUM
	And C9_PRODUTO = C6_PRODUTO
	And C9_ITEM = C6_ITEM
	And SC9.D_E_L_E_T_ = ''

Where C6_FILIAL In ('01')And C6_NUM In ('405045') And (C6_ITEM = '01' or C6_ITEMIMP = '01')
And SC6.D_E_L_E_T_ = ''

-- PV Liberados 
Select * From SC9010 SC9
Where C9_FILIAL In ('01') And C9_PEDIDO In ('405045') And (C9_ITEM = '01' or C9_ITEMREM = '01') 
And SC9.D_E_L_E_T_ = ''

--Etiquetas de Bobinas
Select * From SZE010 SZE
Where ZE_FILIAL = '01' and ZE_PEDIDO In ('405045') and ZE_PRODUTO In ('1320504401')
And ZE_STATUS Not in  ('F','C')
And D_E_L_E_T_ = ''

--Etiquetas de Bobinas
Select Sum(ZE_QUANT) From SZE010 SZE
Where ZE_FILIAL = '01' and ZE_PEDIDO In ('405408') and ZE_PRODUTO In ('2810704501') and ZE_ITEM = '11'
And ZE_STATUS Not in  ('F','C')
And D_E_L_E_T_ = ''

-- Pesagem 
Select * From SZL010
Where ZL_FILIAL = '01' and ZL_PEDIDO = '405408' and ZL_ITEMPV = '01'
And D_E_L_E_T_ = ''

-- --Composição do Empenho     
Select * From SDC010
Where DC_FILIAL = '01'and DC_PEDIDO = '405408' and DC_ITEM = '11' and DC_PRODUTO = '2810704501'
And D_E_L_E_T_ = ''

Select Sum(DC_QUANT) QUANT From SDC010
Where DC_FILIAL = '01'and DC_LOCALIZ = 'B00500' and DC_PRODUTO = '1320504401'
And D_E_L_E_T_ = ''


-- --Saldos por Endereço 
Select * From SBF010
Where BF_FILIAL = '01' and BF_PRODUTO = '1320504401' and BF_LOCALIZ = 'B00500'

-- Pesagem 
Select * From SZL010
Where ZL_FILIAL = '01' and ZL_PRODUTO = '2810704501' and ZL_PEDIDO = '405408' --and ZL_ITEMPV = '01'
and ZL_STATUS = 'P' And D_E_L_E_T_ = ''

Select Sum(ZL_METROS) From SZL010
Where ZL_FILIAL = '01' and ZL_PRODUTO = '2810704501' and ZL_PEDIDO = '405408' and ZL_ITEMPV = '11'
and ZL_STATUS = 'P' And D_E_L_E_T_ = ''


-- Retrabalho 
Select * From ZZF010
Where ZZF_FILIAL = '01' and ZZF_PEDIDO = '405408' and ZZF_ITEMPV = '01'
And D_E_L_E_T_ = ''

-- Etiquetas de Bobinas
SELECT ZE_FILIAL,ZE_PEDIDO, ZE_ITEM,ZE_PRODUTO, COUNT(*) As COUNT_ FROM SZE010 
WHERE 
 ZE_FILIAL = '01'
 AND ZE_DATA >= '20231001'
 AND D_E_L_E_T_ = ''
GROUP BY ZE_FILIAL,ZE_PEDIDO, ZE_ITEM,ZE_PRODUTO
HAVING COUNT(*) > 1


-- Composição do Empenho   
SELECT DC_FILIAL,DC_PEDIDO, DC_ITEM,DC_PRODUTO, COUNT(*) as COUNT_ FROM SDC010 
WHERE 
 DC_FILIAL = '01'
 AND DC_DTLIB >= '20231001'
 AND D_E_L_E_T_ = ''
GROUP BY DC_FILIAL,DC_PEDIDO, DC_ITEM,DC_PRODUTO
HAVING COUNT(*) > 1

Select BF_FILIAL,BF_PRODUTO,BF_LOCALIZ,BF_LOCAL, Count(*) as Count_ From SBF010
Where 
	BF_FILIAL = '01' and BF_QUANT > 0
	AND D_E_L_E_T_ = ''
Group By BF_FILIAL,BF_PRODUTO,BF_LOCALIZ,BF_LOCAL
HAVING COUNT(*) > 1



Declare @FILDE Char(2),@FILFIM Char(2), @DATADE Char(8), @DATAFIM Char(8), @CODPRODINI Char(10), @CODPRODFIM Char(10),
@PVNUMINI Char(6),@PVNUMFIM Char(6), @PVITEMINI Char(02), @PVITEMFIM Char(02), @DC_QUANT Real;

Set @FILDE = '01' 
Set @FILFIM = '01'
Set @DATADE = '20231001'
Set @DATAFIM = '20231031'
Set @CODPRODINI = '00000000'
Set @CODPRODFIM = '999999999'
Set @PVNUMINI = '405408'
Set @PVNUMFIM = '405408'
Set @PVITEMINI = '01'
Set @PVITEMFIM = '99'


-- PV Itens -- Itens Empenhados prduzidos
Select C6_FILIAL,C5_CLIENTE,A1_NOME,C6_NUM,C6_PRODUTO,B1_DESC,C6_ITEM,
Sum(C6_QTDVEN) As C6_QTDVEN,Sum(C6_QTDENT) As C6_QTDENT,Sum(C9_QTDLIB) As C9_QTDLIB,
Sum(C6_QTDVEN-C6_QTDENT) AS SALDO_PV, Sum(C6_QTDVEN-C9_QTDLIB) As BLOQ, 
Sum(C9_QTDLIB-C6_QTDENT) AS SALDO_LIB,

DC_QUANT = (Select Sum(DC_QUANT) From SDC010 SDC
			Where DC_FILIAL = C6_FILIAL and  DC_PEDIDO = C6_NUM And DC_PRODUTO = C6_PRODUTO 
			And DC_ITEM = C6_ITEM  And SDC.D_E_L_E_T_ = ''),

BF_END = (Select Count(BF_LOCALIZ) From SDC010 SDC
			
			Inner Join SBF010 SBF
			On BF_FILIAL = DC_FILIAL 
			And BF_PRODUTO = DC_PRODUTO
			And BF_LOCALIZ = DC_LOCALIZ 
			And BF_QUANT > 0 
			And SBF.D_E_L_E_T_ = ''

			Where DC_FILIAL = C6_FILIAL and  DC_PEDIDO = C6_NUM And DC_PRODUTO = C6_PRODUTO 
			And DC_ITEM = C6_ITEM  And SDC.D_E_L_E_T_ = ''),

ZZF_RETRABALHO = Isnull((Select Sum(ZZF_METRAS) From ZZF010 ZZF 
				   Where ZZF_FILIAL = C6_FILIAL
				   And ZZF_PEDIDO = C6_NUM
				   And ZZF_ITEMPV = C6_ITEM
				   And ZZF.D_E_L_E_T_ = ''),0),

PRODUZIR_GERAL = SUM(C6_QTDVEN-C6_QTDENT) - (Select Sum(DC_QUANT) From SDC010 SDC
			Where DC_FILIAL = C6_FILIAL and  DC_PEDIDO = C6_NUM And DC_PRODUTO = C6_PRODUTO 
			And DC_ITEM = C6_ITEM  And SDC.D_E_L_E_T_ = ''),

PRODUZIR_LIB = SUM(C9_QTDLIB-C6_QTDENT) - (Select Sum(DC_QUANT) From SDC010 SDC
			Where DC_FILIAL = C6_FILIAL and  DC_PEDIDO = C6_NUM And DC_PRODUTO = C6_PRODUTO 
			And DC_ITEM = C6_ITEM  And SDC.D_E_L_E_T_ = ''),

PROD_DIA_GERAL = Round((SUM(C6_QTDVEN-C6_QTDENT-C9_QTDLIB)-(Select Sum(DC_QUANT) From SDC010 SDC
			Where DC_FILIAL = C6_FILIAL and  DC_PEDIDO = C6_NUM And DC_PRODUTO = C6_PRODUTO 
			And DC_ITEM = C6_ITEM  And SDC.D_E_L_E_T_ = ''))/18,2),
			
PROD_DIA_LIB = Round((SUM(C9_QTDLIB-C6_QTDENT)-(Select Sum(DC_QUANT) From SDC010 SDC
			Where DC_FILIAL = C6_FILIAL and  DC_PEDIDO = C6_NUM And DC_PRODUTO = C6_PRODUTO 
			And DC_ITEM = C6_ITEM  And SDC.D_E_L_E_T_ = ''))/18,2),


DateDiff(Day,Max(C6_ENTREG),Getdate()) As DIAS_ATRASO,

ETIQUETAS_SZE = (Select Sum(ZE_QUANT) From SZE010 SZE
			Where ZE_FILIAL = C6_FILIAL
				And ZE_PRODUTO = C6_PRODUTO
				And ZE_PEDIDO = C6_NUM 
				And ZE_ITEM = C6_ITEM
				And ZE_STATUS Not in  ('F','C')
				And SZE.D_E_L_E_T_ = ''),

PESAGEM_SZL = (Select Sum(ZL_LANCE) From SZL010
Where ZL_FILIAL = C6_FILIAL and ZL_PRODUTO = C6_PRODUTO and ZL_PEDIDO = C6_NUM and ZL_ITEMPV = C6_ITEM
and ZL_STATUS = 'P' And D_E_L_E_T_ = '')


From SC6010 SC6 With(NoLock) -- PV Itens

	Inner Join SC5010 SC5 With(NoLock) -- PV Cab.
	On C5_FILIAL = C6_FILIAL
	And C5_NUM = C6_NUM
	And C5_NOTA Not In ('XXXXXX')
	And C5_NOTA = ('') -- PV em Aberto
	And SC5.D_E_L_E_T_ = ''

	Left Join  SC9010 SC9 With(NoLock) -- PV Liberados 
	On C9_FILIAL = C6_FILIAL
	And C9_PEDIDO = C6_NUM
	And C9_PRODUTO = C6_PRODUTO
	And C9_ITEM = C6_ITEM
	And SC9.D_E_L_E_T_ = ''

	Inner Join SB1010 SB1  With(NoLock) -- Produtos 
	On B1_COD = C6_PRODUTO
	And SB1.D_E_L_E_T_ = ''


	Inner Join SA1010 SA1  With(NoLock) -- Clientes 
	On A1_COD = C5_CLIENTE
	And A1_LOJA = C5_LOJACLI
	And SA1.D_E_L_E_T_ = ''

Where C6_FILIAL Between @FILDE and @FILFIM  And C6_NUM Between @PVNUMINI and @PVNUMFIM and 
C6_ITEM Between @PVITEMINI  and @PVITEMFIM
--
And SC6.D_E_L_E_T_ = ''
Group By C6_FILIAL,C5_CLIENTE,A1_NOME,C6_NUM,C6_PRODUTO,B1_DESC,C6_ITEM
Order By C6_FILIAL,C6_NUM,C6_PRODUTO

-- SC6 - PV Itens 
-- SC5 - PV Cab.
-- SC9 - PV Liberado 
-- SZE - Etiquetas de Bobinas
-- SZL - Pesagem -- Status 
-- ZZF -- Controle sobre Retrabalho







Select CURRENT_TIMESTAMP AS DATA_, DATENAME (Month,GETDATE()) AS MES_NOME,DATEPART(WeekDay,GETDATE()) As DIA 